# ScriptFlow — iOS

Swift Package iOS app (`.iOSApplication` product). No `.xcodeproj`, no CocoaPods, no wizard.

## Open + run

```bash
open /Users/shivamitankar/scriptflow/ios/Package.swift
```

Xcode reads `Package.swift` and treats the folder as an iOS app project. Pick a simulator or your device, hit Run.

## Ship to App Store

1. `Package.swift` → set `teamIdentifier` to your Apple Developer Team ID (find it at https://developer.apple.com/account → Membership).
2. Bump `bundleVersion` (`"1"` → `"2"` …) every upload. Bump `displayVersion` (`"1.0"` → `"1.1"` …) for public-facing version bumps.
3. Product → **Archive** (real device or "Any iOS Device", not a simulator).
4. Organizer opens → **Distribute App** → **App Store Connect** → **Upload**.
5. On [App Store Connect](https://appstoreconnect.apple.com): create the app record (bundle ID `com.studio4by5.scriptflow`), fill metadata + screenshots + privacy policy URL, attach the build, submit for review.

## Native features (already wired via `ContentView.swift`)

The bundled `index.html` detects `window.webkit.messageHandlers.scriptflow` and routes to native:

- **Export button** → `UIActivityViewController` (iOS share sheet)
- **Countdown warning (last 2s)** → warning haptic
- **Session end** → success haptic

These are the App Review Guideline 4.2 hook — a pure webview would get rejected.

## Update the app after web changes

Root `index.html` is the source of truth. Before archiving a new build:

```bash
cp /Users/shivamitankar/scriptflow/index.html /Users/shivamitankar/scriptflow/ios/www/index.html
```

Bump `bundleVersion` in `Package.swift`. Archive. Done.

## Swap the icon

Replace `Assets.xcassets/AppIcon.appiconset/icon-1024.png` with a real 1024×1024 PNG (no alpha channel). The current one is a placeholder.
