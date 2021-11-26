import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class TypeLeaveBloc {
  final _repository = Repository();

  // for what 1400
  List<M1400TypeLeaveModel> listTypeLeave1400 = [];
  final _typeLeaveSubject1400 = PublishSubject<List<M1400TypeLeaveModel>>();
  Stream<List<M1400TypeLeaveModel>> get typeLeaveStream1400 =>
      _typeLeaveSubject1400.stream;

  // for what 1405
  List<M1400TypeLeaveModel> _listTypeLeave1405 = [];
  final _typeLeaveSubject1405 = PublishSubject<List<M1400TypeLeaveModel>>();
  Stream<List<M1400TypeLeaveModel>> get typeLeaveStream1405 =>
      _typeLeaveSubject1405.stream;

  /**
   * dispose subject
   */
  void dispose() {
    _typeLeaveSubject1400.close();
    _typeLeaveSubject1405.close();
  }

  /**
   * callWhat1400 get all data TypeLeave
   */
  callWhat1400() async {
    try {
      var what = 1400;

      print('bloc callWhat1400 start ${DateTime.now()}');
      _repository.executeService(what, {}).then((value) {
        print('bloc callWhat1400 then ${DateTime.now()}');
        if (value.length != 0) {
          listTypeLeave1400 = List<M1400TypeLeaveModel>.from(
              value.map((model) => M1400TypeLeaveModel.fromJson(model)));
        } else {
          listTypeLeave1400 = [];
        }
      }).whenComplete(() {
        print('bloc callWhat1400 end ${DateTime.now()}');
        _typeLeaveSubject1400.sink.add(listTypeLeave1400);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat1405 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat1405(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 1405;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listTypeLeave1405 = [];
            _listTypeLeave1405.addAll(value);
          } else {
            // add more data
            _listTypeLeave1405.addAll(value);
          }
        }
      }).whenComplete(() {
        _typeLeaveSubject1405.sink.add(_listTypeLeave1405);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
