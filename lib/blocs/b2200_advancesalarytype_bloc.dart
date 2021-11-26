import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class AdvanceSalaryTypeBloc {
  final _repository = Repository();

  // for what 2200
  List<M2200AdvanceSalaryTypeModel> listAdvanceSalaryType2200 = [];
  final _advanceSalaryTypeSubject2200 =
      PublishSubject<List<M2200AdvanceSalaryTypeModel>>();
  Stream<List<M2200AdvanceSalaryTypeModel>> get advanceSalaryTypeStream2200 =>
      _advanceSalaryTypeSubject2200.stream;

  // for what 2205
  List<M2200AdvanceSalaryTypeModel> _listAdvanceSalaryType2205 = [];
  final _advanceSalaryTypeSubject2205 =
      PublishSubject<List<M2200AdvanceSalaryTypeModel>>();
  Stream<List<M2200AdvanceSalaryTypeModel>> get advanceSalaryTypeStream2205 =>
      _advanceSalaryTypeSubject2205.stream;

  /**
   * dispose subject
   */
  void dispose() {
    _advanceSalaryTypeSubject2200.close();
    _advanceSalaryTypeSubject2205.close();
  }

  /**
   * callWhat2200 get all data AdvanceSalaryType
   */
  callWhat2200() async {
    try {
      var what = 2200;

      await _repository.executeService(what, {}).then((value) {
        listAdvanceSalaryType2200 = List<M2200AdvanceSalaryTypeModel>.from(
            value.map((model) => M2200AdvanceSalaryTypeModel.fromJson(model)));
      }).whenComplete(() {
        _advanceSalaryTypeSubject2200.sink.add(listAdvanceSalaryType2200);
      });
    } catch (e) {
      print(e);
      if (e.toString().contains("Connection timed out")) {
        print('2200: lỗi kết nối ở advance salary type bloc');
      } else {
        throw e;
      }
    }
  }

  /**
   * callWhat2205 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat2205(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 2205;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listAdvanceSalaryType2205 = [];
            _listAdvanceSalaryType2205.addAll(value);
          } else {
            // add more data
            _listAdvanceSalaryType2205.addAll(value);
          }
        }
      }).whenComplete(() {
        _advanceSalaryTypeSubject2205.sink.add(_listAdvanceSalaryType2205);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
