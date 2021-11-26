import '../models/models.dart';
import '../repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AdvanceSalaryBloc {
  final _repository = Repository();
  SharedPreferences preferences;

  // for what 2300
  List<M2300AdvanceSalaryModel> listAdvanceSalary2300 = [];
  final _advanceSalarySubject2300 =
      PublishSubject<List<M2300AdvanceSalaryModel>>();
  Stream<List<M2300AdvanceSalaryModel>> get advanceSalaryStream2300 =>
      _advanceSalarySubject2300.stream;

  // for what 2301
  final _advanceSalarySubject2301 = PublishSubject<M2300AdvanceSalaryModel>();
  Stream<M2300AdvanceSalaryModel> get advanceSalaryStream2301 =>
      _advanceSalarySubject2301.stream;

  // for what 2305
  List<M2300AdvanceSalaryModel> _listAdvanceSalary2305 = [];
  final _advanceSalarySubject2305 =
      PublishSubject<List<M2300AdvanceSalaryModel>>();
  Stream<List<M2300AdvanceSalaryModel>> get advanceSalaryStream2305 =>
      _advanceSalarySubject2305.stream;

  // for what 2306
  var countAdvanceSalary = 0;
  final _advanceSalarySubject2306 = PublishSubject();
  Stream get advanceSalaryStream2306 => _advanceSalarySubject2306.stream;

  // for what 2307
  var listSalaryAdvance2307 = [];
  final _salaryAdvanceSubject2307 = PublishSubject();
  Stream get advanceSalaryStream2307 => _salaryAdvanceSubject2307.stream;

  // for what 2308
  var listSalaryAdvance2308 = [];
  var listOvertime2308 = [];
  var listBusinessTrip2308 = [];
  var listCheckinLate2308 = [];
  var listCheckoutSoon2308 = [];
  var listOnLeave2308 = [];
  var requestList2308 = [];
  final _requestSubject2308 = PublishSubject();
  Stream get requestStream2308 => _requestSubject2308.stream;

  // for what 2309
  int countTotalWaitApprove;
  int countTotalApproved;
  int countTotalDenied;

  // define wait approve
  var countAdvanceSalaryWaitApprove2309;
  var countOvertimeWaitApprove2309;
  var countBusinessTripWaitApprove2309;
  var countCheckinLateWaitApprove2309;
  var countCheckoutSoonWaitApprove2309;
  var countOnLeaveWaitApprove2309;

  // define approved
  var countAdvanceSalaryApproved2309;
  var countOvertimeApproved2309;
  var countCheckinLateApproved2309;
  var countCheckoutSoonApproved2309;
  var countOnLeaveApprove2309;

  // define denied
  var countAdvanceSalaryDenied2309;
  var countOvertimeDenied2309;
  var countCheckinLateDenied2309;
  var countCheckoutSoonDenied2309;
  var countOnLeaveDenied2309;

  final _advanceSalarySubject2309 = PublishSubject();
  Stream get advanceSalaryStream2309 => _advanceSalarySubject2309.stream;

  // for what 2310
  var listSalaryAdvance2310 = [];
  var listOvertime2310 = [];
  var listBusinessTrip2310 = [];
  var listCheckinLate2310 = [];
  var listCheckoutSoon2310 = [];
  var listOnLeave2310 = [];
  var requestList2310 = [];
  final _requestSubject2310 = PublishSubject();
  Stream get requestStream2310 => _requestSubject2310.stream;

  // for what 2311
  var listSalaryAdvance2311 = [];
  var listOvertime2311 = [];
  var listBusinessTrip2311 = [];
  var listCheckinLate2311 = [];
  var listCheckoutSoon2311 = [];
  var listOnLeave2311 = [];
  var requestList2311 = [];
  final _requestSubject2311 = PublishSubject();
  Stream get requestStream2311 => _requestSubject2311.stream;

  // for what 2313
  var listAdvanceSalary2313 = [];
  final _advanceSalarySubject2313 = PublishSubject();
  Stream get advanceSalaryStream2313 => _advanceSalarySubject2313.stream;

  /**
   * dispose subject
   */
  void dispose() {
    _advanceSalarySubject2300.close();
    _advanceSalarySubject2301.close();
    _advanceSalarySubject2305.close();
    _advanceSalarySubject2306.close();
    _salaryAdvanceSubject2307.close();
    _requestSubject2308.close();
    _advanceSalarySubject2309.close();
    _requestSubject2310.close();
    _requestSubject2311.close();
    _advanceSalarySubject2313.close();
  }

  /**
   * callWhat2300 get all data AdvanceSalary
   */
  callWhat2300() async {
    try {
      var what = 2300;

      await _repository.executeService(what, {}).then((value) {
        listAdvanceSalary2300 = value;
      }).whenComplete(() {
        _advanceSalarySubject2300.sink.add(listAdvanceSalary2300);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat2305 get data limit
   * @page : number pagination
   * @limit : limit of pagination
   * @isPullRefresh: default is false
   */
  callWhat2305(int page, int limit, {bool isPullRefresh: false}) async {
    try {
      var what = 2305;
      var param = {"offset": page * limit, "limit": limit};

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          // clear data when pull refresh
          if (isPullRefresh == true) {
            _listAdvanceSalary2305 = [];
            _listAdvanceSalary2305.addAll(value);
          } else {
            // add more data
            _listAdvanceSalary2305.addAll(value);
          }
        }
      }).whenComplete(() {
        _advanceSalarySubject2305.sink.add(_listAdvanceSalary2305);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  callWhat2306(Map<String, dynamic> param) async {
    try {
      var what = 2306;

      await _repository.executeService(what, param).then((value) {
        print(value.toString());
      }).whenComplete(() {
        _advanceSalarySubject2300.sink.add(listAdvanceSalary2300);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   * callWhat2307 get data advance salary to put on calendar
   */
  callWhat2307(Map<String, dynamic> param) async {
    try {
      var what = 2307;
      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          listSalaryAdvance2307 = value;
        } else {
          listSalaryAdvance2307 = [];
        }
      }).whenComplete(() {
        _salaryAdvanceSubject2307.sink.add(listSalaryAdvance2307);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }

  /**
   *  get all data [AdvanceSalary,Overtime,BusinessTrip,CheckinLate,CheckoutSoon,
   *  OnLeave] at current date with IdCompany and IdEmployee
   */
  callWhat2308(Map<String, dynamic> param) async {
    try {
      var what = 2308;

      await _repository.executeService(what, param).then((value) {
        print('callWhat2308 value ${value}');
        if (value.length != 0) {
          requestList2308.clear();

          listSalaryAdvance2308 = value['advance_salary']['data'];
          listOvertime2308 = value['overtime']['data'];
          listBusinessTrip2308 = value['business_trip']['data'];
          listOnLeave2308 = value['on_leave']['data'];
          listCheckinLate2308 = value['checkin_late']['data'];
          listCheckoutSoon2308 = value['checkout_soon']['data'];

          requestList2308
            ..addAll(listSalaryAdvance2308)
            ..addAll(listOvertime2308)
            ..addAll(listBusinessTrip2308)
            ..addAll(listOnLeave2308)
            ..addAll(listCheckinLate2308)
            ..addAll(listCheckoutSoon2308);

          requestList2308..sort((a,b) => DateTime.parse(b['CreatedAt'].toString()).compareTo(DateTime.parse(a['CreatedAt'].toString())));
        } else {
          _requestSubject2308.sink.addError("Không có dữ liệu");
        }
      }).whenComplete(() {
        _requestSubject2308.sink.add(requestList2308);
      });
    } catch (e) {
      print(e);
      if (e.toString().contains("Connection timed out")) {
        print('2308: lỗi kết nối ở advance salary bloc');
      }
      if (e.toString().contains("Connection closed")) {
        print('2308: kết nối đã bị đóng lại!');
      }
      if (e.toString().contains("No address associated with hostname")) {
        print('2308: Không có kết nối!');
      } else {
        throw e;
      }
    }
  }

  /**
   *  count all data advance salary on day
   */
  callWhat2309(Map<String, dynamic> param) async {
    try {
      var what = 2309;

      print('2309 ${param}');

      await _repository.executeService(what, param).then((value) {
        // count total requests waiting approve
        countAdvanceSalaryWaitApprove2309 = value['advance_salary_wait_approve']
            ['data'][0]['CountAdvanceSalary'];
        countOvertimeWaitApprove2309 =
            value['overtime_wait_approve']['data'][0]['CountOvertime'];
        countBusinessTripWaitApprove2309 =
            value['business_trip_wait_approve']['data'][0]['CountBusinessTrip'];
        countCheckinLateWaitApprove2309 =
            value['checkin_late_wait_approve']['data'][0]['CountCheckinLate'];
        countCheckoutSoonWaitApprove2309 =
            value['checkout_soon_wait_approve']['data'][0]['CountCheckoutSoon'];
        countOnLeaveWaitApprove2309 =
            value['on_leave_wait_approve']['data'][0]['CountOnLeave'];

        countTotalWaitApprove = int.parse(countAdvanceSalaryWaitApprove2309) +
            int.parse(countOvertimeWaitApprove2309) +
            int.parse(countBusinessTripWaitApprove2309) +
            int.parse(countCheckinLateWaitApprove2309) +
            int.parse(countCheckoutSoonWaitApprove2309) +
            int.parse(countOnLeaveWaitApprove2309);

        // count total requests approved
        countAdvanceSalaryApproved2309 =
            value['advance_salary_approved']['data'][0]['CountAdvanceSalary'];
        countOvertimeApproved2309 =
            value['overtime_approved']['data'][0]['CountOvertime'];
        countCheckinLateApproved2309 =
            value['checkin_late_approved']['data'][0]['CountCheckinLate'];
        countCheckoutSoonApproved2309 =
            value['checkout_soon_approved']['data'][0]['CountCheckoutSoon'];
        countOnLeaveApprove2309 =
            value['on_leave_approved']['data'][0]['CountOnLeave'];

        countTotalApproved = int.parse(countAdvanceSalaryApproved2309) +
            int.parse(countOvertimeApproved2309) +
            int.parse(countCheckinLateApproved2309) +
            int.parse(countCheckoutSoonApproved2309) +
            int.parse(countOnLeaveApprove2309);

        // count total requests waiting denied
        countAdvanceSalaryDenied2309 =
            value['advance_salary_denied']['data'][0]['CountAdvanceSalary'];
        countOvertimeDenied2309 =
            value['overtime_denied']['data'][0]['CountOvertime'];
        countCheckinLateDenied2309 =
            value['checkin_late_denied']['data'][0]['CountCheckinLate'];
        countCheckoutSoonDenied2309 =
            value['checkout_soon_denied']['data'][0]['CountCheckoutSoon'];
        countOnLeaveDenied2309 =
            value['on_leave_denied']['data'][0]['CountOnLeave'];

        countTotalDenied = int.parse(countAdvanceSalaryDenied2309) +
            int.parse(countOvertimeDenied2309) +
            int.parse(countCheckinLateDenied2309) +
            int.parse(countCheckoutSoonDenied2309) +
            int.parse(countOnLeaveDenied2309);
      }).whenComplete(() {
        _advanceSalarySubject2309.sink.add([
          countTotalDenied,
          countAdvanceSalaryDenied2309,
          countTotalWaitApprove
        ]);
      });
    } catch (e) {
      if (e.toString().contains("No address associated with hostname")) {
        print('2309: Không có kết nối!');
      } else {
        throw e;
      }
    }
  }

  /**
   *  get all data [AdvanceSalary,Overtime,BusinessTrip,CheckinLate,CheckoutSoon,
   *  OnLeave] at current date with IdCompany and IdEmployee approved
   */
  callWhat2310(Map<String, dynamic> param) async {
    try {
      var what = 2310;

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          requestList2310.clear();

          listSalaryAdvance2310 = value['advance_salary']['data'];
          listOvertime2310 = value['overtime']['data'];
          listOnLeave2310 = value['on_leave']['data'];
          listCheckinLate2310 = value['checkin_late']['data'];
          listCheckoutSoon2310 = value['checkout_soon']['data'];

          requestList2310
            ..addAll(listSalaryAdvance2310)
            ..addAll(listOvertime2310)
            ..addAll(listOnLeave2310)
            ..addAll(listCheckinLate2310)
            ..addAll(listCheckoutSoon2310);

          requestList2310..sort((a,b) => DateTime.parse(b['CreatedAt'].toString()).compareTo(DateTime.parse(a['CreatedAt'].toString())));
        } else {
          _requestSubject2310.sink.addError("Không có dữ liệu");
        }
      }).whenComplete(() {
        _requestSubject2310.sink.add(requestList2310);
      });
    } catch (e) {
      print(e);
      if (e.toString().contains("Connection timed out")) {
        print('2310: lỗi kết nối ở advance salary bloc');
      }
      if (e.toString().contains("Connection closed")) {
        print('2310: kết nối đã bị đóng lại!');
      } else {
        throw e;
      }
    }
  }

  /**
   *  get all data [AdvanceSalary,Overtime,BusinessTrip,CheckinLate,CheckoutSoon,
   *  OnLeave] at current date with IdCompany and IdEmployee denied
   */
  callWhat2311(Map<String, dynamic> param) async {
    try {
      var what = 2311;

      await _repository.executeService(what, param).then((value) {
        if (value.length != 0) {
          requestList2311.clear();

          listSalaryAdvance2311 = value['advance_salary']['data'];
          listOvertime2311 = value['overtime']['data'];
          listOnLeave2311 = value['on_leave']['data'];
          listCheckinLate2311 = value['checkin_late']['data'];
          listCheckoutSoon2311 = value['checkout_soon']['data'];

          requestList2311
            ..addAll(listSalaryAdvance2311)
            ..addAll(listOvertime2311)
            ..addAll(listOnLeave2311)
            ..addAll(listCheckinLate2311)
            ..addAll(listCheckoutSoon2311);

          listSalaryAdvance2311..sort((a,b) => DateTime.parse(b['CreatedAt'].toString()).compareTo(DateTime.parse(a['CreatedAt'].toString())));

        } else {
          _requestSubject2311.sink.addError("Không có dữ liệu");
        }
      }).whenComplete(() {
        _requestSubject2311.sink.add(requestList2311);
      });
    } catch (e) {
      print(e);
      if (e.toString().contains("Connection timed out")) {
        print('2311: lỗi kết nối ở advance salary bloc');
      }
      if (e.toString().contains("Connection closed")) {
        print('2311: kết nối đã bị đóng lại!');
      } else {
        throw e;
      }
    }
  }

  /**
   * callWhat2307 get data advance salary to put on calendar
   */
  callWhat2313(Map<String, dynamic> param) async {
    try {
      var what = 2313;
      await _repository.executeService(what, param).then((value) {
        listAdvanceSalary2313 = value;
        print('Break point 2313 ' + listAdvanceSalary2313.toString());
      }).whenComplete(() {
        _advanceSalarySubject2313.sink.add(listAdvanceSalary2313);
      });
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
