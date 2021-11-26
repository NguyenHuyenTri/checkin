import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens.dart';

class ItimeTimeKeeping extends StatefulWidget {
  @override
  _ItimeTimeKeepingState createState() => _ItimeTimeKeepingState();
}

class _ItimeTimeKeepingState extends State<ItimeTimeKeeping> {
  // Get list from future
  final timeKeepingBloc = new TimekeepingBloc();

  // Get list model

  // Define base data type
  String employeeId;
  String employeeName;
  String companyId;

  int _currentSelection = 0;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  // Define datetime
  DateTime selectedDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  DateFormat dateFormatSelectmonth = DateFormat("MM-yyyy");
  DateTime selectedToDate = DateTime.now();

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  DateTime initialDate = new DateTime.now();

  var _timeKeepingListByDay = [];

  double height;
  double width;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    try {
      _loadList();
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
      // _showToast(e.message.toString(), 2);
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: selectedDate ?? this.initialDate,
      locale: Locale("vi"),
    ).then((date) {
      if (date != null) {
        setState(() {
          selectedDate = date;
          print('selectedDate month ${selectedDate}');
          _getData();
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    // WIDGET APPBAR SECTION
    Widget _appbarSection() {
      return AppBar(
        backgroundColor: iconColorPrimary,
        leading: Container(
          // padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: itime_black,
              // size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Lịch sử vào/ra',
                style: TextStyle(
                  color: appTextColorPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: itime_text_size_normal + 2,
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET APPBAR SECTION

    // TAB WIDGET SECTION
    Widget _tabWidgetSection() {
      return Padding(
        padding:
            EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _currentSelection = 0;
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      color: _currentSelection == 0
                          ? Colors.white
                          : Colors.white38,
                    ),
                    child: _currentSelection == 0
                        ? Center(
                            child: Text(
                              'Chấm công',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Chấm công',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      _currentSelection = 1;
                    });
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                      color: _currentSelection == 1
                          ? Colors.white
                          : Colors.white38,
                    ),
                    child: _currentSelection == 1
                        ? Center(
                            child: Text(
                              'Bảng công',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                              ),
                            ),
                          )
                        : Center(
                            child: Text(
                              'Bảng công',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    // END TAB WIDGET SECTION

    // WIDGET SECTION REQUEST CONTAINER
    Widget _checkinContainerSection(index) {
      var itemE;
      if (_currentSelection == 0)
        itemE = _timeKeepingListByDay[index];
      else if (_currentSelection == 1)
        itemE = _timeKeepingListByDay[index];
      else if (_currentSelection == 2) itemE = _timeKeepingListByDay[index];
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: getColorFromHex("#BFBFBF"),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5.0),
                  topRight: Radius.circular(5.0),
                ),
              ),
              child: Center(
                  child: Text(
                '${itemE['DayOfWeek']}, ${dateFormat.format(DateTime.parse(itemE['CreatedAt']))}',
                style: TextStyle(
                  fontSize: itime_text_size_medium,
                  fontWeight: FontWeight.w600,
                ),
              )),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: getColorFromHex("#FFFFFF"),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${itemE['Fullname']}',
                                    style: TextStyle(
                                      fontSize: itime_text_size_medium,
                                    ),
                                  ),
                                  Text(
                                    'Vào ca - ${itemE['ShiftName']}',
                                    style: TextStyle(
                                      fontSize: itime_text_size_medium - 2,
                                      color: getColorFromHex("#A1A1A1"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${itemE['CheckinTime']}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: Container(
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    '${itemE['Fullname']}',
                                    style: TextStyle(
                                      fontSize: itime_text_size_medium,
                                    ),
                                  ),
                                  Text(
                                    'Ra ca - ${itemE['ShiftName']}',
                                    style: TextStyle(
                                      fontSize: itime_text_size_medium - 2,
                                      color: getColorFromHex("#A1A1A1"),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('${itemE['CheckoutTime']}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // TIME KEEPING TAB
    Widget timekeepingTabSection() {
      return Container(
        // color: Colors.blue,
        width: width,
        height: height,
        child: ListView.builder(
          itemCount: _currentSelection == 0
              ? _timeKeepingListByDay.length
              : _currentSelection == 1
                  ? _timeKeepingListByDay.length
                  : _timeKeepingListByDay.length,
          itemBuilder: (context, index) {
            return _checkinContainerSection(index);
          },
        ),
      );
    }
    // END TIME KEEPING TAB

    return Scaffold(
      // backgroundColor: Colors.deepOrangeAccent,
      body: SafeArea(
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final maxHeight = constraints.maxHeight;
            final maxWidth = constraints.maxWidth;
            this.height = maxHeight;
            this.width = maxWidth;
            final width = maxWidth;
            return Scaffold(
              backgroundColor: itime_main_background,
              appBar: _appbarSection(),
              body: Container(
                // color: Colors.red,
                width: width,
                height: height,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        // color: Colors.blue,
                        width: width,
                        height: height,
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
                                      height: 25,
                                    ),
                                  ],
                                );
                              }
                              return Container(
                                height: 25,
                                child: Center(child: body),
                              );
                            },
                          ),
                          controller: _refreshController,
                          onRefresh: _onRefresh,
                          // onLoading: _onLoadingMore,
                          child: Column(
                            children: [
                              _tabWidgetSection(),
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  child: Card(
                                      elevation: 0.0,
                                      child: ListTile(
                                        onTap: () {
                                          _selectDate(context).whenComplete(() {
                                            print(
                                                "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
                                            // _showProgress(context, 2);
                                            // setState(() {
                                            // });
                                          });
                                        },
                                        title: Text(
                                          'Chọn tháng báo cáo',
                                          style: primaryTextStyle(),
                                        ),
                                        subtitle: Text(
                                          "${dateFormatSelectmonth.format(selectedDate)}",
                                          style: secondaryTextStyle(),
                                        ),
                                      )),
                                ),
                              ),
                              _currentSelection == 0
                                  ? _timeKeepingListByDay.length == 0 ? Center(
                                child: CircularProgressIndicator(),
                              ) : Expanded(child: timekeepingTabSection())
                                  : Expanded(child: PayrollTab())
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // get data employeeId, companyId
  _getData() async {
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> mapEmployee =
        jsonDecode(preferences.getString("user"));
    Map<String, dynamic> mapCompany =
        jsonDecode(preferences.getString("company"));

    employeeId = mapEmployee['id'];
    companyId = mapCompany['id'];
    employeeName = mapEmployee['Fullname'];

    timeKeepingBloc.timeKeepingStream2510.listen((event) {
      // var tempArr = [];
      // for (var i = 0; i < timeKeepingBloc.listTimeKeeping2510.length; i++) {
      //   var found = false;
      //   for (var j = 0; j < tempArr.length; j++) {
      //     if (tempArr[j]['key'] ==
      //         dateFormat.format(DateTime.parse(
      //             timeKeepingBloc.listTimeKeeping2510[i]['CreatedAt']))) {
      //       found = true;
      //       tempArr[j]['data'].add(timeKeepingBloc.listTimeKeeping2510[i]);
      //     }
      //   }
      //   if (!found) {
      //     tempArr.add({
      //       'key': dateFormat.format(DateTime.parse(
      //           timeKeepingBloc.listTimeKeeping2510[i]['CreatedAt'])),
      //       'name': timeKeepingBloc.listTimeKeeping2510[i]['DayOfWeek'],
      //       'data': [timeKeepingBloc.listTimeKeeping2510[i]]
      //     });
      //   }
      // }
      // print('tempArr ${tempArr}');
      setState(() {
        _timeKeepingListByDay = timeKeepingBloc.listTimeKeeping2510;
      });
    });

    _loadList();
  }

  _loadList() {
    setState(() {
      _timeKeepingListByDay = [];
    });
    timeKeepingBloc.callWhat2510({
      "IdEmployee": employeeId.toString(),
      "IdCompany": companyId.toString(),
      "CreatedAt":
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
    });
  }

  // alert and move screen
  Future _getFuture(int time) {
    return Future(() async {
      await Future.delayed(Duration(seconds: time));
      return 'Hello, Future Progress Dialog!';
    });
  }

  Future<void> _showProgress(BuildContext context, int time) async {
    await showDialog(
        context: context,
        builder: (context) => FutureProgressDialog(_getFuture(time)));
  }

  @override
  void dispose() {
    timeKeepingBloc.dispose();

    super.dispose();
  }
}
