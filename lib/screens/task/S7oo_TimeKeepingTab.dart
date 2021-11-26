import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class TimeKeepingTab extends StatefulWidget {
  @override
  _TimeKeepingTabState createState() => _TimeKeepingTabState();
}

class _TimeKeepingTabState extends State<TimeKeepingTab> {
  // Get list from future
  final timeKeepingBloc = new TimekeepingBloc();

  // Get list model

  // Define base data type
  String employeeId;
  String employeeName;
  String companyId;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;

  // Define datetime
  DateTime selectedDate = DateTime.now();
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {

    // WIDGET LIST TIMEKEEPING
    Widget _timekeepingListSection() {
      return StreamBuilder(
          stream: timeKeepingBloc.timeKeepingStream2510,
          builder: (context, snapshot) {
            switch(snapshot.connectionState) {
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
                if(snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10.0,top: 5.0),
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
                                      '${snapshot.data[index]['DayOfWeek']}, ${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
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
                                                      '${snapshot.data[index]['Fullname']}',
                                                      style: TextStyle(
                                                        fontSize: itime_text_size_medium,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Vào ca - ${snapshot.data[index]['ShiftName']}',
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
                                                Text('${snapshot.data[index]['CheckinTime']}'),
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
                                                      '${snapshot.data[index]['Fullname']}',
                                                      style: TextStyle(
                                                        fontSize: itime_text_size_medium,
                                                      ),
                                                    ),
                                                    Text(
                                                      'Ra ca - ${snapshot.data[index]['ShiftName']}',
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
                                                Text('${snapshot.data[index]['CheckoutTime']}'),
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
                      },
                    ),
                  );
                }
            }
          }
      );
    }
    // END WIDGET LIST TIMEKEEPING

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      _selectFromDate(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Từ ngày',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 16.0,
                                )
                            ),
                            Text(
                              "${dateFormat.format(selectedFromDate)}",
                              style: secondaryTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      var getHourFromDate = new DateTime.utc(selectedFromDate.year, selectedFromDate.month, selectedFromDate.day);
                      var getHourToDate = new DateTime.utc(selectedToDate.year, selectedToDate.month, selectedToDate.day);
                      _selectToDate(context).whenComplete(() {
                        if(getHourFromDate.compareTo(getHourToDate) > 0) {
                          print('bat dau loc');
                        } else {
                          print('Ngày kết thúc không được nhỏ hơn ngày ban đầu!');
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Đến ngày',
                                style: TextStyle(
                                  fontFamily: 'OpenSans',
                                  fontSize: 16.0,
                                )
                            ),
                            Text(
                              "${dateFormat.format(selectedToDate)}",
                              style: secondaryTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        _timekeepingListSection(),
      ],
    );
  }

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        helpText: 'Chọn ngày báo cáo',
        cancelText: 'Hủy',
        confirmText: "Chọn",
        fieldLabelText: 'Chọn ngày',
        fieldHintText: 'Month/Date/Year',
        errorFormatText: 'Vui lòng chọn ngày đúng.',
        errorInvalidText: 'Vui lòng chọn ngày đúng.',
        context: context,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: itime_main_color,
              accentColor:itime_main_color,
              highlightColor: itime_main_color,
              colorScheme: ColorScheme.light(primary: itime_main_color),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child,
          );
        },
        initialDate: selectedFromDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedFromDate)
      setState(() {
        print(picked);
        selectedFromDate = picked;
      });
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        helpText: 'Chọn ngày báo cáo',
        cancelText: 'Hủy',
        confirmText: "Chọn",
        fieldLabelText: 'Chọn ngày',
        fieldHintText: 'Month/Date/Year',
        errorFormatText: 'Vui lòng chọn ngày đúng.',
        errorInvalidText: 'Vui lòng chọn ngày đúng.',
        context: context,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: itime_main_color,
              accentColor:itime_main_color,
              highlightColor: itime_main_color,
              colorScheme: ColorScheme.light(primary: itime_main_color),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child,
          );
        },
        initialDate: selectedToDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedToDate)
      setState(() {
        print(picked);
        selectedToDate = picked;
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
    employeeName = mapEmployee['Fullname'];

    _loadList();
  }

  _loadList() {
    timeKeepingBloc.callWhat2510({
      "IdEmployee": employeeId.toString(),
      "IdCompany": companyId.toString(),
      "CreatedAt":
      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
    });
  }

  // show snackbar
  Future<void> _showSnackbar(String title) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('${title.toString()}',
          style: primaryTextStyle(color: Colors.white, fontFamily: fontAndika)),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
          label: 'Ẩn',
          onPressed: () {
            scaffoldKey.currentState.hideCurrentSnackBar();
          }),
    ));
  }

  @override
  void dispose() {

    timeKeepingBloc.dispose();
    super.dispose();
  }
}
