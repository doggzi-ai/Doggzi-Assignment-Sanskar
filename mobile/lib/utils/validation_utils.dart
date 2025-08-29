class ValidationUtils {
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!isValidEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validatePetName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pet name is required';
    }
    if (value.length < 2) {
      return 'Pet name must be at least 2 characters';
    }
    return null;
  }

  static String? validatePetType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pet type is required';
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null || age < 0 || age > 50) {
      return 'Please enter a valid age (0-50)';
    }
    return null;
  }
}
