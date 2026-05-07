# Codebase Snapshot — graduation_project (Signlingo)

> Cache fingerprint for incremental analysis. Used by /resume and /analyze-codebase to detect changes.

## Last Full Scan

- **Date:** 2026-05-08
- **Commit:** `f2fd7fca928fa402f6c57a834288bda493878897`
- **Branch:** `main`
- **Working tree:** dirty — 13 modified files, several untracked (build dumps, new VoiceTranslation feature, `hand_landmarker.task`)

## Counts

| Metric | Value |
|--------|-------|
| Dart files in `lib/` | 137 |
| Dart files in `test/` | 1 |
| Cubit pairs | 14 (Auth×6, Categories, Dictionary, Lessons, Profile, Quiz, Search, SendFrames, VoiceTranslation) |
| Screen files in `lib/presentation/` (≤2 levels) | 37 |
| Data models | 7 |
| API services | 6 |
| Repositories | 1 (AuthRepo only) |
| Production deps in pubspec.yaml | 19 |
| TODO / FIXME / HACK / XXX comments | 5 |
| Target platforms scaffolded | 6 (android, ios, web, windows, macos, linux) |

## File manifest — top 15 by size (proxy for complexity)

| Bytes | File |
|-------|------|
| 51,703 | lib/generated/l10n.dart |
| 30,484 | lib/generated/intl/messages_ar.dart |
| 25,707 | lib/generated/intl/messages_en.dart |
| 16,535 | lib/presentation/Quiz/Quiz.dart |
| 15,577 | lib/presentation/Profile/ProfileScreen2.dart |
| 14,216 | lib/presentation/PlayVideo/VideoScreen.dart |
| 14,167 | lib/presentation/VideoTranslation/handtrackingview.dart |
| 12,452 | lib/presentation/Profile_information/Profile_information.dart |
| 12,099 | lib/presentation/VoiceTranslation/voice_translation_page.dart |
| 11,284 | lib/presentation/QuickRespose/quickresponse.dart |
| 9,791 | lib/presentation/VideoTranslation/VideoTranslationScreen.dart |
| 8,353 | lib/data/Services/sign_language_classifier.dart |
| 7,719 | lib/presentation/Quiz/quiz_chat.dart |
| 7,218 | lib/presentation/About us screens/HelpCenter.dart |
| 6,867 | lib/presentation/QuizResult/QuizResult.dart |

## Recent commit history (last 10)

```
f2fd7fc Full Arabic/English localization for all screens, fix emit-after-close crash
2302591 Profile: logout/delete dialogs, profile info API wiring, mode switch navigation
0f4abcd Finishing Quiz feature: API integration, cubit, UI wiring, review & share
2cf9d22 too much edits i don't remeber
5b22ad6 finishing DictionaryCubit except allowing arabic and english search
2364d84 Finishing categouries cubit/ lesson / progress temproraly
743b47e Finishing auth feature
527e859 edit otpscreen,making forgetpass , login, signup,otp cubits
1cbb819 Finishing the whole ui of mode1
a5e8ee9 Finishing lessons screen
```

## Cache invalidation rules

Re-run `/analyze-codebase` (or let `/resume` trigger it) when **any** of the following change since this snapshot:

| Trigger | What to refresh |
|---------|-----------------|
| `lib/` file count differs from 137 | `current-features.md` + this manifest |
| `pubspec.yaml` or `pubspec.lock` modified | `architecture.md` (stack table), `technical-debt.md` |
| New folder under `lib/business_logic/` | `current-features.md`, `architecture.md` |
| New `*ApiService.dart` or `*Repo.dart` under `lib/data/` | `architecture.md` (data section), `technical-debt.md` (#2 may resolve) |
| New file under `test/` | `technical-debt.md` (test coverage section) |
| Platform folder added/removed (e.g. `linux/`) | `architecture.md` (target platforms), `deployment-status.md` |
| `.github/workflows/` appears | `deployment-status.md` (CI section) |
| HEAD commit changes | this file (`Last Full Scan`) and the recent-commits block |
