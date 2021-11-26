import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class OvertimeTypeBloc {
  final _repository = Repository();

  // for what 2100
  List<M2100OvertimeTypeModel> listOvertimeType2100 = [];
  final _overtimeTypeSubject2100 =
      PublishSubject<List<M2100OvertimeTypeModel>>();
  Stream<List<M2100OvertimeTypeModel>> get overtimeTypeStream2100 =>
      _overtimeTypeSubject2100.stream;

  // for what 2105
  List<M2100OvertimeTypeModel> _listOvertimeType2105 = [];
  final _overtimeTypeSubject2105 =
      PublishSubject<List<M2100OvertimeTypeModel>>();
  Stream<List<M2100OvertimeTypeModel>> get overtimeTypeStream2105 =>
      _overtimeTypeSubject2105.stream;

  /**
   * dispose subject
   */
  void dispose() {
    _overtimeTypeSubject2100.close();
    _overtimeTypeSubject2105.close();
  }

  /**
   * callWhat2100 get all data OvertimeType
   */
  callWhat2100() async {
    try {
      var what = 2100;

      await _repository.executeService(what, {}).then((value) {
        listOvertimeType2100 = List<M2100OvertimeTypeModel>.from(
            value.map((model) => M2100OvertimeTypeModel.fromJson(model)));
      }).whenComplete(() {
        _overtimeTypeSubject2100.sink.add(listOvertimeType2100);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat2105 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat2105(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 2105;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listOvertimeType2105 = [];
            _listOvertimeType2105.addAll(value);
          } else {
            // add more data
            _listOvertimeType2105.addAll(value);
          }
        }
      }).whenComplete(() {
        _overtimeTypeSubject2105.sink.add(_listOvertimeType2105);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
