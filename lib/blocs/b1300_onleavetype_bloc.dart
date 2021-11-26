import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class OnLeaveTypeBloc {
  final _repository = Repository();

  // for what 1300
  List<M1300OnLeaveTypeModel> listOnLeaveType1300 = [];
  final _onLeaveTypeSubject1300 = PublishSubject<List<M1300OnLeaveTypeModel>>();
  Stream<List<M1300OnLeaveTypeModel>> get onLeaveTypeStream1300 =>
      _onLeaveTypeSubject1300.stream;

  // for what 1305
  List<M1300OnLeaveTypeModel> _listOnLeaveType1305 = [];
  final _onLeaveTypeSubject1305 = PublishSubject<List<M1300OnLeaveTypeModel>>();
  Stream<List<M1300OnLeaveTypeModel>> get onLeaveTypeStream1305 =>
      _onLeaveTypeSubject1305.stream;

  /**
   * dispose subject
   */
  void dispose() {
    _onLeaveTypeSubject1300.close();
    _onLeaveTypeSubject1305.close();
  }

  /**
   * callWhat1300 get all data OnLeaveType
   */
  callWhat1300() async {
    try {
      var what = 1300;

      await _repository.executeService(what, {}).then((value) {
        if (value.length != 0) {
          listOnLeaveType1300 = List<M1300OnLeaveTypeModel>.from(
              value.map((model) => M1300OnLeaveTypeModel.fromJson(model)));
        } else {
          listOnLeaveType1300 = [];
        }
      }).whenComplete(() {
        _onLeaveTypeSubject1300.sink.add(listOnLeaveType1300);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat1305 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat1305(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 1305;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listOnLeaveType1305 = [];
            _listOnLeaveType1305.addAll(value);
          } else {
            // add more data
            _listOnLeaveType1305.addAll(value);
          }
        }
      }).whenComplete(() {
        _onLeaveTypeSubject1305.sink.add(_listOnLeaveType1305);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
