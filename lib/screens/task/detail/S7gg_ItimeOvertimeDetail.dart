import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItimeOvertimeDetail extends StatefulWidget {
  final employeeId;
  final isOvertime;
  final idOvertime;
  final statusName;

  const ItimeOvertimeDetail(
      {Key key,
      this.employeeId,
      this.isOvertime,
      this.idOvertime,
      this.statusName})
      : super(key: key);

  @override
  _ItimeOvertimeDetailState createState() => _ItimeOvertimeDetailState();
}

class _ItimeOvertimeDetailState extends State<ItimeOvertimeDetail> {
  // Get list from future
  final overtimeBloc = new OvertimeBloc();
  final _repository = new Repository();

  // Get list model

  // Define base data type
  String employeeId;
  String companyId;

  bool isShowBottom = false;
  bool isShowPress = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  // Define datetime
  DateTime selectedDate = DateTime.now();

  String period = 'AM';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy hh:mm");

  Future<bool> moveToLastScreen() {
    return Future.value(false);
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
          padding: const EdgeInsets.only(top: 5.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: itime_black,
              size: 25,
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
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Center(
                child: Text(
                  'Làm thêm giờ',
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

    // INFORMATION EMPLOYEE & REQUEST
    Widget _informationEmployeeAndRequest(
        {String employeeName,
        String status,
        String statusName,
        String dateAndTime}) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            color: getColorFromHex("FFFFFF"),
            borderRadius: BorderRadius.circular(5.0),
          ),
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tên nhân viên',
                      style: TextStyle(
                        color: getColorFromHex("A1A1A1"),
                      ),
                    ),
                    Text('${employeeName.toString()}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tình trạng',
                      style: TextStyle(
                        color: getColorFromHex("A1A1A1"),
                      ),
                    ),
                    Text(
                      '${statusName.toString()}',
                      style: TextStyle(
                        color: status == '1'
                            ? getColorFromHex("#F9C130")
                            : status == '2'
                            ? getColorFromHex("#38D46D")
                            : status == '3'
                            ? getColorFromHex("#D0011C")
                            : getColorFromHex("#38D46D"),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ngày gửi',
                      style: TextStyle(
                        color: getColorFromHex("A1A1A1"),
                      ),
                    ),
                    Text('${dateFormat.format(DateTime.parse(dateAndTime))}'),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Yêu cầu',
                      style: TextStyle(
                        color: getColorFromHex("A1A1A1"),
                      ),
                    ),
                    Text('Yêu cầu làm thêm giờ'),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    // END INFORMATION EMPLOYEE & REQUEST

    return WillPopScope(
      onWillPop: () => moveToLastScreen(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: itime_main_background,
          appBar: _appbarSection(),
          body: ListView(
            shrinkWrap: true,
            children: [
              StreamBuilder(
                  stream: overtimeBloc.overtimeStream1813,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Padding(
                          padding: const EdgeInsets.only(top: 60.0),
                          child: SpinKitRipple(
                            size: 60,
                            color: itime_main_color,
                          ),
                        );
                        break;
                      default:
                        if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        } else {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // INFORMATION EMPLOYEE & REQUEST
                              _informationEmployeeAndRequest(
                                status: snapshot.data[0]['IdStatusApprove'],
                                dateAndTime: snapshot.data[0]['CreatedAt'],
                                employeeName: snapshot.data[0]['Fullname'],
                                statusName: snapshot.data[0]
                                    ['StatusApproveName'],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Chi tiết',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ),
                              // DETAIL REQUEST
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: getColorFromHex("FFFFFF"),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  padding: const EdgeInsets.all(5.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Loại làm thêm giờ',
                                              style: TextStyle(
                                                color:
                                                    getColorFromHex("A1A1A1"),
                                              ),
                                            ),
                                            Text(
                                                '${snapshot.data[0]['OvertimeTypeName'].toString()}'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Chi nhánh',
                                              style: TextStyle(
                                                color:
                                                    getColorFromHex("A1A1A1"),
                                              ),
                                            ),
                                            Text(
                                                '${snapshot.data[0]['OvertimeBranch'].toString()}'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Thời gian bắt đầu',
                                              style: TextStyle(
                                                color: getColorFromHex(
                                                  "A1A1A1",
                                                ),
                                              ),
                                            ),
                                            Text(
                                                '${dateTimeFormat.format(DateTime.parse(snapshot.data[0]['FromTime'].toString()))}'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Thời gian kết thúc',
                                              style: TextStyle(
                                                color: getColorFromHex(
                                                  "A1A1A1",
                                                ),
                                              ),
                                            ),
                                            Text(
                                                '${dateTimeFormat.format(DateTime.parse(snapshot.data[0]['EndTime'].toString()))}'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Mã số làm thêm giờ',
                                              style: TextStyle(
                                                color:
                                                    getColorFromHex("A1A1A1"),
                                              ),
                                            ),
                                            Text('${widget.idOvertime}'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Thời gian làm thêm',
                                              style: TextStyle(
                                                color:
                                                    getColorFromHex("A1A1A1"),
                                              ),
                                            ),
                                            Text(
                                                '${snapshot.data[0]['OvertimeHour'].toString()}'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Lý do',
                                              style: TextStyle(
                                                color:
                                                    getColorFromHex("A1A1A1"),
                                              ),
                                            ),
                                            Text(
                                                '${snapshot.data[0]['Reason'].toString()}'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Nội dung trao đổi',
                                              style: TextStyle(
                                                color:
                                                    getColorFromHex("A1A1A1"),
                                              ),
                                            ),
                                            Text(
                                                '${snapshot.data[0]['Content'].toString()}'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                    }
                  }),
            ],
          ),
          bottomNavigationBar: widget.statusName == '1'
              ? Container(
                  color: Colors.transparent,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 5.0),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (!isShowPress) {
                                setState(() {
                                  isShowPress = true;
                                });

                                _showProgress(context, 2).whenComplete(() {});

                                _repository.r1800OvertimeProvider
                                    .p1800Overtime(1803, {
                                  "id": widget.idOvertime,
                                }).whenComplete(() {
                                  ExtendedNavigator.of(context).pop(true);
                                });
                              } else {
                                print('not repress');
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              height: 50,
                              child: Center(
                                child: Text(
                                  'Xóa',
                                  style: TextStyle(
                                    color: getColorFromHex("DF3651"),
                                    // fontSize: 17,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 2,
                      //   child: Padding(
                      //     padding: EdgeInsets.only(
                      //         top: 10, bottom: 10, right: 10, left: 5.0),
                      //     child: Container(
                      //       decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         borderRadius: BorderRadius.circular(5.0),
                      //       ),
                      //       height: 50,
                      //       child: Center(
                      //         child: Text(
                      //           'Chỉnh sửa',
                      //           style: TextStyle(
                      //             color: getColorFromHex("24A949"),
                      //             fontSize: 17,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                )
              : Visibility(visible: false, child: Text('hello')),
        ),
      ),
    );
  }

  // get data employeeId, companyId
  _getData() async {
    preferences = await SharedPreferences.getInstance();
    // get data employee
    Map<String, dynamic> mapEmployee =
        jsonDecode(preferences.getString("user"));
    employeeId = mapEmployee['id'];

    // get data company
    Map<String, dynamic> mapCompany =
        jsonDecode(preferences.getString("company"));

    companyId = mapCompany['id'];

    overtimeBloc.callWhat1813({
      "IdEmployee": widget.employeeId,
      "id": widget.idOvertime,
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
    overtimeBloc.dispose();
    super.dispose();
  }
}
