class Validators {
  Validators._();
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter an email";
    }
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter a password";
    }
    return null;
  }
}
