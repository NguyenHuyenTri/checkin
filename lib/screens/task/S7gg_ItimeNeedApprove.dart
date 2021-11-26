import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/screens/screens.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/themes.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

class ItimeNeedApprove extends StatefulWidget {
  @override
  _ItimeNeedApproveState createState() => _ItimeNeedApproveState();
}

class _ItimeNeedApproveState extends State<ItimeNeedApprove> {
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
              accentColor: itime_main_color,
              highlightColor: itime_main_color,
              colorScheme: ColorScheme.light(primary: itime_main_color),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
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
  ScrollController _controller = new ScrollController();

  // Define datetime
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String period = 'AM';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  // sub function

  @override
  Widget build(BuildContext context) {
    // WIDGET BOX NEED APPROVE TAKE LEAVE SECTION
    Widget _needApproveTakeLeaveSection() {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: getColorFromHex("#FFFFFF"),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    color: getColorFromHex("#F9C02F"),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Icon(
                    Icons.check,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('công tác/ra ngoài'),
                        Text('thứ tư'),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Lê tấn tài'),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text('Nghỉ phép tiêu chuẩn'),
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text('03/02/2021 17:15'),
                      ),
                      Icon(Icons.arrow_forward),
                      Container(
                        padding: EdgeInsets.only(left: 5.0),
                        child: Text('03/02/2021 17:15'),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 100,
//                          height: 50,
                      decoration: BoxDecoration(
                        color: getColorFromHex("#F9C02F"),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(2.0),
                        child: Center(
                          child: Text('Chờ duyệt', style: TextStyle(
                              color: Colors.white
                          ),),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }


    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
              elevation: 4,
              child: ListTile(
                onTap: () {
                  _selectDate(context);
                },
                title: Text(
                  'Chọn ngày báo cáo',
                  style: primaryTextStyle(),
                ),
                subtitle: Text(
                  "${dateFormat.format(selectedDate)}",
                  style: secondaryTextStyle(),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: appStore.iconColor,
                  ),
                  onPressed: () {
//                    launchScreen(context, Routes.itimeFilterRequest);
                    Navigator.push(context, MaterialPageRoute(builder: ((context)=>ItimeFilterRequest())));
                  },
                ),
              )),
          SizedBox(height: 10.0),
          ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              _needApproveTakeLeaveSection(),
              SizedBox(height: 10.0),
              _needApproveTakeLeaveSection(),
            ],
          ),
        ],
      ),
    );
  }
}
