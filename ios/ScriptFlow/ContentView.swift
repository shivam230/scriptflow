import SwiftUI
import WebKit
import UIKit

struct ContentView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let cfg = WKWebViewConfiguration()
        cfg.userContentController.add(context.coordinator, name: "scriptflow")

        let web = WKWebView(frame: .zero, configuration: cfg)
        web.scrollView.bounces = false
        web.isOpaque = false
        let bg = UIColor(red: 0x20/255, green: 0x06/255, blue: 0x17/255, alpha: 1)
        web.backgroundColor = bg
        web.scrollView.backgroundColor = bg

        if let url = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "www") {
            web.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        context.coordinator.webView = web
        return web
    }

    func updateUIView(_ webView: WKWebView, context: Context) {}

    final class Coordinator: NSObject, WKScriptMessageHandler {
        weak var webView: WKWebView?

        func userContentController(_ controller: WKUserContentController, didReceive message: WKScriptMessage) {
            guard let body = message.body as? [String: Any],
                  let action = body["action"] as? String else { return }
            switch action {
            case "share":
                if let text = body["text"] as? String { share(text) }
            case "haptic":
                haptic(body["style"] as? String ?? "light")
            default:
                break
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

        private func haptic(_ style: String) {
            DispatchQueue.main.async {
                switch style {
                case "warn":
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                case "success":
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                default:
                    let map: [String: UIImpactFeedbackGenerator.FeedbackStyle] = [
                        "light": .light, "medium": .medium, "heavy": .heavy
                    ]
                    UIImpactFeedbackGenerator(style: map[style] ?? .light).impactOccurred()
                }
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
