import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timelines/timelines.dart';

import '../../shares/GeneralColors.dart';
import '../../shares/GeneralSizes.dart';
import '../../shares/shares.dart';

class ItimeMainTask extends StatefulWidget {
  @override
  _ItimeMainTaskState createState() => _ItimeMainTaskState();
}

class _ItimeMainTaskState extends State<ItimeMainTask> {
  // Get list from future

  // Get list model

  // Define base data type
  String _minuteString;
  String _hourString;

  String employeeId;
  String employeeName;

  String companyId;

  String imageEmployee;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  // Define datetime

  // sub function
  String _formatMinute(DateTime dateTime) {
    return DateFormat('mm').format(dateTime);
  }

  String _formatHour(DateTime dateTime) {
    return DateFormat('HH').format(dateTime);
  }

  String dateFormatter(DateTime date) {
    dynamic dayData =
        '{ "1" : "Thứ hai", "2" : "Thứ 3", "3" : "Thứ tư", "4" : "Thứ năm", "5" : "Thứ sáu", "6" : "Thứ bảy", "7" : "Chủ nhật" }';

    dynamic monthData =
        '{ "1" : "Tháng 1", "2" : "Tháng 2", "3" : "Tháng 3", "4" : "Tháng 4", "5" : "Tháng 5", "6" : "Tháng 6", "7" : "Tháng 7", "8" : "Tháng 8", "9" : "Tháng 9", "10" : "Tháng 10", "11" : "Tháng 11", "12" : "Tháng 12" }';

    return json.decode(dayData)['${date.weekday}'] +
        ", " +
        "Ngày " +
        date.day.toString() +
        " " +
        json.decode(monthData)['${date.month}'] +
        " " +
        date.year.toString() +
        " " +
        " ${_hourString.toString() + ":" + "${_minuteString.toString()}"} "
            "${int.parse(date.hour.toString()) >= 5 && int.parse(date.hour.toString()) <= 9 ? "sáng" : int.parse(date.hour.toString()) >= 9 && int.parse(date.hour.toString()) <= 12 ? "trưa" : "chiều"}";
  }

  String dateFormatterShort(DateTime date) {
    if (date == null) return '...';
    return date.hour.toString() +
        ":" +
        date.minute.toString() +
        ":" +
        date.second.toString();
  }

  void _getMinuteTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatMinute(now);
    setState(() {
      _minuteString = formattedDateTime;
    });
  }

  void _getHourTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatHour(now);
    setState(() {
      _hourString = formattedDateTime;
    });
  }

  final List<String> labelTimeline = ['Vào ca', 'Bắt đầu', 'Kết thúc', 'Ra ca'];

  // Get list from future
  final advanceSalaryBloc = AdvanceSalaryBloc();

  int countTotalWaitApprove = 0;
  int countTotalApproved = 0;
  int countTotalDenied = 0;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    init();
  }

  // @override
  // void setState(fn) {
  //   if (mounted) {
  //     super.setState(fn);
  //   }
  // }

  @override
  void dispose() {
    timekeepingBLOC.dispose();
    shiftBLOC.dispose();
    shiftAssignmentBLOC.dispose();
    super.dispose();
  }

  Future getFuture() {
    return Future(() async {
      await Future.delayed(Duration(seconds: 1));
    });
  }

  Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(getFuture(), message: Text('Đang xử lý...')),
    );
  }

  M3400CompanyModel company;
  M5500EmployeeModel employee;
  final shiftBLOC = ShiftBloc();
  final shiftAssignmentBLOC = ShiftAssignmentBloc();
  final timekeepingBLOC = TimekeepingBloc();

  List<M3000ShiftAssignmentModel> listShiftAssignment = [];
  List<M3200ShiftModel> listShift = [];

  Directory tempDir;
  File jsonFile;

  init() async {
    _minuteString = _formatMinute(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getMinuteTime());
    _hourString = _formatHour(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getHourTime());

    // get email and id company
    preferences = await SharedPreferences.getInstance();
    final String userJSON = preferences.getString('user');
    final String companyJSON = preferences.getString('company');
    this.employee = M5500EmployeeModel.fromJson(json.decode(userJSON));
    this.company = M3400CompanyModel.fromJson(json.decode(companyJSON));
    print('employee id ${this.employee.id}');
    print('company id ${this.company.id}');

    shiftAssignmentBLOC.callWhat3007(this.company.id, this.employee.id,
        this.employee.IdDepartment, this.employee.IdBranch);

    shiftAssignmentBLOC.shiftAssignmentStream3007
        .listen(_handleShiftAssignmentReturn);

    shiftBLOC.shiftStream3207.listen(_handleShiftReturn);

    timekeepingBLOC.timekeepingStream2507
        .listen(_handleTimeKeepingHasCheckinReturn);
    Map<String, dynamic> mapEmployee =
        jsonDecode(preferences.getString("user"));
    Map<String, dynamic> mapCompany =
        jsonDecode(preferences.getString("company"));

    advanceSalaryBloc.advanceSalaryStream2309.listen((event) {
      setState(() {
        countTotalWaitApprove = advanceSalaryBloc.countTotalWaitApprove;
        countTotalApproved = advanceSalaryBloc.countTotalApproved;
        countTotalDenied = advanceSalaryBloc.countTotalDenied;
      });
    });

    employeeId = this.employee.id;
    companyId = this.company.id;
    imageEmployee = mapEmployee['Image'];
    employeeName = mapEmployee['Fullname'];

    advanceSalaryBloc.callWhat2309({
      "IdEmployee": employeeId.toString(),
      "IdCompany": companyId.toString(),
      "CreatedAt":
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
    });
  }

  _handleTimeKeepingHasCheckinReturn(event) {
    // print(
    //     'timekeepingBLOC.listTimekeeping2507 ${timekeepingBLOC.listTimekeeping2507}');
    List<M2500TimekeepingModel> tempListTimeKeeping =
        timekeepingBLOC.listTimekeeping2507;
    _handleTimeKeepingHasCheckinReturnChildFunc(tempListTimeKeeping);
  }

  _handleTimeKeepingHasCheckinReturnChildFunc(
      List<M2500TimekeepingModel> tempListTimeKeeping) {
    if (tempListTimeKeeping.length > 0) {
      M2500TimekeepingModel tempTimeKeeping = tempListTimeKeeping[0];
      for (var i = 0; i < listShift.length; i++) {
        if (listShift[i].id == tempTimeKeeping.IdShift) {
          int indexOfShift = i;
          listShift[i].timeKeeping = tempTimeKeeping;
          _prepareHandleCheckoutListShift(indexOfShift);
          break;
        }
      }
    }
  }

  _handleShiftAssignmentReturn(event) {
    setState(() {
      listShiftAssignment = shiftAssignmentBLOC.listShiftAssignment3007;
    });
    // print('listShiftAssignment ${listShiftAssignment}');
    List<int> arrayShiftAssignmentID = [];
    for (var i = 0; i < listShiftAssignment.length; i++) {
      arrayShiftAssignmentID.add(int.parse(listShiftAssignment[i].IdShift));
    }

    // print('arrayShiftAssignmentID ${arrayShiftAssignmentID}');
    var param = {
      "arrayID": arrayShiftAssignmentID,
      "IdCompany": this.company.id,
      "IdEmployee": this.employee.id,
      "what": 3207
    };
    shiftBLOC.callWhat3207(param);
  }

  _handleShiftReturn(event) async {
    // print('event ${event}');
    // print('shiftBLOC listShift3207');
    setState(() {
      listShiftAssignment = [];
      listShift = [];
      // print('shiftBLOC listShift3207 ${shiftBLOC.listShift3207}');
      listShift = shiftBLOC.listShift3207;
      _prepareHandleCheckinListShift();
    });
  }

  _prepareHandleCheckoutListShift(int indexOfShift) async {
    setState(() {
      listShift[indexOfShift].hasCheckin = listShift[indexOfShift]
                  .timeKeeping !=
              null
          ? int.parse(listShift[indexOfShift].timeKeeping.IdTimekeepingStatus) >
                  0
              ? true
              : false
          : false;

      if (listShift[indexOfShift].hasCheckin) {
        listShift[indexOfShift].hasCheckout =
            listShift[indexOfShift].timeKeeping != null
                ? int.parse(listShift[indexOfShift]
                            .timeKeeping
                            .IdTimekeepingStatus) >
                        1
                    ? true
                    : false
                : false;
      }

      listShift[indexOfShift].canTakeActionWithShiftNow =
          _checkCanTakeActionWithShiftNow(indexOfShift);
    });

    // print(
    //     'hasCheckin ${listShift[indexOfShift].hasCheckin} hasCheckout ${listShift[indexOfShift].hasCheckout} canTakeActionWithShiftNow ${listShift[indexOfShift].canTakeActionWithShiftNow} canCheckinAction ${listShift[indexOfShift].canCheckinAction} canWillCheckinAction ${listShift[indexOfShift].canWillCheckinAction} canCheckoutAction ${listShift[indexOfShift].canCheckoutAction} canWillCheckoutAction ${listShift[indexOfShift].canWillCheckoutAction}');

    final DateTime now = DateTime.now();
    final String currentHourString = _formatHour(now);
    final String currentMinuteString = _formatMinute(now);

    final int currentHour = int.parse(currentHourString);
    final int currentMinute = int.parse(currentMinuteString);

    final int checkoutStartHour =
        int.parse(listShift[indexOfShift].CheckoutStartHour);
    final int checkoutStartMinute =
        int.parse(listShift[indexOfShift].CheckoutStartMinute);

    final int checkoutEndHour =
        int.parse(listShift[indexOfShift].CheckoutEndHour);
    final int checkoutEndMinute =
        int.parse(listShift[indexOfShift].CheckoutEndMinute);

    // print(
    //     'Kiem tra trang thai co the checkout ${listShift[indexOfShift].Name}');
    // print(
    //     'Xem ca da check in hay chua, neu chua checkin thi return luon ${listShift[indexOfShift].hasCheckin}');

    if (!listShift[indexOfShift].hasCheckin) return;

    if (((currentHour == checkoutStartHour &&
                currentMinute >= checkoutStartMinute) ||
            (currentHour > checkoutStartHour)) &&
        ((currentHour == checkoutEndHour &&
                currentMinute <= checkoutEndMinute) ||
            (currentHour < checkoutEndHour))) {
      listShift[indexOfShift].currentTypeAction = 'checkout';

      listShift[indexOfShift].canCheckoutAction = true;

      listShift[indexOfShift].checkoutCountDown =
          DateTime.now().millisecondsSinceEpoch +
              (((checkoutEndHour - currentHour) * 3600) +
                      ((checkoutEndMinute - currentMinute) * 60) +
                      (60 - DateTime.now().second)) *
                  1000;
    } else if ((currentHour < checkoutStartHour) ||
        (currentHour == checkoutStartHour &&
            currentMinute < checkoutStartMinute)) {
      listShift[indexOfShift].currentTypeAction = 'checkout-soon';
      listShift[indexOfShift].canWillCheckoutAction = true;
      listShift[indexOfShift].checkoutWillCountDown =
          DateTime.now().millisecondsSinceEpoch +
              (((checkoutStartHour - currentHour) * 3600) +
                      ((checkoutStartMinute - currentMinute) * 60) +
                      (60 - DateTime.now().second)) *
                  1000;
    }

    listShift[indexOfShift].timelineCheckin = [];
    listShift[indexOfShift].timelineCheckin.add(
        new TimelineCheckin(id: 0, done: true, action: '...', datetime: null));
    listShift[indexOfShift].timelineCheckin.add(new TimelineCheckin(
        id: 1, done: false, action: 'Vào ca', datetime: null));
    listShift[indexOfShift].timelineCheckin.add(new TimelineCheckin(
        id: 2, done: false, action: 'Ra ca', datetime: null));
    listShift[indexOfShift].timelineCheckin.add(
        new TimelineCheckin(id: 3, done: false, action: '...', datetime: null));
    if (listShift[indexOfShift].timeKeeping != null) {
      // print(
      //     'listShift[indexOfShift].timeKeeping.CheckinTime != null ${listShift[indexOfShift].timeKeeping.toJson()}');
      // print(
      //     'listShift[indexOfShift].timeKeeping.CheckinTime != null ${listShift[indexOfShift].timeKeeping.CheckinTime} ${listShift[indexOfShift].timeKeeping.CheckinTime != null}');
      // print(
      //     'listShift[indexOfShift].timeKeeping.CheckoutTime != null ${listShift[indexOfShift].timeKeeping.CheckoutTime} ${listShift[indexOfShift].timeKeeping.CheckoutTime != null}');
      // print(
      //     'listShift[indexOfShift].timeKeeping.CheckoutTime != 0000-00-00 00:00:00 ${listShift[indexOfShift].timeKeeping.CheckoutTime} ${listShift[indexOfShift].timeKeeping.CheckoutTime != "0000-00-00 00:00:00"}');
      // print(
      //     '${listShift[indexOfShift].timeKeeping.CheckoutTime.runtimeType} ${"0000-00-00 00:00:00".runtimeType}');
      if (listShift[indexOfShift].timeKeeping.CheckinTime != null &&
          listShift[indexOfShift].timeKeeping.CheckinTime !=
              "0000-00-00 00:00:00") {
        listShift[indexOfShift].timelineCheckin[1].done = true;
        listShift[indexOfShift].timelineCheckin[1].datetime =
            DateTime.parse(listShift[indexOfShift].timeKeeping.CheckinTime);
      }
      if (listShift[indexOfShift].timeKeeping.CheckoutTime != null &&
          listShift[indexOfShift].timeKeeping.CheckoutTime !=
              "0000-00-00 00:00:00") {
        listShift[indexOfShift].timelineCheckin[2].done = true;
        listShift[indexOfShift].timelineCheckin[2].datetime =
            DateTime.parse(listShift[indexOfShift].timeKeeping.CheckoutTime);
        listShift[indexOfShift].timelineCheckin[3].done = true;
      }
    }
  }

  _prepareHandleCheckinListShift() async {
    for (var i = 0; i < listShift.length; i++) {
      int indexOfShift = i;

      // print(
      //     'listShift[indexOfShift].timeKeeping ${listShift[indexOfShift].timeKeeping}');

      final DateTime now = DateTime.now();
      final String currentHourString = _formatHour(now);
      final String currentMinuteString = _formatMinute(now);

      final int currentHour = int.parse(currentHourString);
      final int currentMinute = int.parse(currentMinuteString);

      final int checkinStartHour =
          int.parse(listShift[indexOfShift].CheckinStartHour);
      final int checkinStartMinute =
          int.parse(listShift[indexOfShift].CheckinStartMinute);

      final int checkinEndHour =
          int.parse(listShift[indexOfShift].CheckinEndHour);
      final int checkinEndMinute =
          int.parse(listShift[indexOfShift].CheckinEndMinute);

      // print(
      //     'currentHour ${currentHour} currentMinute ${currentMinute} checkinStartHour ${checkinStartHour} checkinStartMinute ${checkinStartMinute} checkinEndHour ${checkinEndHour} checkinEndMinute ${checkinEndMinute}');
      //
      // print(
      //     '( (currentHour == checkinStartHour && currentMinute >= checkinStartMinute) || (currentHour > checkinStartHour) ) ${((currentHour == checkinStartHour && currentMinute >= checkinStartMinute) || (currentHour > checkinStartHour))} ( (currentHour == checkinEndHour && currentMinute <= checkinEndMinute) || (currentHour < checkinEndHour) ) ${((currentHour == checkinEndHour && currentMinute <= checkinEndMinute) || (currentHour < checkinEndHour))}');
      if (((currentHour == checkinStartHour &&
                  currentMinute >= checkinStartMinute) ||
              (currentHour > checkinStartHour)) &&
          ((currentHour == checkinEndHour &&
                  currentMinute <= checkinEndMinute) ||
              (currentHour < checkinEndHour))) {
        listShift[indexOfShift].canCheckinAction = true;
        listShift[indexOfShift].currentTypeAction = 'checkin';
        //  Create dem nguoc co the check in
        listShift[indexOfShift].checkinCountDown =
            DateTime.now().millisecondsSinceEpoch +
                (((checkinEndHour - currentHour) * 3600) +
                        ((checkinEndMinute - currentMinute) * 60) +
                        (60 - DateTime.now().second)) *
                    1000;

        // timekeepingBLOC.callWhat2507({
        //   "what": 2507,
        //   "IdShift": listShift[indexOfShift].id,
        //   "IdCompany": listShift[indexOfShift].IdCompany,
        //   "IdEmployee": employee.id
        // });
      } else if ((currentHour == checkinStartHour &&
              currentMinute < checkinStartMinute) ||
          (currentHour < checkinStartHour)) {
        // checkinComingSoon = true;
        listShift[indexOfShift].canWillCheckinAction = true;
        listShift[indexOfShift].currentTypeAction = 'checkin-soon';
        //  Create dem nguoc co the check in gan toi gio
        listShift[indexOfShift].checkinWillCountDown =
            DateTime.now().millisecondsSinceEpoch +
                (((checkinStartHour - currentHour) * 3600) +
                        ((checkinStartMinute - currentMinute) * 60) +
                        (60 - DateTime.now().second)) *
                    1000;
      } else {
        listShift[indexOfShift].canTakeActionWithShiftNow =
            _checkCanTakeActionWithShiftNow(indexOfShift);

        // timekeepingBLOC.callWhat2507({
        //   "what": 2507,
        //   "IdShift": listShift[indexOfShift].id,
        //   "IdCompany": listShift[indexOfShift].IdCompany,
        //   "IdEmployee": employee.id
        // });
      }

      _prepareHandleCheckoutListShift(indexOfShift);

      listShift[indexOfShift].canTakeActionWithShiftNow =
          _checkCanTakeActionWithShiftNow(indexOfShift);
      listShift[indexOfShift].shiftInTimeRangeNow =
          _checkShiftInTimeRangeNow(indexOfShift);
    }

    _findShiftActiveSoonOrActive();
  }

  _findShiftActiveSoonOrActive() {
    for (var i = 0; i < listShift.length; i++) {
      final DateTime now = DateTime.now();
      final String currentHourString = _formatHour(now);
      final String currentMinuteString = _formatMinute(now);

      final int currentHour = int.parse(currentHourString);
      final int currentMinute = int.parse(currentMinuteString);

      final int hourStartCheckInShift =
          int.parse(listShift[i].CheckinStartHour);
      final int checkinStartMinute = int.parse(listShift[i].CheckinStartHour);

      final int checkoutEndHour = int.parse(listShift[i].CheckoutEndHour);
      final int checkoutEndMinute = int.parse(listShift[i].CheckoutEndMinute);

      if (((currentHour == hourStartCheckInShift &&
                  currentMinute >= checkinStartMinute) ||
              (currentHour > hourStartCheckInShift)) &&
          ((currentHour == checkoutEndHour &&
                  currentMinute <= checkoutEndMinute) ||
              (currentHour < checkoutEndHour))) {
        setState(() {
          initIndexShiftActiveOrActiveSoon = i;
          _currentIndexShiftActive = i;
        });
        break;
      }
    }
    if (initIndexShiftActiveOrActiveSoon == -1) {
      List<int> diffMinute = [];

      int tempDiff = 99999999;
      int tempIndex = 0;
      for (var i = 0; i < listShift.length; i++) {
        final DateTime now = DateTime.now();
        final String currentHourString = _formatHour(now);
        final String currentMinuteString = _formatMinute(now);

        final int currentHour = int.parse(currentHourString);
        final int currentMinute = int.parse(currentMinuteString);

        final int hourStartCheckInShift =
            int.parse(listShift[i].CheckinStartHour);
        final int checkinStartMinute =
            int.parse(listShift[i].CheckinStartMinute);
        int _tempDiff = (((hourStartCheckInShift - currentHour) * 60) +
            (checkinStartMinute - currentMinute));
        if (_tempDiff < tempDiff) {
          tempIndex = i;
          tempDiff = _tempDiff;
        }
      }
      setState(() {
        initIndexShiftActiveOrActiveSoon = tempIndex;
        _currentIndexShiftActive = tempIndex;
      });
    }
    // if (initIndexShiftActiveOrActiveSoon == -1) initIndexShiftActiveOrActiveSoon = 0;
  }

  _checkCanTakeActionWithShiftNow(int shiftIndex) {
    if (listShift[shiftIndex].currentTypeAction == 'checkin' ||
        ((listShift[shiftIndex].currentTypeAction == 'checkout' ||
                listShift[shiftIndex].currentTypeAction == 'checkout-soon') &&
            listShift[shiftIndex].hasCheckin)) {
      return true;
    }
    return false;
  }

  _checkShiftInTimeRangeNow(int shiftIndex) {
    final DateTime now = DateTime.now();
    final String currentHourString = _formatHour(now);
    final String currentMinuteString = _formatMinute(now);

    final int currentHour = int.parse(currentHourString);
    final int currentMinute = int.parse(currentMinuteString);

    final int hourStartCheckInShift =
        int.parse(listShift[shiftIndex].CheckinStartHour);
    final int checkinStartMinute =
        int.parse(listShift[shiftIndex].CheckinStartMinute);

    final int checkoutEndHour =
        int.parse(listShift[shiftIndex].CheckoutEndHour);
    final int checkoutEndMinute =
        int.parse(listShift[shiftIndex].CheckoutEndMinute);

    if (((currentHour == hourStartCheckInShift &&
                currentMinute >= checkinStartMinute) ||
            (currentHour > hourStartCheckInShift)) &&
        ((currentHour == checkoutEndHour &&
                currentMinute <= checkoutEndMinute) ||
            (currentHour < checkoutEndHour))) {
      return true;
    }
    return false;
  }

  int _currentIndexShiftActive = 0;
  int initIndexShiftActiveOrActiveSoon = -1;

  // WIDGET REQUEST MANAGER SECTION
  Widget _shiftAssignmentCard(M3200ShiftModel shift) {
    const kTileHeight = 50.0;

    const completeColor = Color(0xff5e6172);
    const inProgressColor = Color(0xff5ec792);
    const todoColor = Color(0xffd1d2d7);

    int _processIndex = 2;

    Color getColor(int index) {
      if (index == _processIndex) {
        return inProgressColor;
      } else if (index < _processIndex) {
        return completeColor;
      } else {
        return todoColor;
      }
    }

    final widthContent = MediaQuery.of(context).size.width -
        20 -
        ((MediaQuery.of(context).size.width - 20) / 5);
    return InkWell(
      onTap: () {
        // launchScreen(context, Routes.itimeManagerRequest);
      },
      child: Container(
        width: widthContent,
        decoration: BoxDecoration(
          color: getColorFromHex("#FFFFFF"),
          borderRadius: BorderRadius.circular(18.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Container(
            //   // padding: const EdgeInsets.only(
            //   //     left: 10.0, top: 15.0, bottom: 15.0),
            //   width: widthContent,
            //   height: 150,
            //   child: Timeline.tileBuilder(
            //     builder: TimelineTileBuilder.fromStyle(
            //       contentsAlign: ContentsAlign.basic,
            //       contentsBuilder: (context, index) => Padding(
            //         padding: const EdgeInsets.all(24.0),
            //         child: Text('Timeline Event $index'),
            //       ),
            //       itemCount: 10,
            //     ),
            //   ),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  // padding: const EdgeInsets.only(
                  //     left: 10.0, top: 15.0, bottom: 15.0),
                  width: widthContent,
                  child: Text(
                    // shift.Name + ' - ' + shift.currentTypeAction,
                    shift.Name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: itime_text_size_medium,
                        fontWeight: FontWeight.bold,
                        color: shift.canTakeActionWithShiftNow == true
                            ? Colors.green
                            : Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                text: 'Từ ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: itime_text_size_medium,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: shift.StartHour.toString() +
                        ' giờ ' +
                        shift.StartMinute.toString() +
                        ' phút',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: itime_text_size_medium,
                    ),
                  ),
                  TextSpan(
                    text: ' đến ',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: itime_text_size_medium,
                    ),
                  ),
                  TextSpan(
                    text: shift.EndHour.toString() +
                        ' giờ ' +
                        shift.EndMinute.toString() +
                        ' phút',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: itime_text_size_medium,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            // shift.shiftInTimeRangeNow
            //     ? Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           Container(
            //             // padding: const EdgeInsets.only(
            //             //     left: 10.0, top: 15.0, bottom: 15.0),
            //             width: widthContent,
            //             child: Text(
            //               shift.canTakeActionWithShiftNow
            //                   ? '(Đang diễn ra)'
            //                   : '(Đã bỏ lỡ)',
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 fontSize: itime_text_size_medium,
            //                 // fontWeight: FontWeight.bold,
            //                 color: Colors.grey,
            //               ),
            //             ),
            //           ),
            //         ],
            //       )
            //     : Center(),
            // shift.shiftInTimeRangeNow
            //     ? SizedBox(
            //   height: 10,
            // ): Center(),
            shift.shiftInTimeRangeNow && !shift.canTakeActionWithShiftNow
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // padding: const EdgeInsets.only(
                        //     left: 10.0, top: 15.0, bottom: 15.0),
                        width: widthContent,
                        child: Text(
                          '(Đã bỏ lỡ)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: itime_text_size_medium,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(),
            // shift.shiftInTimeRangeNow
            //     ? SizedBox(
            //         height: 10,
            //       )
            //     : Center(),
            Container(
              width: widthContent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  shift.timelineCheckin != null
                      ? Container(
                          // padding: const EdgeInsets.only(
                          //     left: 10.0, top: 15.0, bottom: 15.0),
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.greenAccent,
                          height: 80,
                          child: Timeline.tileBuilder(
                            // shrinkWrap: true,
                            // scrollDirection: Axis.horizontal,
                            theme: TimelineThemeData(
                              direction: Axis.horizontal,
                              connectorTheme: ConnectorThemeData(
                                space: 30.0,
                                thickness: 3.0,
                              ),
                            ),
                            builder: TimelineTileBuilder.connected(
                              contentsBuilder: (context, index) {
                                var color = (index == 0 || index == 3)
                                    ? Colors.grey
                                    : shift.timelineCheckin[index].done == true
                                        ? Colors.green
                                        : Colors.grey;
                                var widthConten = (index == 0 || index == 3)
                                    ? MediaQuery.of(context).size.width / 8
                                    : MediaQuery.of(context).size.width / 4;
                                return Container(
                                    width: widthConten,
                                    child: Text(
                                      shift.timelineCheckin[index].action,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: color),
                                    ));
                                return Text(
                                  shift.timelineCheckin[index].action,
                                  style: TextStyle(color: color),
                                );
                              },
                              oppositeContentsBuilder: (context, index) {
                                var color = (index == 0 || index == 3)
                                    ? Colors.grey
                                    : shift.timelineCheckin[index].done == true
                                        ? Colors.green
                                        : Colors.grey;
                                var widthConten = (index == 0 || index == 3)
                                    ? MediaQuery.of(context).size.width / 8
                                    : MediaQuery.of(context).size.width / 4;
                                return Container(
                                    width: widthConten,
                                    child: Text(
                                      dateFormatterShort(shift
                                          .timelineCheckin[index].datetime),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: color),
                                    ));
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0, right: 15),
                                  child: Text(
                                    dateFormatterShort(
                                        shift.timelineCheckin[index].datetime),
                                    style: TextStyle(color: color),
                                  ),
                                );
                              },
                              indicatorBuilder: (_, index) {
                                var color;
                                var child;
                                // print(
                                //     'shift.timelineCheckin[index].done ${shift.timelineCheckin[index].done}');
                                if (index == 0 || index == 3) {
                                  child = Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                        color: Colors.black26,
                                        border: Border.all(
                                          color: Colors.black26,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                  );
                                } else {
                                  if (!shift.timelineCheckin[index].done) {
                                    color = Colors.white;
                                    child = Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        border: Border.all(
                                          color: Colors.white24,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.more_horiz,
                                        color: color,
                                        size: 15.0,
                                      ),
                                    );
                                  } else {
                                    color = Colors.green;
                                    child = Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        border: Border.all(
                                          color: Colors.white24,
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: color,
                                        size: 15.0,
                                      ),
                                    );
                                  }
                                }
                                return child;
                              },
                              connectorBuilder: (_, index, type) {
                                // if (index > 0) {
                                if (!shift.timelineCheckin[index].done) {
                                  final prevColor = getColor(index - 1);
                                  final color = getColor(index);
                                  List<Color> gradientColors;
                                  if (type == ConnectorType.start) {
                                    gradientColors = [
                                      Color.lerp(prevColor, color, 0.5),
                                      color
                                    ];
                                  } else {
                                    gradientColors = [
                                      prevColor,
                                      Color.lerp(prevColor, color, 0.5)
                                    ];
                                  }
                                  return DecoratedLineConnector(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: gradientColors,
                                      ),
                                    ),
                                  );
                                } else {
                                  return SolidLineConnector(
                                    color: getColor(index),
                                  );
                                }
                                // } else {
                                //   return null;
                                // }
                              },
                              // con
                              // indicatorBuilder: (context, index) => IndicatorStyle.dot,
                              // indicatorStyle: IndicatorStyle.outlined,
                              // connectorStyle: ConnectorStyle.dashedLine,
                              itemCount: shift.timelineCheckin.length,
                            ),
                          ),
                        )
                      : Center(),
                  shift.hasCheckin
                      ? Center()
                      : Container(
                          width: widthContent,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    width: 15,
                                  ),
                                ),
                                shift.canCheckinAction == true
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: InkWell(
                                          onTap: () {
                                            showProgress(context);
                                            ExtendedNavigator.of(
                                              context,
                                              rootRouter: true,
                                            )
                                                .push(
                                              Routes.itimeCheckinNormal,
                                              arguments:
                                                  ItimeCheckinNormalArguments(
                                                shift: shift,
                                                company: company,
                                                employee: employee,
                                              ),
                                            )
                                                .then((val) {
                                              if (val != null && val) {
                                                timekeepingBLOC.callWhat2507({
                                                  "what": 2507,
                                                  "IdShift": shift.id,
                                                  "IdCompany": shift.IdCompany,
                                                  "IdEmployee": employee.id
                                                });
                                              }
                                              // print(
                                              //     'ItimeCheckinNormalArguments callback close ${val}');
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            width: widthContent,
                                            decoration: BoxDecoration(
                                              color: getColorFromHex("#24A949"),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    "Vào ca",
                                                    style: TextStyle(
                                                      fontSize:
                                                          itime_text_size_medium,
                                                      color: getColorFromHex(
                                                          "#FFFFFF"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(),
                                SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    width: 15,
                                  ),
                                ),
                                shift.canCheckinAction == true
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        child: InkWell(
                                          onTap: () async {
                                            showProgress(context);

                                            ExtendedNavigator.of(
                                              context,
                                              rootRouter: true,
                                            )
                                                .push(
                                              Routes.itimeCheckinCamera,
                                              arguments:
                                                  ItimeCheckinCameraArguments(
                                                shift: shift,
                                                company: company,
                                                employee: employee,
                                              ),
                                            )
                                                .then((val) {
                                              if (val != null && val) {
                                                timekeepingBLOC.callWhat2507({
                                                  "what": 2507,
                                                  "IdShift": shift.id,
                                                  "IdCompany": shift.IdCompany,
                                                  "IdEmployee": employee.id
                                                });
                                              }
                                            });

                                            // , rootNavigator:true
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 0.0,
                                                right: 0.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            width: widthContent,
                                            decoration: BoxDecoration(
                                              color: getColorFromHex("#24A949"),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    "Vào camera",
                                                    style: TextStyle(
                                                      fontSize:
                                                          itime_text_size_medium,
                                                      color: getColorFromHex(
                                                          "#FFFFFF"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    width: 15,
                                  ),
                                ),
                              ]),
                        ),
                  shift.hasCheckout
                      ? Center()
                      : Container(
                          width: widthContent,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    width: 15,
                                  ),
                                ),
                                shift.canCheckoutAction &&
                                        shift.canTakeActionWithShiftNow
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: InkWell(
                                          onTap: () {
                                            showProgress(context);
                                            ExtendedNavigator.of(
                                              context,
                                              rootRouter: true,
                                            )
                                                .push(
                                              Routes.itimeCheckoutNormal,
                                              arguments:
                                                  ItimeCheckoutNormalArguments(
                                                shift: shift,
                                                company: company,
                                                employee: employee,
                                              ),
                                            )
                                                .then((val) {
                                              if (val != null && val) {
                                                timekeepingBLOC.callWhat2507({
                                                  "what": 2507,
                                                  "IdShift": shift.id,
                                                  "IdCompany": shift.IdCompany,
                                                  "IdEmployee": employee.id
                                                });
                                              }
                                              // print(
                                              //     'ItimeCheckinNormalArguments callback close ${val}');
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 10.0,
                                                right: 10.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            width: widthContent,
                                            decoration: BoxDecoration(
                                              color: getColorFromHex("#24A949"),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    "Ra ca",
                                                    style: TextStyle(
                                                      fontSize:
                                                          itime_text_size_medium,
                                                      color: getColorFromHex(
                                                          "#FFFFFF"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(),
                                SizedBox(
                                  height: 10,
                                ),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    width: 15,
                                  ),
                                ),
                                shift.canCheckoutAction == true &&
                                        shift.canTakeActionWithShiftNow
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        child: InkWell(
                                          onTap: () async {
                                            showProgress(context);

                                            ExtendedNavigator.of(
                                              context,
                                              rootRouter: true,
                                            )
                                                .push(
                                              Routes.itimeCheckoutCamera,
                                              arguments:
                                                  ItimeCheckoutCameraArguments(
                                                shift: shift,
                                                company: company,
                                                employee: employee,
                                              ),
                                            )
                                                .then((val) {
                                              if (val != null && val) {
                                                timekeepingBLOC.callWhat2507({
                                                  "what": 2507,
                                                  "IdShift": shift.id,
                                                  "IdCompany": shift.IdCompany,
                                                  "IdEmployee": employee.id
                                                });
                                              }
                                            });

                                            // , rootNavigator:true
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 0.0,
                                                right: 0.0,
                                                top: 10.0,
                                                bottom: 10.0),
                                            width: widthContent,
                                            decoration: BoxDecoration(
                                              color: getColorFromHex("#24A949"),
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Center(
                                                  child: Text(
                                                    "Ra camera",
                                                    style: TextStyle(
                                                      fontSize:
                                                          itime_text_size_medium,
                                                      color: getColorFromHex(
                                                          "#FFFFFF"),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : Center(),
                                Flexible(
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    width: 15,
                                  ),
                                ),
                              ]),
                        ),
                  SizedBox(
                    height: 10,
                  ),
                  shift.canCheckinAction == true && !shift.hasCheckin
                      ? CountdownTimer(
                          endTime: shift.checkinCountDown,
                          onEnd: () {
                            shift.canCheckinAction = false;
                            _prepareHandleCheckinListShift();
                          },
                          widgetBuilder: (_, CurrentRemainingTime time) {
                            if (time == null) {
                              return Text(
                                'Đang làm mới',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: itime_text_size_medium,
                                ),
                              );
                            }
                            return Text(
                              'Kết thúc vào ca sau ${time.hours == null ? '00' : (time.hours < 10 ? '0' + time.hours.toString() : time.hours.toString())}:${time.min == null ? '00' : (time.min < 10 ? '0' + time.min.toString() : time.min.toString())}:${time.sec == null ? '00' : (time.sec < 10 ? '0' + time.sec.toString() : time.sec.toString())}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: itime_text_size_medium,
                              ),
                            );
                          },
                        )
                      : (shift.canWillCheckinAction == true && !shift.hasCheckin
                          ? CountdownTimer(
                              endTime: shift.checkinWillCountDown,
                              onEnd: () {
                                shift.canWillCheckinAction = false;
                                shift.canCheckinAction = true;
                                _prepareHandleCheckinListShift();
                              },
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                if (time == null) {
                                  return Text(
                                    'Đang làm mới',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: itime_text_size_medium,
                                    ),
                                  );
                                }
                                // print('lol ${time}');
                                return Text(
                                  'Vào ca sau ${time.hours == null ? '00' : (time.hours < 10 ? '0' + time.hours.toString() : time.hours.toString())}:${time.min == null ? '00' : (time.min < 10 ? '0' + time.min.toString() : time.min.toString())}:${time.sec == null ? '00' : (time.sec < 10 ? '0' + time.sec.toString() : time.sec.toString())}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: itime_text_size_medium,
                                  ),
                                );
                              },
                            )
                          : Center()),
                  shift.canCheckoutAction &&
                          shift.canTakeActionWithShiftNow &&
                          !shift.hasCheckout
                      ? CountdownTimer(
                          endTime: shift.checkoutCountDown,
                          onEnd: () {
                            shift.canCheckoutAction = false;
                            _prepareHandleCheckinListShift();
                          },
                          widgetBuilder: (_, CurrentRemainingTime time) {
                            if (time == null) {
                              return Text(
                                'Đang làm mới',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: itime_text_size_medium,
                                ),
                              );
                            }
                            return Text(
                              'Kết thúc ra sau ${time.hours == null ? '00' : (time.hours < 10 ? '0' + time.hours.toString() : time.hours.toString())}:${time.min == null ? '00' : (time.min < 10 ? '0' + time.min.toString() : time.min.toString())}:${time.sec == null ? '00' : (time.sec < 10 ? '0' + time.sec.toString() : time.sec.toString())}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: itime_text_size_medium,
                              ),
                            );
                          },
                        )
                      : (shift.canWillCheckoutAction == true
                          ? CountdownTimer(
                              endTime: shift.checkoutWillCountDown,
                              onEnd: () {
                                shift.canWillCheckoutAction = false;
                                shift.canCheckoutAction = true;
                                _prepareHandleCheckinListShift();
                              },
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                if (time == null) {
                                  return Text(
                                    'Đang làm mới',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: itime_text_size_medium,
                                    ),
                                  );
                                }
                                // print('lol ${time}');
                                return Text(
                                  'Ra ca sau ${time.hours == null ? '00' : (time.hours < 10 ? '0' + time.hours.toString() : time.hours.toString())}:${time.min == null ? '00' : (time.min < 10 ? '0' + time.min.toString() : time.min.toString())}:${time.sec == null ? '00' : (time.sec < 10 ? '0' + time.sec.toString() : time.sec.toString())}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: itime_text_size_medium,
                                  ),
                                );
                              },
                            )
                          : Center()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // END WIDGET REQUEST MANAGER SECTION

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    try {
      setState(() {
        listShiftAssignment = [];
        listShift = [];
      });

      advanceSalaryBloc.callWhat2309({
        "IdEmployee": employeeId.toString(),
        "IdCompany": companyId.toString(),
        "CreatedAt":
            "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
      });

      await shiftAssignmentBLOC.callWhat3007(this.company.id, this.employee.id,
          this.employee.IdDepartment, this.employee.IdBranch);
      _refreshController.refreshCompleted();
    } catch (e) {
      // _refreshController.refreshFailed();
      // _showToast(e.message.toString(), 2);
    }
  }

  _onLoadingMore() async {
    try {
      // Load more post
      _refreshController.loadComplete();
    } catch (e) {
      // _showToast(e.message.toString(), 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    // WIDGET INFO FIRST
    Widget _infoFirstSection() {
      return InkWell(
        onTap: () {
          // launchScreen(context, Routes.itimeTaskReport);
        },
        child: Container(
          padding: EdgeInsets.all(5.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: getColorFromHex("#FFFFFF"),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: <Widget>[
                '${imageEmployee.toString()}'.contains("null")
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                                image:
                                NetworkImage("https://scontent.fdad4-1.fna.fbcdn.net/v/t1.6435-9/131099524_3479755855581840_3704586785001698229_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=Iwnfngk0B00AX9QCYOK&_nc_ht=scontent.fdad4-1.fna&oh=c38fa2a0bae92a409bc375190fca976b&oe=60D3DC66")
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                              image:
                                  NetworkImage("https://scontent.fdad4-1.fna.fbcdn.net/v/t1.6435-9/131099524_3479755855581840_3704586785001698229_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=Iwnfngk0B00AX9QCYOK&_nc_ht=scontent.fdad4-1.fna&oh=c38fa2a0bae92a409bc375190fca976b&oe=60D3DC66")
                            ),
                          ),
                        ),
                      ),
                SizedBox(width: 10.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${employeeName.toString()}'.contains("null")
                          ? 'Loading...'
                          : 'Xin chào',
                      style: TextStyle(
                        fontSize: itime_text_size_medium,
                        fontWeight: FontWeight.bold,
                        color: getColorFromHex("#FF5500"),
                        wordSpacing: 2,
                      ),
                    ),
                    Text('Nguyễn Huyền Trí',style: TextStyle(
                      fontSize: itime_text_size_medium
                    ),)
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }
    // END WIDGET INFO FIRST

    // WIDGET CHECK IN SECTION
    Widget _checkInSection() {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: getColorFromHex("#FFFFFF"),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // Container(
            //   // padding: const EdgeInsets.only(
            //   //     left: 10.0, top: 15.0, bottom: 15.0),
            //   width: MediaQuery.of(context).size.width,
            //   height: 150,
            //   child: Timeline.tileBuilder(
            //     builder: TimelineTileBuilder.fromStyle(
            //       contentsAlign: ContentsAlign.basic,
            //       contentsBuilder: (context, index) => Padding(
            //         padding: const EdgeInsets.all(24.0),
            //         child: Text('Timeline Event $index'),
            //       ),
            //       itemCount: 10,
            //     ),
            //   ),
            // ),
            // Container(
            //   // padding: const EdgeInsets.only(
            //   //     left: 10.0, top: 15.0, bottom: 15.0),
            //   width: MediaQuery.of(context).size.width,
            //   height: 150,
            //   child: Timeline.tileBuilder(
            //     // shrinkWrap: true,
            //     scrollDirection: Axis.horizontal,
            //     builder: TimelineTileBuilder.fromStyle(
            //       contentsBuilder: (context, index) => Card(
            //         child: Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text('Contents'),
            //         ),
            //       ),
            //       oppositeContentsBuilder: (context, index) => Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Text('opposite\ncontents'),
            //       ),
            //       itemCount: 20,
            //     ),
            //   ),
            // ),
           
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  // height: 300,
                  color: Color(0xFFF0F2F5),
                  width: MediaQuery.of(context).size.width - 20,
                  child: listShift.length > 0
                      ? CarouselSlider.builder(
                          itemCount: listShift.length,
                          options: CarouselOptions(
                              autoPlay: false,
                              aspectRatio: 1.5,
                              enlargeCenterPage: true,
                              initialPage: initIndexShiftActiveOrActiveSoon,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _currentIndexShiftActive = index;
                                });
                              }),
                          itemBuilder: (context, index, realIdx) {
                            // print('render id ${index}');
                            return _shiftAssignmentCard(listShift[index]);
                          },
                        )
                      : Center(),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: listShift.map((shift) {
                      int index = listShift.indexOf(shift);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentIndexShiftActive == index
                              ? Color.fromRGBO(0, 0, 0, 0.9)
                              : Color.fromRGBO(0, 0, 0, 0.4),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    // END WIDGET CHECK IN SECTION

    // WIDGET REQUEST MANAGER SECTION
    Widget _requestManagerSection() {
      return InkWell(
        onTap: () {
          launchScreen(context, Routes.itimeManagerRequest);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: getColorFromHex("#FFFFFF"),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.insert_chart,
                      color: getColorFromHex("#FF93B3"),
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quản lý yêu cầu',
                            style: TextStyle(
                              fontSize: itime_text_size_medium,
//                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            color: getColorFromHex("#F9C030"),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              '3',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            color: getColorFromHex("#38D46A"),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              '4',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                        Container(
                          width: 17,
                          height: 17,
                          decoration: BoxDecoration(
                            color: getColorFromHex("#D0011B"),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 5.0),
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    // END WIDGET REQUEST MANAGER SECTION

    // WIDGET TIMEKEEPING MANAGER SECTION
    Widget _timeKeepingManagerSection() {
      return InkWell(
        onTap: () {
          launchScreen(context, Routes.itimeTimeKeeping);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: getColorFromHex("#FFFFFF"),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 15.0, bottom: 15.0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_circle,
                      color: getColorFromHex("#F5A62A"),
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lịch sử chấm công',
                            style: TextStyle(
                              fontSize: itime_text_size_medium,
//                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    // WIDGET TIMEKEEPING MANAGER SECTION

    return Container(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // color: getColorFromHex("#FFFF00"),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: SmartRefresher(
        enablePullDown: true,
        // enablePullUp: true,
        header: WaterDropMaterialHeader(distance: 100),
        footer: CustomFooter(
          builder: (BuildContext context, LoadStatus mode) {
            Widget body;
            if (mode == LoadStatus.idle) {
              body = Text(
                "Pull up load more",
                style: TextStyle(
                  color: Colors.black87,
                  // fontSize: fontSizeRefresh,
                ),
              );
            } else if (mode == LoadStatus.loading) {
              body = CupertinoActivityIndicator();
            } else if (mode == LoadStatus.failed) {
              body = Text(
                "Load failed! Click retry!",
                style: TextStyle(
                  color: Colors.black87,
                  // fontSize: fontSizeRefresh,
                ),
              );
            } else if (mode == LoadStatus.canLoading) {
              body = Text(
                "Release to load more",
                style: TextStyle(
                  color: Colors.black87,
                  // fontSize: fontSizeRefresh,
                ),
              );
            } else {
              body = Column(
                children: <Widget>[
                  Text(
                    "No more Data",
                    style: TextStyle(
                      color: Colors.black87,
                      // fontSize: fontSizeRefresh,
                    ),
                  ),
                  SizedBox(
                      // height: fontSizeSizedboxBottom,
                      ),
                ],
              );
            }
            return Container(
              // height: fontSizeContainerRefesh,
              child: Center(child: body),
            );
          },
        ),
        controller: _refreshController,
        onRefresh: _onRefresh,
        // onLoading: _onLoadingMore,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: getColorFromHex("#FFFFFF"),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text('${dateFormatter(DateTime.now())}'),
            ),
            SizedBox(height: 10.0),
            _infoFirstSection(),
            SizedBox(height: 10.0),
            _checkInSection(),
            SizedBox(height: 10.0),
            _requestManagerSection(),
            SizedBox(height: 10.0),
            _timeKeepingManagerSection(),
            // Column(
            //   children: [
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
