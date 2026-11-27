# CalmCampus iOS app (CalmApp)

This repository is the native iOS app: SwiftUI + SwiftData, XcodeGen, in `ios/`. The website lives in [CalmCampus-FV/CalmWeb](https://github.com/CalmCampus-FV/CalmWeb), university demos and the reviewer preview web app in [CalmCampus-FV/CalmUni](https://github.com/CalmCampus-FV/CalmUni), company demos in [CalmCampus-FV/CalmBiz](https://github.com/CalmCampus-FV/CalmBiz). The earlier monorepo [CalmCampus-FV/CalmCampus](https://github.com/CalmCampus-FV/CalmCampus) is now the research and design archive; its old copy of `ios/` was removed (it stays in that repo's history). App changes belong in this repo.

## Layout

- `ios/` - the iOS app (SwiftUI + SwiftData, XcodeGen).
  - `CalmCampus/` is the public v1 weekly check-in: `Weekly/` (questions, scoring, language, pure and unit-tested), `Data/WeeklyAnswer` (one row per question per week), `Localization/Strings.swift` (all copy in en/fr/nl), `Support/` (institution and emergency data from the Quivr config), `Reminder/` (local weekly notification), `Views/`.
  - `Legacy/` holds the earlier daily adaptive check-in and HealthKit sleep and step code. It is not in the app target. The pure planner (`Legacy/Daily/Checkin`, minus the view) and its tests still compile into the test target so they stay green. HealthKit entitlements live in `Legacy/Daily/CalmCampus.entitlements`; restore them only when the daily product ships.
- `design/brand/` - app icon and colour palette.

## Public v1 (implemented in `ios/CalmCampus`)

The first public App Store / TestFlight version is a weekly check-in students can download themselves, not a university-branded preview and not the daily HealthKit product.

- Four skippable yes/no questions about the past week, then a result screen, history, support and about.
- Languages: English, French and Dutch. Default to the device language when it is one of those three.
- Full disclaimer on every screen: we are students, not medical professionals; CalmCampus does not diagnose or treat; we strongly suggest a doctor or student support. Answers stay on the phone.
- No accounts, no analytics, no tracking, no HealthKit in v1. Keep the existing daily / HealthKit code in the repo but out of the v1 UI (move it aside, do not delete it).
- No detection or "early signs" claims, no claim the app finds burnout, and no claim it gets students to seek help.
- User-facing copy: no em dashes, and keep the ù in Braùn. `WordingTests` enforces the banned words (detect, diagnosis, early signs, burnout, time in seconds) across all three languages; add new copy to `Strings.swift` so it is checked.
- Scoring counts yes answers only (0 steady, 1 notice, 2 support, 3+ care). Never show a count like "3 of 4".

## Commands

```bash
cd ios && xcodegen generate && open -a Xcode CalmCampus.xcodeproj
xcodebuild test -project ios/CalmCampus.xcodeproj -scheme CalmCampus \
  -destination 'platform=iOS Simulator,name=CC Test iPhone'
```

`.xcodeproj` files are generated from `project.yml` (XcodeGen) and gitignored. Edit `project.yml`, not the project.

CI (`.github/workflows/ci.yml`) runs the iOS unit tests on `macos-15` with `CODE_SIGNING_ALLOWED=NO`.

## Principles

- **All data stays on-device.** No cloud AI or analytics. On-device AI only (Apple Foundation Models / Gemini Nano), and not in public v1. The old Flutter version sent user text to Groq: do not reintroduce that.
- **No synthetic data in the product.** Every signal is real, missing, or unavailable; never fabricated. Labelled examples belong only to the web reviewer previews in CalmUni.
- **Check-in questions:** never change a question `id`; bump `version` when wording or options change. No clinical screeners (PHQ/GAD, scored cutoffs) or self-harm items. Every question is skippable.
- **Wellness wording, not medical claims** ("supports", not "detects burnout") - EU MDR risk, and Apple guideline 1.4.1.
