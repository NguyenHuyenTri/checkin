import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeTakeLeaveInformation extends StatefulWidget {
  @override
  _ItimeTakeLeaveInformationState createState() =>
      _ItimeTakeLeaveInformationState();
}

class _ItimeTakeLeaveInformationState extends State<ItimeTakeLeaveInformation> {
  // Get list from future
  final onLeaveBloc = new OnLeaveBloc();

  // Get list model

  // Define base data type
  String employeeId;
  String companyId;

  int notHaveOnLeave = 30;
  int standardOnLeave = 12;

  var countNotHaveOnLeave;
  var countStandardOnLeave;

  var totalNotHaveOnLeave;
  var totalStandardOnLeave;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  // Define datetime

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
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: iconColorPrimary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: itime_black,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Nghỉ phép',
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        appBar: _appbarSection(),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: StreamBuilder(
                stream: onLeaveBloc.onLeaveStream1108,
                builder: (context, snapshot) {
                  switch(snapshot.connectionState) {
                    case ConnectionState.waiting :
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: SpinKitRipple(
                          size: 60,
                          color: itime_main_color,
                        ),
                      );
                      break;
                    default:
                      if(snapshot.hasError) {
                        return Text('${snapshot.hasError}');
                      } else {
                        return Table(
                            border: TableBorder.all(
                              color: getColorFromHex("#C1C1C1"),
                            ),
                            children: [
                              TableRow(children: [
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Loại nghỉ phép'),
                                  decoration: BoxDecoration(
                                    color: getColorFromHex("#D4D4D4"),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(child: Text('Tổng cộng')),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(child: Text('Đã nghỉ')),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Center(child: Text('Còn lại')),
                                ),
                              ]),
                              TableRow(children: [
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Nghỉ không phép'),
                                  decoration: BoxDecoration(
                                    color: getColorFromHex("#D4D4D4"),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: Text('${notHaveOnLeave.toString()}'),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: Text('${onLeaveBloc.countNotHaveOnLeave1108.toString()}'),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: Text('${notHaveOnLeave - int.parse(onLeaveBloc.countNotHaveOnLeave1108)}'),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                Container(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text('Nghỉ phép tiêu chuẩn'),
                                  decoration: BoxDecoration(
                                    color: getColorFromHex("#D4D4D4"),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: Text('${standardOnLeave.toString()}'),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: Text('${onLeaveBloc.countStandardOLeave1108.toString()}'),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Center(
                                    child: Text('${standardOnLeave - int.parse(onLeaveBloc.countStandardOLeave1108)}'),
                                  ),
                                ),
                              ]),
                            ]);
                      }
                  }
                }
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  '(Để tạo đơn nghỉ phép bạn vào: Quản lý yêu cầu | Chọn + | Nghỉ phép)',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: getColorFromHex("#A1A1A1")),
                ),
              ),
            ),
          ],
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


    onLeaveBloc.callWhat1108({
      "IdEmployee": employeeId.toString(),
      "IdCompany": companyId.toString(),
    });
  }

  // listen stream
//  _listenStream() {
//    onLeaveBloc.onLeaveStream1108.listen((event) {
//      countNotHaveOnLeave = onLeaveBloc.countNotHaveOnLeave1108;
//      countStandardOnLeave = onLeaveBloc.countStandardOLeave1108;
//      totalNotHaveOnLeave = notHaveOnLeave - countNotHaveOnLeave;
//      totalStandardOnLeave = standardOnLeave - countStandardOnLeave;
//    });
//    _getData();
//  }

  @override
  void dispose() {
    onLeaveBloc.dispose();
    super.dispose();
  }
}
