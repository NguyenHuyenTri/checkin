import 'dart:async';

import 'package:vao_ra/validators/login_validators.dart';

class LoginBloc {

  StreamController _usernameController = new StreamController();
  StreamController _passwordController = new StreamController();

  Stream get usernameStream => _usernameController.stream;
  Stream get passwordStream => _passwordController.stream;

  bool isValidLogin(String username, String password) {

    if(!LoginValidators.isUsername(username)) {
      _usernameController.sink.addError("Email hoặc số điện thoại không hợp lệ");
      return false;
    }

    _usernameController.sink.add("OK");
    if(!LoginValidators.isPassword(password)) {
      _passwordController.sink.addError("Mật khẩu không hợp lệ");
      return false;
    }

    _passwordController.sink.add("OK");
    return true;
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
  }

}