# ScriptFlow — App Store Connect Submission Sheet

Everything App Store Connect will ask for. Copy-paste values are ready; anything in `<angle brackets>` is yours to fill.

---

## 0 · Pre-submission checklist

- [ ] Real app icon shows in the simulator (⇧⌘K then ⌘R if it doesn't)
- [ ] Signing team picked in Xcode (Target → Signing & Capabilities)
- [ ] Bundle Version + Marketing Version set (`1` and `1.0` for the very first build)
- [ ] Archive builds clean (Product → Archive on "Any iOS Device")
- [ ] Privacy Policy page live at a public URL (see §7)
- [ ] Support URL live at a public URL (see §7)
- [ ] Screenshots exported at 6.7"/6.9" and 6.1"/6.3" (see §6)

---

## 1 · App Information (one-time, set on the app record)

| Field | Value |
|---|---|
| **Bundle ID** | `com.studio4by5.scriptflow` |
| **SKU** | `SCRIPTFLOW-001` (internal only, never shown; must be unique across your account) |
| **Primary Language** | English (U.S.) |
| **Primary Category** | Productivity |
| **Secondary Category** | Lifestyle *(optional)* |
| **Content Rights** | ☑ Does not use third-party content |
| **Age Rating** | 4+ (walk through the questionnaire, answer *None* to everything) |

---

## 2 · Version Info (per version — this is the 1.0 form)

### Name & subtitle

| Field | Char limit | Suggested value |
|---|---|---|
| **App Name** | 30 | `ScriptFlow` |
| **Subtitle** | 30 | `Write live. Never look back.` (28) |
| **Promotional Text** | 170 | `A forward-only writing surface. No backspace, no copy-paste — pause too long and the page resets. Built for freewriting, hooks, first drafts.` |

Alt subtitles if the first is taken:
- `One take. No backspace.` (22)
- `Editorial forward-writing app` (29)
- `Ideas without a delete key` (26)

### Description (4000 chars max)

```
ScriptFlow is a forward-only writing surface for people who overthink first drafts.

Start typing. If you stop for more than seven seconds, the whole page resets. There's no backspace. No copy or paste. You can't go back, only forward — and that's the point.

WHY IT WORKS
The tools you write in matter. When editing is one keystroke away, you edit. When it isn't, you write. ScriptFlow removes the escape hatches so the words that come out are actually yours — unpolished, honest, and moving.

WHAT IT'S FOR
• Reel and TikTok scripts you'd rather record raw than rehearse
• Journal entries where you keep censoring yourself
• Hooks, opening lines, and headline sprints
• Freewriting when you're staring at a blank page
• Warming up before real writing sessions

HOW IT WORKS
1. Tap and start writing. Ink fades in as you type.
2. If you pause, a countdown appears. Keep writing to dismiss it.
3. Reach zero and the page clears — the session is captured.
4. Name it, share it via iMessage, Mail, Notes, or save to Files.

WHAT'S NOT HERE
• No autosave history — sessions live only long enough to share
• No accounts, no cloud, no sign-in
• No analytics, no tracking, no ads
• Nothing collected. Nothing sent. Everything happens on your device.

Made in India by Studio 4by5.
```

### Keywords (100 chars comma-separated, no spaces after commas)

```
writing,notes,journal,freewriting,script,ideas,focus,brainstorm,creativity,minimal,timer,ADHD
```
*(96 chars — under the 100 limit.)*

### URLs

| Field | Value |
|---|---|
| **Marketing URL** *(optional)* | `https://scriptfloww.netlify.app` |
| **Support URL** *(required)* | `https://scriptfloww.netlify.app/support` *(or the GitHub repo — must return HTTP 200)* |
| **Privacy Policy URL** *(required)* | `https://scriptfloww.netlify.app/privacy` |

### Copyright

`© 2026 Studio 4by5`

---

## 3 · App Privacy (Privacy questionnaire)

### Data collection

**Question**: "Do you or your third-party partners collect data from this app?"
→ **No**

That single answer skips the rest of the questionnaire. ScriptFlow makes no analytics calls, no crash reports, no identifiers.

### One caveat

The app loads Manrope from **fonts.googleapis.com** for typography. This is a static asset fetch; Google doesn't set cookies for `fonts.googleapis.com` and it isn't considered data collection under Apple's definition. If a reviewer questions it, cite: no cookies, no identifiers sent, static CSS only. If you want to be extra-safe, self-hosting the font later is a two-file swap.

### PrivacyInfo.xcprivacy

Already in the project at `ScriptFlow/PrivacyInfo.xcprivacy`. Declares:
- No tracking
- No collected data types
- No required-reason APIs used

---

## 4 · App Review Information (critical for webview apps)

### Sign-in

☑ Sign-in NOT required.

### Contact information

| Field | Value |
|---|---|
| First name | `<Shivam>` |
| Last name | `<Itankar>` |
| Phone | `<your phone with country code, e.g. +91 …>` |
| Email | `<your email>` |

### Notes for the App Reviewer *(paste this exact text)*

```
ScriptFlow is a forward-only writing app. Type into the editor and pause for 7 seconds to see the full loop: a countdown starts at 2 s, and the page resets to blank at 7 s, opening a session-complete sheet with an Export button.

NATIVE FUNCTIONALITY (not a webview wrapper):
1. Export button invokes UIActivityViewController (iOS share sheet) via WKScriptMessageHandler — reachable inside the completion sheet after a session ends.
2. Native haptic feedback fires on the countdown warning (last 2 seconds) and on session-end, via UIImpactFeedbackGenerator / UINotificationFeedbackGenerator.
3. All content is bundled — the app runs fully offline. No login, no server calls except Google Fonts CSS for typography.
4. No user data is collected, transmitted, or stored beyond the current in-memory session.

The web-technology surface is deliberate: the ink-fade typing effect, the paper aesthetic, and the print-formatted export are HTML/CSS. The native shell provides platform-quality share and haptics that a pure PWA cannot.
```

*This addresses Guideline 4.2 (minimum functionality). Webview-only apps get rejected; the share sheet + haptics + offline bundle are the answer.*

---

## 5 · Pricing & Availability

| Field | Value |
|---|---|
| **Price** | Free |
| **Availability** | All countries and regions |
| **Pre-orders** | Off |
| **App Distribution** | Public on App Store |

*If you plan to charge later, you can switch a free app to paid with a version update — but not the other way around without a new SKU. Ship free.*

---

## 6 · Screenshots

Apple currently requires only the largest iPhone size. Recommended: also submit 6.1"/6.3".

| Device size | Pixel dimensions | Notes |
|---|---|---|
| **6.7"/6.9" (iPhone 16 Pro Max)** | **1290 × 2796** | REQUIRED |
| 6.1"/6.3" (iPhone 16 Pro) | 1179 × 2556 | Recommended |

Take them from the simulator:
- Boot **iPhone 16 Pro Max** in the Simulator
- **⌘S** saves a PNG to Desktop
- Repeat for **iPhone 16 Pro**

Suggested shot list (3–5 is enough):

1. **The empty state** — placeholder visible, credit line at bottom.
2. **Mid-writing** — a few sentences typed, session tag showing "Writing", word count.
3. **Countdown fired** — ring visible at top, "Resetting in 3s".
4. **Session complete** — modal open with title input focused, preview visible.
5. **Share sheet** — Export tapped, iOS share sheet slid up.

Optional captions (10-word marketing lines on each screenshot) are set in App Store Connect, not baked into the image.

---

## 7 · Public URLs to create *(you need these before submitting)*

Two pages must return HTTP 200 at the URLs listed in §2.

### `/privacy` and `/support`

Add two files to the scriptflow repo, deploy to Netlify:

**scriptflow/privacy.html**
```html
<!doctype html>
<html><head><meta charset="utf-8"><title>ScriptFlow · Privacy</title>
<style>body{font-family:system-ui;max-width:640px;margin:48px auto;padding:0 24px;line-height:1.7;color:#1c1c1c}</style>
</head><body>
<h1>Privacy</h1>
<p>ScriptFlow does not collect, transmit, or store any personal data.</p>
<p>Everything you write stays on your device. There are no accounts, no analytics, no tracking, no ads, and no server calls except loading Manrope font stylesheets from Google Fonts (a static CSS request, no cookies or identifiers).</p>
<p>Sessions are held only in browser memory and clear when the timer resets or the app closes. Nothing you write is sent anywhere.</p>
<p>Contact: <a href="mailto:hello@studio4by5.com">hello@studio4by5.com</a></p>
<p><small>Last updated: 2026-09-01. ScriptFlow is built by Studio 4by5.</small></p>
</body></html>
```

**scriptflow/support.html**
```html
<!doctype html>
<html><head><meta charset="utf-8"><title>ScriptFlow · Support</title>
<style>body{font-family:system-ui;max-width:640px;margin:48px auto;padding:0 24px;line-height:1.7;color:#1c1c1c}</style>
</head><body>
<h1>Support</h1>
<p>ScriptFlow is a forward-only writing app. Type; if you pause for more than seven seconds, the page resets.</p>
<h2>Common questions</h2>
<p><b>Where did my text go?</b> Sessions clear on purpose. If you want to keep one, use the Export button in the session-complete sheet before starting a new one.</p>
<p><b>Why can't I use backspace?</b> By design. The point is to write past mistakes instead of editing them.</p>
<p><b>Does it work offline?</b> Yes. The only network request is a stylesheet for the Manrope font; the app still works without it.</p>
<p>Get in touch: <a href="mailto:hello@studio4by5.com">hello@studio4by5.com</a></p>
</body></html>
```

Deploy: `git commit && git push` (Netlify auto-deploys if you connected the repo) — or `npx netlify deploy --prod --dir .`

Verify the URLs load before pasting them into App Store Connect.

---

## 8 · Build upload flow (from Xcode)

1. Xcode toolbar → change device from a simulator to **"Any iOS Device (arm64)"**
2. **Product → Archive**
3. Organizer opens automatically → select the archive → **Distribute App** → **App Store Connect** → **Upload** → follow prompts (Xcode handles signing).
4. Wait ~10 min for the build to appear in App Store Connect under **TestFlight → Builds** (email arrives when done).
5. Attach the build to your 1.0 version submission, hit **Add for Review**.

### Every future version

- Bump `MARKETING_VERSION` (1.0 → 1.0.1 for a fix, → 1.1 for a feature) — Xcode Target → General.
- Bump `CURRENT_PROJECT_VERSION` (1 → 2 → 3 …) every single upload, always.
- If you changed the web app first: `cp /Users/shivamitankar/scriptflow/index.html /Users/shivamitankar/scriptflow/ios/ScriptFlow/www/index.html`
- Archive → Distribute → Upload.

---

## 9 · Rejection escape hatches

If the reviewer flags Guideline 4.2 despite §4:

- Reply with the exact "Notes for App Reviewer" text again, highlighting the two native features (share, haptics) and the offline bundle.
- Add a screen recording (App Store Connect accepts a video) showing the share sheet appearing and the haptic-triggering countdown.
- Offer a demo video URL.

If they push back further, the fastest additional native feature to add:
- **iOS Files integration**: save the exported script as a `.txt` via `UIDocumentPickerViewController`. ~30 lines of Swift, decisive win.
