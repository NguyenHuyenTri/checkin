import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vao_ra/screens/calendar/build_list_item.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vao_ra/blocs/blocs.dart';

class ItimeCalendarHome extends StatefulWidget {
  @override
  _ItimeCalendarHomeState createState() => _ItimeCalendarHomeState();
}

class _ItimeCalendarHomeState extends State<ItimeCalendarHome> {
  // Get list from future
  final advanceSalaryBloc = new AdvanceSalaryBloc();

  // Get list model
  List _selectedEvents = [];

  // List of the event on particular date.
  Map<DateTime, List> _events = Map<DateTime, List>();
  var listAdvanceSalary;
  var listOvertime;
  var listBusinessTrip;
  var listOnLeave;

  // Define base data type

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  // Define datetime
  DateTime _selectedDay = DateTime.now();
  DateTime selectedDay = DateTime.now();

  // sub function
  _getData() async {
    // get data employee and company
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> mapEmployee =
        jsonDecode(preferences.getString("user"));
    Map<String, dynamic> mapCompany =
        jsonDecode(preferences.getString("company"));

    advanceSalaryBloc.callWhat2308({
      'IdEmployee': mapEmployee['id'],
      'IdCompany': mapCompany['id'],
      "CreatedAt":
          "${selectedDay.year}-${selectedDay.month}-${selectedDay.day}",
    });
  }

  _listenAdvanceSalaryStream() {
    advanceSalaryBloc.requestStream2308.listen((event) {
      listAdvanceSalary = advanceSalaryBloc.listSalaryAdvance2308;
      listOvertime = advanceSalaryBloc.listOvertime2308;
      listBusinessTrip = advanceSalaryBloc.listBusinessTrip2308;
      listOnLeave = advanceSalaryBloc.listOnLeave2308;
      getAllRequest(
          listAdvanceSalary, listOvertime, listBusinessTrip, listOnLeave);
    });
    _getData();
  }

  // get data and put on calendar
  Map<DateTime, List<dynamic>> getAllRequest(var _listSalaryAdvance,
      var _listOvertime, var _listBusinessTrip, var _listOnLeave) {
    // salary advance
    _listSalaryAdvance.forEach((element) {
      if (this._events.containsKey(DateTime(
          DateTime.parse(element['CreatedAt']).year,
          DateTime.parse(element['CreatedAt']).month,
          DateTime.parse(element['CreatedAt']).day))) {
        this
            ._events[DateTime(
                DateTime.parse(element['CreatedAt']).year,
                DateTime.parse(element['CreatedAt']).month,
                DateTime.parse(element['CreatedAt']).day)]
            .add({
          'isListSalary': true,
          'IdCompany': element['IdCompany'],
          'IdEmployee': element['IdEmployee'],
          'Money': element['Money'],
          'Title': element['Title'],
          'isDone': element['IdStatusApprove'],
          'CreatedAt': element['CreatedAt']
        });
      } else {
        this._events.putIfAbsent(
            DateTime(
                DateTime.parse(element['CreatedAt']).year,
                DateTime.parse(element['CreatedAt']).month,
                DateTime.parse(element['CreatedAt']).day),
            () => [
                  {
                    'isListSalary': true,
                    'IdCompany': element['IdCompany'],
                    'IdEmployee': element['IdEmployee'],
                    'Money': element['Money'],
                    'Title': element['Title'],
                    'isDone': element['IdStatusApprove'],
                    'CreatedAt': element['CreatedAt']
                  }
                ]);
      }
    });
    // overtime
    _listOvertime.forEach((element) {
      if (this._events.containsKey(DateTime(
          DateTime.parse(element['CreatedAt']).year,
          DateTime.parse(element['CreatedAt']).month,
          DateTime.parse(element['CreatedAt']).day))) {
        this
            ._events[DateTime(
                DateTime.parse(element['CreatedAt']).year,
                DateTime.parse(element['CreatedAt']).month,
                DateTime.parse(element['CreatedAt']).day)]
            .add({
          'isOvertime': true,
          'IdCompany': element['IdCompany'],
          'IdEmployee': element['IdEmployee'],
          'IdOvertimeType': element['IdOvertimeType'],
          'FromTime': element['FromTime'],
          'EndTime': element['EndTime'],
          'isDone': element['IdStatusApprove'],
          'Reason': element['Reason'],
          'Content': element['Content'],
          'OvertimeHour': element['OvertimeHour'],
          'OvertimeBranch': element['OvertimeBranch'],
          'CreatedAt': element['CreatedAt'],
        });
      } else {
        this._events.putIfAbsent(
            DateTime(
                DateTime.parse(element['CreatedAt']).year,
                DateTime.parse(element['CreatedAt']).month,
                DateTime.parse(element['CreatedAt']).day),
            () => [
                  {
                    'isOvertime': true,
                    'IdCompany': element['IdCompany'],
                    'IdEmployee': element['IdEmployee'],
                    'IdOvertimeType': element['IdOvertimeType'],
                    'FromTime': element['FromTime'],
                    'EndTime': element['EndTime'],
                    'isDone': element['IdStatusApprove'],
                    'Reason': element['Reason'],
                    'Content': element['Content'],
                    'OvertimeHour': element['OvertimeHour'],
                    'OvertimeBranch': element['OvertimeBranch'],
                    'CreatedAt': element['CreatedAt'],
                  }
                ]);
      }
    });
    // business trip
    _listBusinessTrip.forEach((element) {
      if (this._events.containsKey(DateTime(
          DateTime.parse(element['CreatedAt']).year,
          DateTime.parse(element['CreatedAt']).month,
          DateTime.parse(element['CreatedAt']).day))) {
        this
            ._events[DateTime(
                DateTime.parse(element['CreatedAt']).year,
                DateTime.parse(element['CreatedAt']).month,
                DateTime.parse(element['CreatedAt']).day)]
            .add({
          'isBusinessTrip': true,
          'IdCompany': element['IdCompany'],
          'IdEmployee': element['IdEmployee'],
          'TrackingPlace': element['TrackingPlace'],
          'FromTime': element['FromTime'],
          'EndTime': element['EndTime'],
          'isDone': element['IdStatusApprove'],
          'IdShift': element['IdShift'],
        });
      } else {
        this._events.putIfAbsent(
            DateTime(
                DateTime.parse(element['CreatedAt']).year,
                DateTime.parse(element['CreatedAt']).month,
                DateTime.parse(element['CreatedAt']).day),
            () => [
                  {
                    'isBusinessTrip': true,
                    'IdCompany': element['IdCompany'],
                    'IdEmployee': element['IdEmployee'],
                    'TrackingPlace': element['TrackingPlace'],
                    'FromTime': element['FromTime'],
                    'EndTime': element['EndTime'],
                    'isDone': element['IdStatusApprove'],
                    'IdShift': element['IdShift'],
                  }
                ]);
      }
    });
    // on leave
    _listOnLeave.forEach((element) {
      if (this._events.containsKey(DateTime(
          DateTime.parse(element['CreatedAt']).year,
          DateTime.parse(element['CreatedAt']).month,
          DateTime.parse(element['CreatedAt']).day))) {
        this
            ._events[DateTime(
                DateTime.parse(element['CreatedAt']).year,
                DateTime.parse(element['CreatedAt']).month,
                DateTime.parse(element['CreatedAt']).day)]
            .add({
          'isOnLeave': true,
          'IdCompany': element['IdCompany'],
          'IdEmployee': element['IdEmployee'],
          'Content': element['Content'],
          'FromTime': element['FromDate'],
          'EndTime': element['EndDate'],
          'isDone': element['IdStatusApprove'],
          'IdShift': element['IdShift'],
        });
      } else {
        this._events.putIfAbsent(
            DateTime(
                DateTime.parse(element['CreatedAt']).year,
                DateTime.parse(element['CreatedAt']).month,
                DateTime.parse(element['CreatedAt']).day),
            () => [
                  {
                    'isOnLeave': true,
                    'IdCompany': element['IdCompany'],
                    'IdEmployee': element['IdEmployee'],
                    'Content': element['Content'],
                    'FromTime': element['FromDate'],
                    'EndTime': element['EndDate'],
                    'isDone': element['IdStatusApprove'],
                    'IdShift': element['IdShift'],
                  }
                ]);
      }
    });
    print('su kien' + this._events.toString());
    _selectedEvents = this._events[_selectedDay] ?? [];
    print('_selectedEvents ${_selectedEvents}');
    this._handleNewDate(new DateTime.now());
    // return _events;
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    try {
      setState(() {
        // listShiftAssignment = [];
        // listShift = [];
        _selectedEvents = [];
        _events = Map<DateTime, List>();
      });

      await _getData();
      _refreshController.refreshCompleted();
    } catch (e) {
      // _refreshController.refreshFailed();
      // _showToast(e.message.toString(), 2);
    }
  }

  @override
  void initState() {
    super.initState();

    _listenAdvanceSalaryStream();
  }

  @override
  void dispose() {
    advanceSalaryBloc.dispose();

    listAdvanceSalary = [];
    listOvertime = [];
    listBusinessTrip = [];
    listOnLeave = [];
    super.dispose();
  }

  @override
  // to check if the current date has any event or not.
  void _handleNewDate(DateTime date) {
    setState(() {
      print('_handleNewDate');
      DateTime tempDate = new DateTime(date.year, date.month, date.day);
      _selectedDay = tempDate;
      _selectedEvents = _events[_selectedDay] ?? [];
      print('_selectedEvents ${_selectedEvents}');
      print('_selectedDay ${_selectedDay}');
    });
  }

  // WIDGET EMPTY EVENTS
  Widget _emptyEvent() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 25),
          child: Calendar(
            isExpanded: false,
            // if the value is true it will from monday or else sunday
            startOnMonday: true,
            // name of the week as per user choice
            weekDays: [
              "Th 2",
              "Th 3",
              "Th 4",
              "Th 5",
              "Th 6",
              "Th 7",
              "CN"
            ],
            // Events list
            events: _events,
            // it will hide the Today icon in the header of calender
            hideTodayIcon: false,
            // it will highlight the today date and return thr events if there
            onDateSelected: (date) => _handleNewDate(date),
//            initialDate: _selectedDay,
            // you want to expand your calender or not(if not then it will show the current week)
            isExpandable: true,
            // color of the bottom bar
            bottomBarColor: itime_main_color,
            // color of the arrow in bottom bar
            bottomBarArrowColor: Colors.white,
            // style of the text on the bottom bar
            bottomBarTextStyle: TextStyle(color: Colors.white),
            // Completed event color
            eventDoneColor: Colors.green,
            // current selected date color
            selectedColor: itime_main_color,
            // today's date color
            todayColor: itime_main_color,
            // Color of event which are pending
            eventColor: Colors.grey,
            // style fot the day of the week list
            dayOfWeekStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
          ),
        ),
        // if the date has event it will get call
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Center(
            child: Text('Hiện tại chưa có sự kiện nào'),
          ),
        ),
      ],
    );
  }

  // END WIDGET EMPTY EVENTS

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: itime_main_background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: iconColorPrimary,
        title: Text(
          '${DateFormat('dd-MM-yyyy').format(_selectedDay) == DateFormat('dd-MM-yyyy').format(new DateTime.now()) ? "Hôm nay" : "Ngày " + DateFormat('dd-MM-yyyy').format(_selectedDay)} có ${_selectedEvents.length} sự kiện',
          style: TextStyle(
            color: appTextColorPrimary,
            fontSize: itime_text_size_normal - 2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SmartRefresher(
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
        child: StreamBuilder(
          stream: advanceSalaryBloc.requestStream2308,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Calendar(
                      isExpanded: true,
                      // if the value is true it will from monday or else sunday
                      startOnMonday: true,
                      // name of the week as per user choice
                      weekDays: [
                        "Th 2",
                        "Th 3",
                        "Th 4",
                        "Th 5",
                        "Th 6",
                        "Th 7",
                        "CN"
                      ],
                      // Events list
                      events: _events,
                      // it will hide the Today icon in the header of calender
                      hideTodayIcon: false,
                      // it will highlight the today date and return thr events if there
                      onDateSelected: (date) => _handleNewDate(date),
                      // you want to expand your calender or not(if not then it will show the current week)
                      isExpandable: true,
                      // color of the bottom bar
                      bottomBarColor: itime_main_color,
                      // color of the arrow in bottom bar
                      bottomBarArrowColor: Colors.white,
                      // style of the text on the bottom bar
                      bottomBarTextStyle: TextStyle(color: Colors.white),
                      // Completed event color
                      eventDoneColor: Colors.green,
                      // current selected date color
                      selectedColor: itime_main_color,
                      // today's date color
                      todayColor: itime_main_color,
                      // Color of event which are pending
                      eventColor: Colors.grey,
                      // style fot the day of the week list
                      initialDate: new DateTime.now(),
                      dayOfWeekStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 11),
                    ),
                  ),
                  // if the date has event it will get call
                  BuildListItem(
                    selectDate: _selectedEvents,
                  ),
                ],
              );
            }
            return _emptyEvent();
          },
        ),
      ),
    );
  }
}
