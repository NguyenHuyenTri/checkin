import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeAlertSetting extends StatefulWidget {
  @override
  _ItimeAlertSettingState createState() => _ItimeAlertSettingState();
}

class _ItimeAlertSettingState extends State<ItimeAlertSetting> {
  // Get list from future

  // Get list model

  // Define base data type
  bool isWarningOnShift = false;
  bool isWarningOutShift = true;
  bool isWarningOnLate = false;
  bool isWarningOutLate = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime

  // sub function

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
                'Cài đặt cảnh báo',
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
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: getColorFromHex("#FFFFFF"),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Cảnh báo vào ca',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                              Text(
                                'Cảnh báo khi đến giờ vào ca',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium - 2,
                                  color: getColorFromHex("#A1A1A1"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Switch(
                                  value: isWarningOnShift,
                                  onChanged: (value) {
                                    setState(() {
                                      isWarningOnShift = value;
                                      print(isWarningOnShift);
                                    });
                                  },
                                  activeTrackColor: itime_light_red,
                                  activeColor: itime_main_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Cảnh báo ra ca',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                              Text(
                                'Cảnh báo khi đến giờ ra ca',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium - 2,
                                  color: getColorFromHex("#A1A1A1"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Switch(
                                  value: isWarningOutShift,
                                  onChanged: (value) {
                                    setState(() {
                                      isWarningOutShift = value;
                                      print(isWarningOutShift);
                                    });
                                  },
                                  activeTrackColor: itime_light_red,
                                  activeColor: itime_main_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Cảnh báo vào ca trễ',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                              Text(
                                'Cảnh báo 10 phút trước giờ vào ca',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium - 2,
                                  color: getColorFromHex("#A1A1A1"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.2,
                                child: Switch(
                                  value: isWarningOnLate,
                                  onChanged: (value) {
                                    setState(() {
                                      isWarningOnLate = value;
                                      print(isWarningOnLate);
                                    });
                                  },
                                  activeTrackColor: itime_light_red,
                                  activeColor: itime_main_color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Cảnh báo ra ca trễ',
                                  style: TextStyle(
                                    fontSize: itime_text_size_medium,
                                  ),
                                ),
                                Text(
                                  'Cảnh báo sau 10 phút nếu bạn quên ra ca',
                                  style: TextStyle(
                                    fontSize: itime_text_size_medium - 2,
                                    color: getColorFromHex("#A1A1A1"),
                                  ),
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
                                Transform.scale(
                                  scale: 1.2,
                                  child: Switch(
                                    value: isWarningOutLate,
                                    onChanged: (value) {
                                      setState(() {
                                        isWarningOutLate = value;
                                        print(isWarningOutLate);
                                      });
                                    },
                                    activeTrackColor: itime_light_red,
                                    activeColor: itime_main_color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
