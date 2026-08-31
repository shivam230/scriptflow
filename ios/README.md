# ScriptFlow — iOS

Real `.xcodeproj` (same pattern as WaterHoop / Windchime). SwiftUI + WKWebView wrapping the bundled web app. No CocoaPods, no SPM deps, no Capacitor.

## Open + run

```bash
open /Users/shivamitankar/scriptflow/ios/ScriptFlow.xcodeproj
```

Pick a simulator (or your phone), hit ▶.

## Native features wired via `WebView.swift`

`index.html` detects `window.webkit.messageHandlers.scriptflow` and routes to native:

- **Export button** → `UIActivityViewController` (iOS share sheet)
- **Countdown warning (last 2s)** → warning haptic
- **Session end** → success haptic

These satisfy App Review Guideline 4.2 (webview-only apps get rejected).

## Ship to App Store

1. Xcode → target → **Signing & Capabilities** → pick your Apple Developer team.
2. Bump `MARKETING_VERSION` and `CURRENT_PROJECT_VERSION` in the target's Build Settings.
3. Change device target from a simulator to **"Any iOS Device (arm64)"**.
4. **Product → Archive**.
5. Organizer → **Distribute App → App Store Connect → Upload**.
6. On [App Store Connect](https://appstoreconnect.apple.com): create the app record (bundle ID `com.studio4by5.scriptflow`), fill metadata + screenshots + support URL + privacy policy URL, attach the build, submit for review.

## After a web change

Root `index.html` is the source of truth. Before archiving:

```bash
cp /Users/shivamitankar/scriptflow/index.html /Users/shivamitankar/scriptflow/ios/ScriptFlow/www/index.html
```

## Real app icon

Replace `ScriptFlow/Assets.xcassets/AppIcon.appiconset/icon-1024.png` (1024×1024 PNG, no alpha).
