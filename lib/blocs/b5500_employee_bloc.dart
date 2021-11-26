import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class EmployeeBloc {
  final _repository = Repository();

  // for what 5500
  var listEmployee5500 ;
  final _employeeSubject5500 = PublishSubject();
  Stream get employeeStream5500 => _employeeSubject5500.stream;

  // for what 5505
  List<M5500EmployeeModel> _listEmployee5505 = [];
  final _employeeSubject5505 = PublishSubject<List<M5500EmployeeModel>>();
  Stream<List<M5500EmployeeModel>> get employeeStream5505 =>
      _employeeSubject5505.stream;

  // for what 5507
  var count;
  final _employeeSubject5507 = PublishSubject<List<M5500EmployeeModel>>();
  Stream<List<M5500EmployeeModel>> get employeeStream5507 =>
      _employeeSubject5507.stream;

  //for what 5510
  var listEmployee5510 = [] ;
  final _employyeSubject5510 = PublishSubject();
  Stream get employeeStream5510 => _employyeSubject5510.stream;

  //for what 5511
  bool listEmployee5511 ;
  final _employyeSubject5511 = PublishSubject();
  Stream get employeeStream5511 => _employyeSubject5511.stream;


  //for what 5513
  var listEmployee5513 = [] ;
  final _employyeSubject5513 = PublishSubject();
  Stream get employeeStream5513 => _employyeSubject5513.stream;


  /**
   * dispose subject
   */
  void dispose() {
    _employeeSubject5500.close();
    _employeeSubject5505.close();
    _employeeSubject5507.close();
    _employyeSubject5510.close();
    _employyeSubject5511.close();
    _employyeSubject5513.close();
  }

  /**
   * callWhat5500 get all data Employee
   */
  callWhat5511(Map<String ,dynamic> param) async {
    try {
      var what = 5511;
      await _repository.executeService(what, param).then((value) {
        print(value.toString()+'value');
        if (value==true) {
          listEmployee5511 = true;
        } else {
          listEmployee5511 = false;
        }
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat5505 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat5505(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 5505;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listEmployee5505 = [];
            _listEmployee5505.addAll(value);
          } else {
            // add more data
            _listEmployee5505.addAll(value);
          }
        }
      }).whenComplete(() {
        _employeeSubject5505.sink.add(_listEmployee5505);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  callWhat5507(Map<String, dynamic> param) async {
    try {
      var what = 5507;
      await _repository.executeService(what, param).then((value) {
        count = value[0]['COUNT(1)'];
        print('count o BLOC ' + count);
        return count;
      }).whenComplete(() {
        _employeeSubject5507.sink.add([]);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  callWhat5510(Map<String, dynamic> param) async {
    try {
      var what = 5510;
      await _repository.executeService(what, param).then((value) {
        print('callWhat5510 value ${value}');
        if (value.length != 0) {
          listEmployee5510 = value;
          print(listEmployee5510.toString()+'bloc');
        } else {
          listEmployee5510 = null;
        }
      }).whenComplete(() {
        _employyeSubject5510.sink.add(listEmployee5510);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
  callWhat5513(Map<String, dynamic> param) async {
    try {
      var what = 5513;
      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          listEmployee5513 = value;
          print(listEmployee5513.toString()+'bloc 5513');
        } else {
          listEmployee5513 = null;
        }
      }).whenComplete(() {
        _employyeSubject5513.sink.add(listEmployee5513);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

}
