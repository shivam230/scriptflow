import SwiftUI
import WebKit
import UIKit

/// Full-screen WKWebView hosting the bundled ScriptFlow web app.
/// - Loads `www/index.html` from the app bundle (offline, no network).
/// - Bridges Export → iOS share sheet.
/// - Bridges countdown-warning + session-end to native haptics.
struct WebView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()

        let ucc = WKUserContentController()
        ucc.add(context.coordinator, name: "scriptflow")
        config.userContentController = ucc

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = context.coordinator
        webView.navigationDelegate = context.coordinator
        webView.scrollView.bounces = false
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.isOpaque = false
        let bg = UIColor(named: "LaunchBackground")
        webView.backgroundColor = bg
        webView.scrollView.backgroundColor = bg
        context.coordinator.webView = webView

        if let www = Bundle.main.url(forResource: "www", withExtension: nil) {
            let index = www.appendingPathComponent("index.html")
            webView.loadFileURL(index, allowingReadAccessTo: www)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    final class Coordinator: NSObject, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
        weak var webView: WKWebView?
        private let notify = UINotificationFeedbackGenerator()
        private let light  = UIImpactFeedbackGenerator(style: .light)
        private let medium = UIImpactFeedbackGenerator(style: .medium)
        private let heavy  = UIImpactFeedbackGenerator(style: .heavy)

        func userContentController(_ ucc: WKUserContentController,
                                   didReceive message: WKScriptMessage) {
            guard message.name == "scriptflow",
                  let body = message.body as? [String: Any],
                  let action = body["action"] as? String else { return }
            switch action {
            case "share":
                if let text = body["text"] as? String { share(text) }
            case "haptic":
                let style = body["style"] as? String ?? "light"
                switch style {
                case "warn":    notify.notificationOccurred(.warning)
                case "success": notify.notificationOccurred(.success)
                case "medium":  medium.impactOccurred()
                case "heavy":   heavy.impactOccurred()
                default:        light.impactOccurred()
                }
            default: break
            }
        }

        private func share(_ text: String) {
            DispatchQueue.main.async {
                let vc = UIActivityViewController(activityItems: [text], applicationActivities: nil)
                if let pop = vc.popoverPresentationController, let view = self.webView {
                    pop.sourceView = view
                    pop.sourceRect = CGRect(x: view.bounds.midX, y: view.bounds.midY, width: 0, height: 0)
                    pop.permittedArrowDirections = []
                }
                Self.rootController()?.present(vc, animated: true)
            }
        }

        private static func rootController() -> UIViewController? {
            UIApplication.shared.connectedScenes
                .compactMap { $0 as? UIWindowScene }
                .flatMap { $0.windows }
                .first { $0.isKeyWindow }?
                .rootViewController
        }
    }
}
