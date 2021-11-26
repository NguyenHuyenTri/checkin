class LoginValidators {

  static bool isUsername(String username) {
      return username != null && username.length > 5 && username.length < 15 && username.contains("@");
  }

  static bool isPassword(String password) {
    return password != null && password.length > 5 && password.length < 15;
  }

  static bool isEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

}