class Validator {
  static String? validateEmail({required String email}) {
    if (email.isEmpty) {
      return 'Email is empty';
    } else {
      return null;
    }
  }

  static String? validatePassword({required String password}) {
    if (password.isEmpty) {
      return 'Password is empty';
    } else if (password.length < 6) {
      return 'Password is too short!';
    } else {
      return null;
    }
  }
}
