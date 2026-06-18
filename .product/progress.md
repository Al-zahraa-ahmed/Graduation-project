# Session Progress — graduation_project (Signlingo)

## Current State

- **Phase:** Development (auth hardening + screen-by-screen UI audit)
- **Active Use Case:** Login + SignUp screens — bugs fixed, hardened, themed; SignUp screen audit ongoing
- **Active Branch:** `main`
- **Last Session:** 2026-05-08

## Session Log

### 2026-05-08 — Session 1

**Accomplished:**

- **DevicePreview wired** into [lib/main.dart](lib/main.dart) for small-phone responsiveness testing (debug builds only via `!kReleaseMode`).
- **Onboarding small-phone overflow** (32px) fixed by wrapping `screen1`'s Column in `SingleChildScrollView` + `mainAxisSize: MainAxisSize.min` ([lib/presentation/onboarding/Widgets/Screen.dart](lib/presentation/onboarding/Widgets/Screen.dart)).
- **ChooseAppMode** ([lib/presentation/Appmodes/ChooseAppMode.dart](lib/presentation/Appmodes/ChooseAppMode.dart)) — small-phone overflow fixed; card taps cache mode locally (`'a'` translation, `'l'` learning) before navigating to welcome page.
- **Post-OTP wiring** ([lib/business_logic/Auth/OtpCubit/otp_cubit.dart](lib/business_logic/Auth/OtpCubit/otp_cubit.dart) + [lib/presentation/Otp/Widgets/OtpForm.dart](lib/presentation/Otp/Widgets/OtpForm.dart)) — `verify_otp` success now calls `userApi.selectModeFirstTime(mode: cachedMode)` (try/catch wrapped), and OTP success listener navigates to `LearingHome` or `Translationhome` based on cached mode.
- **New shared widget — [AppSnackBar](lib/Core/CustomWidgets/AppSnackBar.dart)**: themed snackbar (button-purple background + colored accent border per variant), `error`/`success`/`info`, optional `onRetry`, single 3-second duration, swipe-down dismissal, uses `clearSnackBars()` to avoid animation-race "stuck snackbar" bug.
- **New shared util — [Validators](lib/Core/Validators.dart)**: `email`, `password` (min-8), `confirmPassword`, `name` — accept localized message params.
- **Expanded [ApiExceptions](lib/Core/Errors/ApiExceptions.dart)**: friendly messages per `DioExceptionType` (timeouts, connection error, cancel, badCertificate, unknown) + status-code mapping (400/401/403/404/409/422/429/5xx) + Laravel `errors`-map flattening.
- **LoginForm** ([lib/presentation/LogIn/Widgets/LoginForm.dart](lib/presentation/LogIn/Widgets/LoginForm.dart)) and **RegistrationForm** ([lib/presentation/SignUp/Widgets/RegistrationForm.dart](lib/presentation/SignUp/Widgets/RegistrationForm.dart)) rewritten:
  - **Bugs fixed:** submit was blocked when checkbox unchecked; confirm-password validator was inverted and never fired; login sent Remember-me as `agreement` field (now sends `remember_me`); login always navigated to `LearingHome` regardless of mode.
  - **Email-only Remember-me prefill** via `CacheHelper['remembered_email']`.
  - `late String` → `TextEditingController` (avoids LateInitializationError).
  - `MaterialStateProperty` / `MaterialStateBorderSide` → `WidgetStateProperty` / `WidgetStateBorderSide` (deprecation migration).
  - **Eye-toggle** on password fields (auto-attached whenever `isabvious: true`).
  - **In-button loading spinner** via new `CustomButton.isLoading`; dropped the wrapping `GestureDetector` so the button has real Material ripple.
  - **Focus nodes + autofocus + next-field flow** (`textInputAction: next` between fields, `done` on the last submits).
  - **Retry action** on error snackbar (`AppSnackBar.error(..., onRetry: _submit)`).
  - **Autovalidate pattern**: starts `AutovalidateMode.disabled`; flips to `onUserInteraction` after first failed submit so errors update live as user types.
- **LoginCubit** ([lib/business_logic/Auth/LoginCubit/login_cubit.dart](lib/business_logic/Auth/LoginCubit/login_cubit.dart)) and **SignUpCubit** ([lib/business_logic/Auth/SignUpCubit/SignUpCubit.dart](lib/business_logic/Auth/SignUpCubit/SignUpCubit.dart)) hardened:
  - `isClosed` checks before every `emit`.
  - Response-shape validation (`data['data']['token']` etc.) — emits friendly failure on malformed shape.
  - `DioException` → `ApiException.fromDio(e).message` (no more raw JSON in snackbars).
  - Generic `catch (_)` fallback to "Something went wrong".
  - `close()` override calls `dio.close(force: true)` to cancel in-flight requests.
  - LoginCubit syncs `user.mode` and `user.language` from login response into `CacheHelper` so returning users land in the right home.
  - **Dio timeouts** added: `connectTimeout: 15s`, `receiveTimeout: 30s`, `sendTimeout: 30s`.
  - **Concurrent-call guard**: `state is LoginLoading` / `SignUpLoading` early-returns.
- **UserModel bugs fixed** ([lib/data/Models/UserModel.dart](lib/data/Models/UserModel.dart)):
  - `toJson()` now serializes all 8 fields (was dropping `language`/`mode`/`theme`/`img`).
  - `copyWith()` removed dead `phone` param, added `img` + `isVerified` params, propagates everything to constructor.
  - `fromJson` now reads `userMode` OR `mode` so toJson/fromJson round-trips correctly.
- **CustomTextField restructure** ([lib/Core/CustomWidgets/CustomTextField.dart](lib/Core/CustomWidgets/CustomTextField.dart)):
  - Container border radius matched to `OutlineInputBorder` (both 16) — fixes the "input border escaping its frame" visual bug.
  - Wrapped in `FormField<String>` with custom `builder` so the validation error text renders as a separate `Text` widget **outside** the white container (was rendering inside the input box).
- **Committed pre-existing in-flight work** as [`ef92bb5`](commit/ef92bb5): "Voice translation, ONNX sign classifier, DevicePreview, onboarding fix" (35 files, 2168 insertions).
- **`.gitignore`** updated to exclude `build_output*.txt` build dumps.

**In Progress:**

- 17 modified files + 2 untracked Core widgets staged-but-uncommitted from the auth-hardening + audit pass.
- Screen-by-screen audit walkthrough — visited Onboarding, ChooseAppMode, LoginContainer, SignUp form. Remaining order: WelcomePage → OTP → ForgetPassword (3 screens) → LearningHome → TranslationHome → Categories → Lessons → Quiz + QuizResult → QuickPractice + QuickResponse → Dictionary → PlayVideo → VideoTranslation (5 screens) → VoiceTranslation → Profile + ProfileInformation → About / Help / Legal (5 static) → Error screens (NoConnection, NotFound).
- LoginScreen body layout iterated several times (Spacer ↔ reverse: true ↔ resizeToAvoidBottomInset: false). Final state per user revert: `IntrinsicHeight + Spacer + LoginContainer` — has the cosmetic 2-pixel debug overflow + "card jumps full keyboard height" UX, both intentionally kept.

**Blockers:**

- **`git push origin main` failed with HTTP 403** — Windows Credential Manager has wrong GitHub account cached (`Al-zahraaahmed` instead of `Al-zahraa-ahmed`). Commit `ef92bb5` is local but **not on GitHub**. User needs to clear the credential or sign in fresh via VS Code's Source Control panel before push works.

**Next Steps:**

1. **Resolve git credentials and push `ef92bb5`** to `origin/main` (Source Control → Sync, or Credential Manager cleanup).
2. **Commit the current uncommitted batch** (auth hardening + new Core widgets + .product/ refresh) — 17 files modified, 2 untracked. Suggested message: "Auth hardening, themed snackbar, validators, UserModel fixes; CustomTextField error placement".
3. **Continue screen audit at WelcomePage** ([lib/presentation/WelcomPage/WelcomPage.dart](lib/presentation/WelcomPage/WelcomPage.dart)).
4. **Decide whether to apply OtpCubit + ForgetPasswordCubit hardening** (same `ApiException` + isClosed + timeouts pattern as Login/SignUp). User explicitly hardened only Login/SignUp; OTP got the post-success wiring but not the broader hardening.
5. **Address technical-debt #1** (centralize `ApiConfig` to kill the hardcoded URL in 6+ files) — biggest single-leverage cleanup remaining.

**Technical Notes:**

- **Snackbar "stuck" bug fix**: `hideCurrentSnackBar()` is async (animates out) and racing with `showSnackBar()` could leave snackbars apparently persistent. Switched to `clearSnackBars()` (instant queue drain). Single 3s duration; conditional 6s-when-retry was removed.
- **AppSnackBar palette**: background = `#8484E1` (button purple) for all variants; differentiation via the colored border-side accent (red for error, green for success, navy for info) + icon. User asked for "color of the button".
- **Locale wiring choice**: DevicePreview's locale switcher is **intentionally not bound** to the MaterialApp's `locale` — the app uses its own `CacheHelper`-driven locale, and binding DevicePreview would override the user's in-app language choice mid-test.
- **User reverted my `reverse: true` SingleChildScrollView** approach for Login layout. They prefer the `IntrinsicHeight + Spacer` version even with the 2px overflow + keyboard-jump UX. Don't re-apply unless asked.
- **The whole codebase uses PascalCase filenames** (`CustomButton.dart`, `ApiExceptions.dart`) and PascalCase method names (`Login`, `SignUp`). These trigger Dart info-level lints. Per minimum-fix policy, leaving them — renaming requires multi-file refactor.
- **Saved feedback memory `feedback_minimum_fix.md`** after user pushback on bundling RTL/SafeArea fixes with the onboarding overflow fix. Going forward: only fix the reported problem; mention adjacent issues as separate fixable items.
- **`UserModel.toJson` writes `userMode`** (not `mode`) intentionally — that's the key the backend sends. `fromJson` accepts both. Caching round-trips cleanly.
- **AppSnackBar.error retry semantics**: passes `_submit` as `onRetry` unconditionally. For 422 validation errors, retrying without changing input fails the same way — minor UX wart not yet addressed.

## How to resume

Run `/feature-workflow:resume` next session and it'll re-load this context. Or read just this file (`progress.md`) plus `architecture.md` for a snapshot.
