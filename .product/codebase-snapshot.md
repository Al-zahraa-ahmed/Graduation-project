# Codebase Snapshot — graduation_project (Signlingo)

> Cache fingerprint for incremental analysis. Used by /resume and /analyze-codebase to detect changes.

## Last Full Scan

- **Date:** 2026-06-18 (incremental refresh; previous refresh 2026-05-23; full scan 2026-05-08)
- **Commit:** `fa06aa3` (the big audit-pass batch that was uncommitted at the last two snapshots has **finally landed** — `ef92bb5` → `fa06aa3`; debt #9 largely resolved)
- **Branch:** `main`
- **Working tree:** dirty — 11 modified + 1 new untracked feature folder (`lib/business_logic/Auth/GoogleAuth/`). Modified: categories_cubit, dictionary_cubit, GoogleOrFacebook.dart, the 4 localization files, gradle.properties, pubspec.yaml/lock, a macOS plugin registrant. `AppSnackBar.dart` + `Validators.dart` are now **committed** (no longer untracked).

## Changes since 2026-05-23 refresh

- **Audit-pass batch committed** as `fa06aa3` — Login/SignUp hardening, Core utilities, OtpCubit consolidation, Profile/UserModel fixes are now in git history (was the #1 process risk).
- **NEW feature — Google Sign-In:** `lib/business_logic/Auth/GoogleAuth/{google_auth_cubit,google_auth_state}.dart` (untracked). Adds `google_sign_in: ^6.2.1`. Hits `POST /api/auth/google` with the Google `id_token`; backend returns a different envelope than `/api/login` (`access_token` + flat `user`, no `data` wrapper). Wired into the SignUp `GoogleOrFacebook` widget.
- **NEW feature — Connectivity gate:** `lib/Core/CustomWidgets/ConnectivityGate.dart` + `connectivity_plus: ^6.0.0`. Wraps the whole app in `main.dart` (composed with DevicePreview's builder) to show a NoConnection overlay above the navigator app-wide.
- **NEW cubit — QuickResponse:** `business_logic/QuickResponse/{quick_response_cubit,quick_response_state}.dart`.
- **TODO/FIXME count → 0** (was 3).
- **Prod deps 19 → 21** (google_sign_in, connectivity_plus).

## Counts

| Metric | Value | Δ since 2026-05-08 |
|--------|-------|--------------------|
| Dart files in `lib/` | **144** | +7 (GoogleAuth ×2, QuickResponse ×2, ConnectivityGate, + others) |
| Dart files in `test/` | 1 | — |
| Cubit pairs | **15** (Auth×**6** incl. GoogleAuth, Categories, Dictionary, Lessons, Profile, Quiz, QuickResponse, Search, SendFrames, VoiceTranslation) | +2 (GoogleAuth, QuickResponse) |
| Screen files in `lib/presentation/` | 80 (incl. widgets) — 22 feature folders | — |
| Data models | 7 | — |
| API services | 6 (Api_Service, HandLandmarker, mediapipe_hand_service, QuizApiService, UserApiService, sign_language_classifier) | — |
| Repositories | 1 (AuthRepo only — still empty) | — |
| Production deps in pubspec.yaml | **21** | +2 (google_sign_in, connectivity_plus) |
| TODO / FIXME / HACK / XXX comments | **0** | −3 |
| `print(...)` debug calls in `lib/` | **46** | ~+20 (GoogleAuth cubit is heavily instrumented) |
| Target platforms scaffolded | 6 (android, ios, web, windows, macos, linux) | — |
| Total `lib/` LOC | ~16,480 (incl. ~3,000 generated) | +295 (audit-pass churn) |

## File manifest — top 15 by line count

| Lines | File | Δ |
|------:|------|---|
| 2,113 | lib/generated/l10n.dart (generated) | +10 |
|   470 | lib/presentation/Quiz/Quiz.dart | — |
|   445 | lib/presentation/Profile/ProfileScreen2.dart | −5 |
|   436 | lib/presentation/PlayVideo/VideoScreen.dart | +20 |
|   435 | lib/generated/intl/messages_en.dart (generated) | +3 |
|   433 | lib/generated/intl/messages_ar.dart (generated) | +3 |
|   365 | lib/presentation/VoiceTranslation/voice_translation_page.dart | — |
|   357 | lib/presentation/QuickRespose/quickresponse.dart | — |
|   354 | lib/presentation/VideoTranslation/VideoTranslationScreen.dart | — |
|   346 | lib/presentation/Profile_information/Profile_information.dart | — |
|   306 | lib/presentation/VideoTranslation/handtrackingview.dart | — |
|   230 | lib/data/Services/sign_language_classifier.dart | — |
|   227 | lib/presentation/Quiz/quiz_chat.dart | — |
|   209 | lib/presentation/Otp/Widgets/OtpForm.dart | −2 |
|   208 | lib/presentation/About us screens/HelpCenter.dart | −2 |

## Recent commit history (last 10)

```
ef92bb5 Voice translation, ONNX sign classifier, DevicePreview, onboarding fix
f2fd7fc Full Arabic/English localization for all screens, fix emit-after-close crash
2302591 Profile: logout/delete dialogs, profile info API wiring, mode switch navigation
0f4abcd Finishing Quiz feature: API integration, cubit, UI wiring, review & share
2cf9d22 too much edits i don't remeber
5b22ad6 finishing DictionaryCubit except allowing arabic and english search
2364d84 Finishing categouries cubit/ lesson / progress temproraly
743b47e Finishing auth feature
527e859 edit otpscreen,making forgetpass , login, signup,otp cubits
1cbb819 Finishing the whole ui of mode1
```

## Key changes since previous snapshot (`f2fd7fc` → `ef92bb5`)

- **Voice Translation feature shipped**: `voice_translation_cubit/state.dart`, `voice_translation_page.dart`, plus widgets `mic_button.dart`, `transcript_card.dart`.
- **On-device ONNX sign classifier**: `lib/data/Services/sign_language_classifier.dart` (~230 LOC) loads `Assets/models/sign_lstm_attention_fp32.onnx` (10 MB, now in repo).
- **Native Android MediaPipe**: `android/app/src/main/kotlin/com/example/graduation_project/HandLandmarkerService.kt` (140 LOC) replaces the previous Dart-only path. `MainActivity.kt` rewritten.
- **Asset reorg (resolves prior debt #5)**: `hand_landmarker.task` moved from repo root → `Assets/models/`.
- **Service rename**: `data/Services/MediapipeService.dart` → `mediapipe_hand_service.dart`.
- **DevicePreview** wired into `main.dart` (debug builds only).
- **In-flight (uncommitted) audit pass**: shared `Core/CustomWidgets/AppSnackBar.dart` + `Core/Validators.dart` introduced; auth cubits and forms migrating to use them. Likely aligns with the screen-by-screen audit walkthrough.

## Working-tree changes since the 2026-05-08 snapshot (no new commits)

The 2026-05-08 snapshot captured the audit pass mid-flight; in the 15 days since, that pass has advanced significantly but is **still uncommitted** at HEAD `ef92bb5`. Anything below is **only on the local machine** — losing this checkout loses the work.

| Area | What changed (working tree) |
|------|---------------------------|
| Auth structure | `VerifyForgetPassCubit` + state **deleted** — verify-forget-otp call moved onto `OtpCubit` (same screen as regular OTP). Auth folder now: LoginCubit, SignUpCubit, OtpCubit, ForgetPasswordCubit, ResetPasswordCubit. |
| Auth cubits | LoginCubit, SignUpCubit fully hardened (isClosed checks, response-shape validation, ApiException-friendly messages, Dio timeouts 15s/30s/30s, concurrent-call guard, `close()` calls `dio.close(force:true)`). OtpCubit, ForgetPasswordCubit, ResetPasswordCubit modified (extent of hardening unclear — likely lighter than Login/SignUp per progress.md note #4). |
| Auth forms | LoginForm + RegistrationForm rewritten end-to-end: focus-node flow, in-button spinner via `CustomButton.isLoading`, autovalidate-after-first-failure pattern, eye-toggle on password fields, retry action on error snackbar, WidgetState* deprecation migration, Remember-me prefill via `CacheHelper['remembered_email']`. |
| ForgetPassword screens | ChangedSuccessfully, ForgetPassword, Setnewpassword all touched. |
| OtpForm | Modified to handle post-OTP wiring (selectModeFirstTime + mode-based navigation). |
| Core widgets | `AppSnackBar.dart` (themed snackbar, error/success/info variants, retry action, button-purple background with accent border) and `Validators.dart` (email / password / confirmPassword / name) — **still untracked** but now consumed by all auth forms. `CustomTextField` restructured to use `FormField<String>` so validator error renders outside the white container; border radius unified to 16. `CustomButton` got `isLoading` property + Material ripple. |
| Errors | `Core/Errors/ApiExceptions.dart` expanded — per-`DioExceptionType` mapping + status-code mapping (400/401/403/404/409/422/429/5xx) + Laravel `errors`-map flattening. |
| main.dart | TODO comment removed. BlocConsumer → BlocBuilder. Token-guarded `ProfileCubit().getMainData()` to avoid 401 storm on logged-out launches. New `ProfilePrefUpdateFailed` state handled (preserves rollback user when pref update fails). |
| Profile | `profile_cubit.dart` + `profile_state.dart` modified — introduces `ProfilePrefUpdateFailed`. ProfileScreen2 + Widgets/ChooseApplang + Widgets/Chooseappmode all touched. |
| UserModel | `toJson()` bug fixed (was dropping `language`/`mode`/`theme`/`img`). `copyWith()` cleaned up. `fromJson` accepts `userMode` or `mode` for round-trip safety. |
| UserApiService | Modified (likely `selectModeFirstTime` and friends — verify if relevant). |
| ChooseAppMode | Caches mode locally (`'a'` translation, `'l'` learning) before navigating to welcome page. Small-phone overflow fixed. |
| Onboarding | Small-phone overflow fixed by wrapping screen1 Column in SingleChildScrollView. |
| Misc presentation | NoConnection, Dictionary/ListViewOfWords, PlayVideo/VideoScreen touched. |
| Localization | `intl_ar.arb` + `intl_en.arb` + generated `messages_*` + `l10n.dart` all updated (auth/profile copy). |
| Build | `android/app/build.gradle.kts` and `android/gradle/wrapper/gradle-wrapper.properties` modified — likely Gradle wrapper bump (verify version before committing). |
| New cache | `.product/progress.md` — full session-1 log; persists context between sessions. |

## Cache invalidation rules

Re-run `/analyze-codebase` (or let `/resume` trigger it) when **any** of the following change since this snapshot:

| Trigger | What to refresh |
|---------|-----------------|
| `lib/` file count differs from 139 | `current-features.md` + this manifest |
| `pubspec.yaml` or `pubspec.lock` modified | `architecture.md` (stack table), `technical-debt.md` |
| New folder under `lib/business_logic/` | `current-features.md`, `architecture.md` |
| New `*ApiService.dart` or `*Repo.dart` under `lib/data/` | `architecture.md` (data section), `technical-debt.md` (#2 may resolve) |
| New file under `test/` | `technical-debt.md` (test coverage section) |
| Platform folder added/removed | `architecture.md` (target platforms), `deployment-status.md` |
| `.github/workflows/` appears | `deployment-status.md` (CI section) |
| HEAD commit changes | this file (`Last Full Scan`) and the recent-commits block |
| `Core/CustomWidgets/AppSnackBar.dart` or `Core/Validators.dart` get committed/promoted | `architecture.md` (Core section), `technical-debt.md` (audit pass) |
| `VerifyForgetPass` folder reappears under `business_logic/Auth/` | `architecture.md`, `current-features.md` (Auth row) — reconsider whether the OtpCubit-consolidation was reverted |
| Big uncommitted batch finally lands as one or more commits | this file's "Working-tree changes" section, plus `progress.md` ledger |
