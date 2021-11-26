import 'dart:io';

import 'package:vao_ra/models/UserModel.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  final _service = Repository();

  final _userFetcher = PublishSubject<UserModel>();
  Stream<UserModel> get user => _userFetcher.stream;

  getCurrentUser() async {
    try {
      UserModel _user;
      _userFetcher.sink.add(_user);
    } catch (e) {
      print(e);
      throw e;
    }
  }

  dispose() {
    _userFetcher.close();
  }
}
