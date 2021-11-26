import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/custom.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

class GeneralTaskReport extends StatefulWidget {
  @override
  _GeneralTaskReportState createState() => _GeneralTaskReportState();
}

class _GeneralTaskReportState extends State<GeneralTaskReport> {
  // Get list from future
  Future<void> _selectDate(BuildContext context) async {
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
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        print(picked);
        selectedDate = picked;
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay Picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
        builder: (BuildContext context, Widget child) {
          return CustomTheme(
            child: MediaQuery(
              data:
              MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
              child: child,
            ),
          );
        });

    if (Picked != null)
      setState(() {
        selectedTime = Picked;
      });
  }

  // Get list model

  // Define base data type

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String period = 'AM';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  // sub function

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: itime_main_background,
      body: ListView(
        children: <Widget>[
          Card(
              elevation: 4,
              child: ListTile(
                onTap: () {
                  _selectDate(context);
                },
                title: Text(
                  'Chọn ngày báo cáo',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 16.0,
                    )
                ),
                subtitle: Text(
                  "${dateFormat.format(selectedDate)}",
                  style: secondaryTextStyle(),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.date_range,
                    color: appStore.iconColor,
                  ),
                  onPressed: () {
                    print(dateFormat.format(selectedDate));
                  },
                ),
              )),
        ],
      ),
    );
  }
}
