/// Form validation helpers — shared by contact, newsletter, future CRM.
abstract final class AppValidators {
  static final RegExp _email = RegExp(
    r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$',
  );

  static String? required(String? value, {String field = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$field is required';
    }
    return null;
  }

  static String? name(String? value) {
    final base = required(value, field: 'Name');
    if (base != null) return base;
    if (value!.trim().length < 2) return 'Enter at least 2 characters';
    if (value.trim().length > 80) return 'Name is too long';
    return null;
  }

  static String? email(String? value) {
    final base = required(value, field: 'Email');
    if (base != null) return base;
    final trimmed = value!.trim();
    if (!_email.hasMatch(trimmed)) return 'Enter a valid email address';
    if (trimmed.length > 120) return 'Email is too long';
    return null;
  }

  static String? message(String? value, {int min = 20, int max = 2000}) {
    final base = required(value, field: 'Message');
    if (base != null) return base;
    final trimmed = value!.trim();
    if (trimmed.length < min) {
      return 'Tell us a bit more (at least $min characters)';
    }
    if (trimmed.length > max) return 'Message is too long';
    return null;
  }

  /// Honeypot — must stay empty (bots fill hidden fields).
  static String? honeypot(String? value) {
    if (value != null && value.trim().isNotEmpty) {
      return 'Invalid submission';
    }
    return null;
  }
}
