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

class ItimeBusinessTripDetail extends StatefulWidget {
  final employeeId;
  final isBusinessTrip;
  final idBusinessTrip;
  final statusName;

  const ItimeBusinessTripDetail(
      {Key key,
      this.employeeId,
      this.isBusinessTrip,
      this.idBusinessTrip,
      this.statusName})
      : super(key: key);

  @override
  _ItimeBusinessTripDetailState createState() =>
      _ItimeBusinessTripDetailState();
}

class _ItimeBusinessTripDetailState extends State<ItimeBusinessTripDetail> {
  // Get list from future
  final businessTripBloc = new BusinessTripBloc();
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
                  'Công tác/Ra ngoài',
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
        {String employeeName, String dateAndTime}) {
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
                    Text('Yêu cầu công tác/ra ngoài'),
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
                  stream: businessTripBloc.businessTripStream1709,
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
                                dateAndTime: snapshot.data[0]['CreatedAt'],
                                employeeName: snapshot.data[0]['Fullname'],
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
                                              'Thời gian bắt đầu',
                                              style: TextStyle(
                                                color:
                                                    getColorFromHex("A1A1A1"),
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
                                                color:
                                                    getColorFromHex("A1A1A1"),
                                              ),
                                            ),
                                            Text(
                                                '${dateTimeFormat.format(DateTime.parse(snapshot.data[0]['EndTime'].toString()))}'),
                                          ],
                                        ),
                                      ),
//                                      Padding(
//                                        padding: const EdgeInsets.all(10.0),
//                                        child: Row(
//                                          mainAxisAlignment:
//                                          MainAxisAlignment.spaceBetween,
//                                          children: [
//                                            Text(
//                                              'Ca làm',
//                                              style: TextStyle(
//                                                color: getColorFromHex(
//                                                  "A1A1A1",
//                                                ),
//                                              ),
//                                            ),
//                                            Text(
//                                                '${snapshot.data[0]['ShiftName'].toString()}'),
//                                          ],
//                                        ),
//                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Mã công tác/ra ngoài',
                                              style: TextStyle(
                                                color: getColorFromHex(
                                                  "A1A1A1",
                                                ),
                                              ),
                                            ),
                                            Text('${widget.idBusinessTrip}'),
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
                                              'Địa điểm',
                                              style: TextStyle(
                                                color:
                                                    getColorFromHex("A1A1A1"),
                                              ),
                                            ),
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: SizedBox(
                                                width: 15,
                                              ),
                                            ),
                                            Container(
                                              // color: Colors.red,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  150,
                                              child: Text(
                                                snapshot.data[0]['Place']
                                                    .toString(),
                                                maxLines: 2,
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: true,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  // color: getColorFromHex("#A0A0A0"),
                                                ),
                                              ),
                                            ),
                                            // Text(
                                            //     '${snapshot.data[0]['Place']}'),
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
          bottomNavigationBar: Container(
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

                          _repository.r1700BusinessTripProvider
                              .p1700BusinessTrip(1703, {
                            "id": widget.idBusinessTrip,
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
          ),
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

    businessTripBloc.callWhat1709(
        {"IdEmployee": widget.employeeId, "id": widget.idBusinessTrip});
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
    businessTripBloc.dispose();
    super.dispose();
  }
}
