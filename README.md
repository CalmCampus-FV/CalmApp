# CalmCampus for iPhone

**A privacy-first wellness check-in for university students. All answers stay on the phone.**

[![CI](https://github.com/CalmCampus-FV/CalmApp/actions/workflows/ci.yml/badge.svg)](https://github.com/CalmCampus-FV/CalmApp/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

[cc.braunf.com](https://cc.braunf.com/)

CalmCampus is a short check-in that helps students pause and find existing student support if they want it. It does not diagnose or treat anything, and it does not replace a doctor or student services.

> We are students, not medical professionals. CalmCampus does not diagnose or treat. If you need help, we strongly suggest a doctor or your student support service. If you are in crisis, contact your local emergency number or a crisis line.

## Status

This repository holds the native iOS app (SwiftUI + SwiftData, iOS 17+). The current code is a daily adaptive check-in with optional HealthKit sleep and step signals, used only to order follow-up questions. The first public version, for TestFlight and later the App Store, will be a weekly check-in of four questions, in English, French and Dutch, with no HealthKit, no accounts and no analytics.

The website lives in [CalmCampus-FV/CalmWeb](https://github.com/CalmCampus-FV/CalmWeb), university demos in [CalmCampus-FV/CalmUni](https://github.com/CalmCampus-FV/CalmUni), company demos in [CalmCampus-FV/CalmBiz](https://github.com/CalmCampus-FV/CalmBiz), and the research and design archive in [CalmCampus-FV/CalmCampus](https://github.com/CalmCampus-FV/CalmCampus).

## Getting started

You need macOS with full Xcode and [XcodeGen](https://github.com/yonaskolb/XcodeGen) (`brew install xcodegen`). The `.xcodeproj` files are generated from `ios/project.yml` and are not committed.

```bash
cd ios && xcodegen generate && open -a Xcode CalmCampus.xcodeproj

xcodebuild test -project ios/CalmCampus.xcodeproj -scheme CalmCampus \
  -destination 'platform=iOS Simulator,name=iPhone 16'
```

## Design principles

- All data stays on the phone. No cloud storage, analytics or accounts.
- Wellness wording, not medical claims.
- Every check-in question can be skipped.

## Team

- Florian Braùn
- Hélène David

## License

[MIT](LICENSE) © 2026 Florian Braùn, Hélène David.
