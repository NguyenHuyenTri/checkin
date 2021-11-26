import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vao_ra/helpers/converter.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

import '../screens.dart';

class ItimeManagerRequest extends StatefulWidget {
  @override
  _ItimeManagerRequestState createState() => _ItimeManagerRequestState();
}

class _ItimeManagerRequestState extends State<ItimeManagerRequest> {
  // Get list from future
  final advanceSalaryBloc = AdvanceSalaryBloc();

  // Get list model
  var businessTripList = [];

  // Define base data type
  int _currentSelection = 0;
  String employeeId;
  String companyId;

  int countTotalWaitApprove = 0;
  int countTotalApproved = 0;
  int countTotalDenied = 0;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  // Define datetime
  DateTime selectedDate = DateTime.now();
  DateTime currentDate = DateTime.now();

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  DateFormat dateFormatSelectmonth = DateFormat("MM-yyyy");
  DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy hh:mm");

  DateTime initialDate = new DateTime.now();

  var requestList2308 = [];
  var requestList2310 = [];
  var requestList2311 = [];

  double height;
  double width;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    try {
      _listenStream();
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
    _listenStream();
  }

  @override
  Widget build(BuildContext context) {
    Widget _statusRequestWidget(String statusApprove) {
      return statusApprove == 1.toString()
          ? Text(
              'Chờ duyệt',
              style: TextStyle(
                color: getColorFromHex("#F9C130"),
              ),
            )
          : statusApprove == 2.toString()
              ? Text(
                  'Đã duyệt',
                  style: TextStyle(
                    color: getColorFromHex("#38D46D"),
                  ),
                )
              : statusApprove == 3.toString()
                  ? Text(
                      'Từ chối',
                      style: TextStyle(
                        color: getColorFromHex("#D0011C"),
                      ),
                    )
                  : Text('');
    }

    ;
    // CARD ADVANCE SALARY REQUEST
    Widget _advanceSalaryRequest(
        {String createdAt, String money, String statusApprove}) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Tạm ứng lương',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${moneyFormat(money.toString())} VNĐ',
                style: TextStyle(
                  fontSize: 14.0,
                  color: getColorFromHex("#A0A0A0"),
                ),
              ),
              _statusRequestWidget(statusApprove),
            ],
          ),
          SizedBox(height: 5.0),
        ],
      );
    }
    // END CARD ADVANCE SALARY REQUEST

    // CARD OVERTIME REQUEST
    Widget _overtimeRequest(
        {String createdAt, String overtimeType, String statusApprove}) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Làm thêm giờ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${overtimeType.toString()}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: getColorFromHex("#A0A0A0"),
                ),
              ),
              _statusRequestWidget(statusApprove),
            ],
          ),
          SizedBox(height: 5.0),
        ],
      );
    }
    // END CARD OVERTIME REQUEST

    // CARD ON LEAVE REQUEST
    Widget _onLeaveRequest(
        {String createdAt,
        String idTypeLeave,
        String fromDate,
        String toDate,
        String statusApprove,
        String shiftName}) {
      // idTypeLeave: itemE['IdTypeLeave'],
      // fromDate: itemE['FromDate'],
      // toDate: itemE['ToDate'],
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Nghỉ phép',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              idTypeLeave == "1"
                  ? Text(
                      '${shiftName.toString()}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: getColorFromHex("#A0A0A0"),
                      ),
                    )
                  : Center(),
              idTypeLeave == "2"
                  ? Text(
                      '${fromDate.toString()}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: getColorFromHex("#A0A0A0"),
                      ),
                    )
                  : Center(),
              idTypeLeave == "3"
                  ? Text(
                      '${dateFormat.format(DateTime.parse(fromDate.toString()))} đến ${dateFormat.format(DateTime.parse(toDate.toString()))}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: getColorFromHex("#A0A0A0"),
                      ),
                    )
                  : Center(),
              Flexible(
                fit: FlexFit.tight,
                child: SizedBox(
                  width: 15,
                ),
              ),
              _statusRequestWidget(statusApprove),
            ],
          ),
          SizedBox(height: 5.0),
        ],
      );
    }
    // END CARD ON LEAVE REQUEST

    // CARD CHECKIN LATE REQUEST
    Widget _checkinLateRequest(
        {String createdAt, String statusApprove, String shiftName}) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Xin đi trễ',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${shiftName.toString()}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: getColorFromHex("#A0A0A0"),
                ),
              ),
              _statusRequestWidget(statusApprove),
            ],
          ),
          SizedBox(height: 5.0),
        ],
      );
    }
    // END CARD CHECKIN LATE REQUEST

    // CARD CHECKOUT SOON REQUEST
    Widget _checkoutSoonRequest(
        {String createdAt, String statusApprove, String shiftName}) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Xin về sớm',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${shiftName.toString()}',
                style: TextStyle(
                  fontSize: 14.0,
                  color: getColorFromHex("#A0A0A0"),
                ),
              ),
              _statusRequestWidget(statusApprove),
            ],
          ),
          SizedBox(height: 5.0),
        ],
      );
    }
    // END CARD CHECKOUT SOON REQUEST

    // CARD BUSINESS TRIP REQUEST
    Widget _businessTripRequest(
        {String createdAt, String statusApprove, String place}) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Công tác/Ra ngoài',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 140,
                child: Text(
                  '${place.toString()}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: getColorFromHex("#A0A0A0"),
                  ),
                ),
              ),
              _statusRequestWidget(statusApprove),
            ],
          ),
          SizedBox(height: 5.0),
        ],
      );
    }
    // END CARD BUSINESS TRIP REQUEST

    // WIDGET SECTION REQUEST CONTAINER
    Widget _requestContainerSection(index) {
      var itemE;
      if (_currentSelection == 0)
        itemE = requestList2308[index];
      else if (_currentSelection == 1)
        itemE = requestList2310[index];
      else if (_currentSelection == 2) itemE = requestList2311[index];
      return Padding(
        padding: const EdgeInsets.only(
            left: 10.0, right: 10.0, bottom: 3.0, top: 5.0),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            if (itemE['IsOnLeave'] == '1') {
              ExtendedNavigator.of(
                context,
              )
                  .push(Routes.itimeOnLeaveDetail,
                      arguments: ItimeOnLeaveDetailArguments(
                        employeeId: employeeId,
                        idOnLeave: itemE['id'],
                        isOnLeave: itemE['IsOnLeave'],
                        statusName: itemE['IdStatusApprove'],
                      ))
                  .then((val) {
                if (val != null && val) {
                  setState(() {
                    _currentSelection = 0;
                  });
                  _getData();
                }
              });
              // launchScreen(context, Routes.itimeOnLeaveDetail,
              //     arguments: ItimeOnLeaveDetailArguments(
              //       employeeId: employeeId,
              //       idOnLeave: itemE['id'],
              //       isOnLeave: itemE['IsOnLeave'],
              //       statusName: itemE['IdStatusApprove'],
              //     ));
            } else if (itemE['IsOvertime'] == '1') {
              ExtendedNavigator.of(
                context,
              )
                  .push(Routes.itimeOvertimeDetail,
                  arguments: ItimeOvertimeDetailArguments(
                    employeeId: employeeId,
                    idOvertime: itemE['id'],
                    isOvertime: itemE['IsOvertime'],
                    statusName: itemE['IdStatusApprove'],
                  ))
                  .then((val) {
                if (val != null && val) {
                  setState(() {
                    _currentSelection = 0;
                  });
                  _getData();
                }
              });
              // launchScreen(context, Routes.itimeOvertimeDetail,
              //     arguments: ItimeOvertimeDetailArguments(
              //       employeeId: employeeId,
              //       idOvertime: itemE['id'],
              //       isOvertime: itemE['IsOvertime'],
              //       statusName: itemE['IdStatusApprove'],
              //     ));
            } else if (itemE['IsAdvanceSalary'] == '1') {
              ExtendedNavigator.of(
                context,
              )
                  .push(Routes.itimeAdvanceSalaryDetail,
                  arguments: ItimeAdvanceSalaryDetailArguments(
                    employeeId: employeeId,
                    idAdvanceSalary: itemE['id'],
                    isAdvanceSalary: itemE['IsAdvanceSalary'],
                    statusName: itemE['IdStatusApprove'],
                  ))
                  .then((val) {
                if (val != null && val) {
                  setState(() {
                    _currentSelection = 0;
                  });
                  _getData();
                }
              });
              // launchScreen(context, Routes.itimeAdvanceSalaryDetail,
              //     arguments: ItimeAdvanceSalaryDetailArguments(
              //       employeeId: employeeId,
              //       idAdvanceSalary: itemE['id'],
              //       isAdvanceSalary: itemE['IsAdvanceSalary'],
              //       statusName: itemE['IdStatusApprove'],
              //     ));
            } else if (itemE['IsCheckinLate'] == '1') {
              ExtendedNavigator.of(
                context,
              )
                  .push(Routes.itimeCheckinLateDetail,
                  arguments: ItimeCheckinLateDetailArguments(
                    employeeId: employeeId,
                    idCheckinLate: itemE['id'],
                    isCheckinLate: itemE['IsCheckinLate'],
                    statusName: itemE['IdStatusApprove'],
                  ))
                  .then((val) {
                if (val != null && val) {
                  setState(() {
                    _currentSelection = 0;
                  });
                  _getData();
                }
              });
              // launchScreen(context, Routes.itimeCheckinLateDetail,
              //     arguments: ItimeCheckinLateDetailArguments(
              //       employeeId: employeeId,
              //       idCheckinLate: itemE['id'],
              //       isCheckinLate: itemE['IsCheckinLate'],
              //       statusName: itemE['IdStatusApprove'],
              //     ));
            } else if (itemE['IsCheckoutSoon'] == '1') {
              ExtendedNavigator.of(
                context,
              )
                  .push(Routes.itimeCheckoutSoonDetail,
                  arguments: ItimeCheckoutSoonDetailArguments(
                    employeeId: employeeId,
                    idCheckoutSoon: itemE['id'],
                    isCheckoutSoon: itemE['IsCheckoutSoon'],
                    statusName: itemE['IdStatusApprove'],
                  ))
                  .then((val) {
                if (val != null && val) {
                  setState(() {
                    _currentSelection = 0;
                  });
                  _getData();
                }
              });
              // launchScreen(context, Routes.itimeCheckoutSoonDetail,
              //     arguments: ItimeCheckoutSoonDetailArguments(
              //       employeeId: employeeId,
              //       idCheckoutSoon: itemE['id'],
              //       isCheckoutSoon: itemE['IsCheckoutSoon'],
              //       statusName: itemE['IdStatusApprove'],
              //     ));
            } else if (itemE['IsBusinessTrip'] == '1') {
              ExtendedNavigator.of(
                context,
              )
                  .push(Routes.itimeBusinessTripDetail,
                  arguments: ItimeBusinessTripDetailArguments(
                    employeeId: employeeId,
                    idBusinessTrip: itemE['id'],
                    isBusinessTrip: itemE['IsBusinessTrip'],
                  ))
                  .then((val) {
                if (val != null && val) {
                  setState(() {
                    _currentSelection = 0;
                  });
                  _getData();
                }
              });
              // launchScreen(context, Routes.itimeBusinessTripDetail,
              //     arguments: ItimeBusinessTripDetailArguments(
              //       employeeId: employeeId,
              //       idBusinessTrip: itemE['id'],
              //       isBusinessTrip: itemE['IsBusinessTrip'],
              //     ));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
            ),
            padding: const EdgeInsets.all(10.0),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // if request is overtime
                itemE['IsOvertime'] == '1'
                    ? _overtimeRequest(
                        overtimeType: itemE['OvertimeTypeName'],
                        statusApprove: itemE['IdStatusApprove'],
                        createdAt: itemE['CreatedAt'],
                      )
                    // if request is advance salary
                    : itemE['IsAdvanceSalary'] == '1'
                        ? _advanceSalaryRequest(
                            createdAt: itemE['CreatedAt'],
                            money: itemE['Money'],
                            statusApprove: itemE['IdStatusApprove'])
                        // if request is business trip
                        : itemE['IsBusinessTrip'] == '1'
                            ? _businessTripRequest(
                                statusApprove: itemE['IdStatusApprove'],
                                createdAt: itemE['CreatedAt'],
                                place: itemE['Place'],
                              )
                            // if request is on leave
                            : itemE['IsOnLeave'] == '1'
                                ? _onLeaveRequest(
                                    shiftName: itemE['ShiftName'],
                                    createdAt: itemE['CreatedAt'],
                                    idTypeLeave: itemE['IdTypeLeave'],
                                    fromDate: itemE['FromDate'],
                                    toDate: itemE['ToDate'],
                                    statusApprove: itemE['IdStatusApprove'])
                                //if request is checkin late
                                : itemE['IsCheckinLate'] == '1'
                                    ? _checkinLateRequest(
                                        statusApprove: itemE['IdStatusApprove'],
                                        createdAt: itemE['CreatedAt'],
                                        shiftName: itemE['ShiftName'])
                                    // if request is checkout soon
                                    : itemE['IsCheckoutSoon'] == '1'
                                        ? _checkoutSoonRequest(
                                            statusApprove:
                                                itemE['IdStatusApprove'],
                                            createdAt: itemE['CreatedAt'],
                                            shiftName: itemE['ShiftName'])
                                        : Visibility(
                                            visible: false, child: Text('')),
              ],
            ),
          ),
        ),
      );
    }

    // WIDGET APPBAR SECTION
    Widget _appbarSection() {
      return AppBar(
        backgroundColor: iconColorPrimary,
        leading: Container(
          padding: const EdgeInsets.only(top: 5.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: itime_black,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            //   child: Icon(Icons.add),
            //   onPressed: () async {
            //     _openRecommendAndRequest();
            //   },
            icon: const Icon(
              Icons.add,
              color: Colors.black,
            ),
            tooltip: 'Show Snackbar',
            onPressed: () {
              print("delete");
              _openRecommendAndRequest();
              // scaffoldKey.currentState.showSnackBar(snackBar);
            },
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: Text(
                  'Quản lý yêu cầu',
                  style: TextStyle(
                    color: appTextColorPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: itime_text_size_normal + 2,
                  ),
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
            EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
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
                      // advanceSalaryBloc.callWhat2309({
                      //   "IdEmployee": employeeId.toString(),
                      //   "IdCompany": companyId.toString(),
                      //   "CreatedAt":
                      //       "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                      // });
                    });
                  },
                  child: Container(
                    // padding: EdgeInsets.only(left: 20.0),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0)),
                      color: _currentSelection == 0
                          ? Colors.white
                          : Colors.white38,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _currentSelection == 0
                            ? Text(
                                'Chờ duyệt',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              )
                            : Text(
                                'Chờ duyệt',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              ),
                        SizedBox(width: 2.0),
                        StreamBuilder(
                            stream: advanceSalaryBloc.advanceSalaryStream2309,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _currentSelection == 0
                                        ? getColorFromHex("#F9C030")
                                        : getColorFromHex("#ffd877"),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${countTotalWaitApprove.toString()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: getColorFromHex("#F9C030"),
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                child: Center(
                                  child: Text(
                                    '0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
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
                      // advanceSalaryBloc.callWhat2309({
                      //   "IdEmployee": employeeId.toString(),
                      //   "IdCompany": companyId.toString(),
                      //   "CreatedAt":
                      //       "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                      // });
                    });
                  },
                  child: Container(
                    // padding: EdgeInsets.only(left: 5.0),
                    height: 50,
                    color:
                        _currentSelection == 1 ? Colors.white : Colors.white38,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _currentSelection == 1
                            ? Center(
                                child: Text(
                                  'Đã duyệt',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Đã duyệt',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                        SizedBox(width: 2.0),
                        StreamBuilder(
                            stream: advanceSalaryBloc.advanceSalaryStream2309,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _currentSelection == 1
                                          ? getColorFromHex("#38D46A")
                                          : getColorFromHex("#7bd699"),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${countTotalApproved.toString()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _currentSelection == 1
                                        ? getColorFromHex("#38D46A")
                                        : getColorFromHex("#7bd699"),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
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
                      _currentSelection = 2;
                      // advanceSalaryBloc.callWhat2309({
                      //   "IdEmployee": employeeId.toString(),
                      //   "IdCompany": companyId.toString(),
                      //   "CreatedAt":
                      //       "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
                      // });
                    });
                  },
                  child: Container(
                    // padding: EdgeInsets.only(left: 20.0),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0)),
                      color: _currentSelection == 2
                          ? Colors.white
                          : Colors.white38,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _currentSelection == 2
                            ? Center(
                                child: Text(
                                  'Từ chối',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  'Từ chối',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                        SizedBox(width: 2.0),
                        StreamBuilder(
                            stream: advanceSalaryBloc.advanceSalaryStream2309,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Center(
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _currentSelection == 2
                                          ? getColorFromHex("#FF4E44")
                                          : getColorFromHex("#ff8881"),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${countTotalDenied.toString()}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                              return Center(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _currentSelection == 2
                                        ? getColorFromHex("#FF4E44")
                                        : getColorFromHex("#ff8881"),
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  child: Center(
                                    child: Text(
                                      '0',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })
                      ],
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
                            // scrollDirection: Axis.vertical,
                            // shrinkWrap: true,
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
                              Expanded(
                                child: Container(
                                  // color: Colors.blue,
                                  width: width,
                                  height: height,
                                  child: ListView.builder(
                                    itemCount: _currentSelection == 0
                                        ? requestList2308.length
                                        : _currentSelection == 1
                                            ? requestList2310.length
                                            : requestList2311.length,
                                    itemBuilder: (context, index) {
                                      return _requestContainerSection(index);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // floatingActionButton: FloatingActionButton(
                    //   foregroundColor: Colors.white,
                    //   backgroundColor: itime_main_color,
                    //   elevation: 0,
                    //   child: Icon(Icons.add),
                    //   onPressed: () async {
                    //     _openRecommendAndRequest();
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _openRecommendAndRequest() async {
    // final result =
    //     await Navigator.pushNamed(context, Routes.itimeRecommendAndRequest);
    // print(result);
    // if (result != null && result) {
    //   setState(() {});
    //   advanceSalaryBloc.callWhat2309({
    //     "IdEmployee": employeeId.toString(),
    //     "IdCompany": companyId.toString(),
    //     "CreatedAt":
    //         "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
    //   });
    // }
    ExtendedNavigator.of(
      context,
      // rootRouter: true,
    ).push(Routes.itimeRecommendAndRequest).then((val) {
      if (val != null && val) {
        setState(() {
          _currentSelection = 0;
        });
        _getData();
      }
    });
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

    advanceSalaryBloc.callWhat2309({
      "IdEmployee": employeeId.toString(),
      "IdCompany": companyId.toString(),
      "CreatedAt":
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
    });

    //pendding
    advanceSalaryBloc.callWhat2308({
      "IdEmployee": employeeId.toString(),
      "IdCompany": companyId.toString(),
      "CreatedAt":
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
    });

    //accept
    advanceSalaryBloc.callWhat2310({
      "IdEmployee": employeeId.toString(),
      "IdCompany": companyId.toString(),
      "CreatedAt":
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
    });

    //reject
    advanceSalaryBloc.callWhat2311({
      "IdEmployee": employeeId.toString(),
      "IdCompany": companyId.toString(),
      "CreatedAt":
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
    });
  }

  // listen stream
  _listenStream() {
    advanceSalaryBloc.advanceSalaryStream2309.listen((event) {
      countTotalWaitApprove = advanceSalaryBloc.countTotalWaitApprove;
      countTotalApproved = advanceSalaryBloc.countTotalApproved;
      countTotalDenied = advanceSalaryBloc.countTotalDenied;
    });

    // request pedding
    advanceSalaryBloc.requestStream2308.listen((event) {
      print('requestList2308 ${advanceSalaryBloc.requestList2308}');
      setState(() {
        requestList2308 = advanceSalaryBloc.requestList2308;
      });
    });

    // request accept
    advanceSalaryBloc.requestStream2310.listen((event) {
      print('requestStream2310 ${advanceSalaryBloc.requestList2310}');
      setState(() {
        requestList2310 = advanceSalaryBloc.requestList2310;
      });
    });

    // request reject
    advanceSalaryBloc.requestStream2311.listen((event) {
      print('requestStream2311 ${advanceSalaryBloc.requestList2311}');
      setState(() {
        requestList2311 = advanceSalaryBloc.requestList2311;
      });
    });

    _getData();
  }

  @override
  void dispose() {
    advanceSalaryBloc.dispose();

    super.dispose();
  }
}
