import SwiftUI

@main
struct ScriptFlowApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .statusBarHidden(false)
                .persistentSystemOverlays(.hidden)
        }
    }
}
