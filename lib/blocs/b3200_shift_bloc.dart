import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class ShiftBloc {
  final _repository = Repository();

  // for what 3200

  List<M3200ShiftModel> listShift3200 = [];
  final _shiftSubject3200 = PublishSubject<List<M3200ShiftModel>>();
  Stream<List<M3200ShiftModel>> get shiftStream3200 => _shiftSubject3200.stream;

  // for what 3205
  List<M3200ShiftModel> _listShift3205 = [];
  final _shiftSubject3205 = PublishSubject<List<M3200ShiftModel>>();
  Stream<List<M3200ShiftModel>> get shiftStream3205 => _shiftSubject3205.stream;

  // for what 3207
  List<M3200ShiftModel> listShift3207 = [];
  final _shiftSubject3207 = PublishSubject<List<M3200ShiftModel>>();
  Stream<List<M3200ShiftModel>> get shiftStream3207 => _shiftSubject3207.stream;

  // for what 3208
  List<M3200ShiftModel> listShift3208 = [];
  final _shiftSubject3208 = PublishSubject<List<M3200ShiftModel>>();
  Stream<List<M3200ShiftModel>> get shiftStream3208 => _shiftSubject3208.stream;

  /**
   * dispose subject
   */
  void dispose() {
    _shiftSubject3200.close();
    _shiftSubject3205.close();
    _shiftSubject3207.close();
    _shiftSubject3208.close();
  }

  /**
   * callWhat3200 get all data Shift
   */
  callWhat3200() async {
    try {
      var what = 3200;

      await _repository.executeService(what, {}).then((value) {
        listShift3200 = List<M3200ShiftModel>.from(
            value.map((model) => M3200ShiftModel.fromJson(model)));
      }).whenComplete(() {
        _shiftSubject3200.sink.add(listShift3200);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat3205 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat3205(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 3205;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listShift3205 = [];
            _listShift3205.addAll(value);
          } else {
            // add more data
            _listShift3205.addAll(value);
          }
        }
      }).whenComplete(() {
        _shiftSubject3205.sink.add(_listShift3205);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat3207
   */
  callWhat3207(dynamic param) async {
    try {
      var what = 3207;
      // var param = {"arrayID": shiftAssignmentId, "what": 0};

      print('callWhat3207 param arrayID ${param}');

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          listShift3207 = [];
          listShift3207.addAll(value);
        } else {
          // add more data
          listShift3207 = [];
        }
      }).whenComplete(() {
        _shiftSubject3207.sink.add(listShift3207);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
  /**
   * callWhat3208
   */
  callWhat3208(dynamic param) async {
    try {
      var what = 3208;
      // var param = {"arrayID": shiftAssignmentId, "what": 0};

      print('callWhat3208 param arrayID ${param}');

      await _repository.executeService(what, param).then((value) {
        print('callWhat3208 result value ${value}');
        if (value.length != 0) {
          listShift3208 = [];
          listShift3208.addAll(value);
        } else {
          // add more data
          listShift3208 = [];
        }
      }).whenComplete(() {
        _shiftSubject3208.sink.add(listShift3208);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
