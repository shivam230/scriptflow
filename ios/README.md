# ScriptFlow — iOS

Native SwiftUI shell that hosts the web app in a WKWebView, plus two native features so Apple's Guideline 4.2 (min functionality) passes review:

- **Native share sheet** on Export (replaces the browser print popup)
- **Haptic feedback** at countdown warning + session-end

Web app is bundled — no network needed to run.

---

## First-time setup (do this once)

1. **Xcode → File → New → Project**
   - Template: **App** (iOS)
   - Product Name: `ScriptFlow`
   - Team: your paid Apple Developer team
   - Organization Identifier: `com.studio4by5` (bundle ID becomes `com.studio4by5.scriptflow`)
   - Interface: **SwiftUI**
   - Language: **Swift**
   - Storage: **None**
   - Uncheck tests + Core Data.
   - Save location: `/Users/shivamitankar/scriptflow/ios/` — Xcode will nest an `ios/ScriptFlow/` inside; when it asks about the existing folder, let it merge or move the wizard files aside first.

2. **Replace the two default Swift files** with the ones in this folder:
   - `ScriptFlow/ScriptFlowApp.swift` → use `ios/ScriptFlow/ScriptFlowApp.swift`
   - `ScriptFlow/ContentView.swift` → use `ios/ScriptFlow/ContentView.swift`

3. **Add the web bundle** to the app target:
   - In Xcode, right-click the `ScriptFlow` group → **Add Files to "ScriptFlow"…**
   - Select the `www/` folder from this directory
   - Options: ✅ *Copy items if needed*, ✅ *Create folder references* (blue folder, NOT yellow group), Add to target: `ScriptFlow`
   - Confirm the `www` folder shows in the sidebar as a **blue** folder icon — that's what makes `Bundle.main.url(...subdirectory:"www")` resolve.

4. **Add the app icon**:
   - Open `Assets.xcassets` → `AppIcon`
   - Drop `AppIcon-1024.png` from this folder into the 1024×1024 well (single-size icon slot on modern Xcode)
   - Swap for a real icon later; this is a placeholder.

5. **Info.plist tweaks** (Target → Info):
   - Add `NSAppTransportSecurity` → `NSAllowsArbitraryLoads` = `NO` (default). The app only loads bundled files so ATS restrictions don't matter.
   - Interface Orientation (iPhone): Portrait only, unless you want landscape too.
   - Status Bar Style: Light Content (matches dark theme).

6. **Signing**: Target → Signing & Capabilities → pick your team. Xcode auto-provisions.

7. **Run** on a simulator or your phone. You should see the app, be able to type, hit Export → iOS share sheet opens, haptics fire on the countdown warning.

---

## Ship a version to the App Store

1. **Bump version + build**: Target → General → Version `1.0.0`, Build `1` (increment build every upload).
2. **Product → Archive** (must be a real device or "Any iOS Device", not a simulator).
3. **Organizer opens** → select the archive → **Distribute App** → **App Store Connect** → **Upload** → follow prompts.
4. On [App Store Connect](https://appstoreconnect.apple.com):
   - Create the app record (name, bundle ID must match).
   - Fill: description, keywords, category (Productivity), age rating, screenshots (6.7" and 6.1" required minimum), support URL, privacy policy URL.
   - Add build → submit for review.
5. First review takes 24–72h. Rejection is common on round 1 for webview-heavy apps — the share sheet + haptics + bundled offline content should be enough to pass 4.2 but be ready to justify in review notes.

---

## Updating the app after web changes

Root `index.html` is the source of truth. When you change it and want a new build:

```bash
cp /Users/shivamitankar/scriptflow/index.html /Users/shivamitankar/scriptflow/ios/ScriptFlow/www/index.html
```

Then bump Build number in Xcode → Archive → upload. Done.

If you'd rather not remember the `cp`, add this as a Build Phase Run Script in Xcode (Target → Build Phases → + → New Run Script Phase):

```bash
cp "$SRCROOT/../index.html" "$SRCROOT/ScriptFlow/www/index.html"
```

That runs the copy on every build automatically.

---

## What was skipped

- No Capacitor / Cordova / Ionic — pure Swift + WKWebView is fewer moving parts.
- No CocoaPods — nothing to install.
- No custom URL scheme, universal links, push notifications, or in-app purchases — add when needed.
- Splash screen uses the SwiftUI default (LaunchScreen storyboard). Xcode's default is fine; customize later.
