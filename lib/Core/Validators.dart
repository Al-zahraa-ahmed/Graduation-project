class Validators {
  Validators._();

  static final RegExp _emailRegex = RegExp(
    r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,}$',
  );

  /// Returns null if valid; otherwise a localized error message.
  /// Pass already-localized strings for required/invalid messages.
  static String? email(
    String? value, {
    required String requiredMsg,
    String invalidMsg = 'Please enter a valid email',
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMsg;
    if (!_emailRegex.hasMatch(trimmed)) return invalidMsg;
    return null;
  }

  static String? password(
    String? value, {
    required String requiredMsg,
    String tooShortMsg = 'Password must be at least 8 characters',
    int minLength = 8,
  }) {
    if (value == null || value.isEmpty) return requiredMsg;
    if (value.length < minLength) return tooShortMsg;
    return null;
  }

  static String? confirmPassword(
    String? value,
    String original, {
    String requiredMsg = 'Please confirm your password',
    required String mismatchMsg,
  }) {
    if (value == null || value.isEmpty) return requiredMsg;
    if (value != original) return mismatchMsg;
    return null;
  }

  static String? name(
    String? value, {
    required String requiredMsg,
    String tooShortMsg = 'Name is too short',
    int minLength = 2,
  }) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMsg;
    if (trimmed.length < minLength) return tooShortMsg;
    return null;
  }
}
