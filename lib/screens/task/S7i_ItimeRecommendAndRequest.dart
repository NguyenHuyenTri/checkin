import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

class ItimeRecommendAndRequest extends StatefulWidget {
  @override
  _ItimeRecommendAndRequestState createState() =>
      _ItimeRecommendAndRequestState();
}

class _ItimeRecommendAndRequestState extends State<ItimeRecommendAndRequest> {
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
            Icons.clear,
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
                'Đề nghị/Yêu cầu',
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
            Card(
              color: appStore.appBarColor,
              margin: EdgeInsets.all(8),
              elevation: 0.0,
              child: ListTile(
                onTap: () {
                  ExtendedNavigator.of(
                    context,
                    // rootRouter: true,
                  ).push(Routes.itimeAdvanceSalary).then((val) {
                    if (val != null && val) {
                      ExtendedNavigator.of(context).pop(true);
                    }
                  });
                  // launchScreen(context, Routes.itimeAdvanceSalary);
                },
                leading: Icon(Icons.monetization_on, size: 30),
                title: Text(
                  'Tạm ứng lương',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.chevron_right, color: appStore.iconColor),
                ),
              ),
            ),
            Card(
              color: appStore.appBarColor,
              margin: EdgeInsets.all(8),
              elevation: 0.0,
              child: ListTile(
                onTap: () {
                  ExtendedNavigator.of(
                    context,
                    // rootRouter: true,
                  ).push(Routes.itimeOvertimeRequest).then((val) {
                    if (val != null && val) {
                      ExtendedNavigator.of(context).pop(true);
                    }
                  });
                  // launchScreen(context, Routes.itimeOvertimeRequest);
                },
                leading: Icon(Icons.timelapse, size: 30),
                title: Text(
                  'Làm thêm giờ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.chevron_right, color: appStore.iconColor),
                ),
              ),
            ),
            Card(
              color: appStore.appBarColor,
              margin: EdgeInsets.all(8),
              elevation: 0.0,
              child: ListTile(
                onTap: () {
                  ExtendedNavigator.of(
                    context,
                    // rootRouter: true,
                  ).push(Routes.itimeBusinessTrip).then((val) {
                    if (val != null && val) {
                      ExtendedNavigator.of(context).pop(true);
                    }
                  });
                  // launchScreen(context, Routes.itimeBusinessTrip);
                },
                leading: Icon(Icons.work, size: 30),
                title: Text(
                  'Công tác/Ra ngoài',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.chevron_right, color: appStore.iconColor),
                ),
              ),
            ),
            Card(
              color: appStore.appBarColor,
              margin: EdgeInsets.all(8),
              elevation: 0.0,
              child: ListTile(
                onTap: () {
                  ExtendedNavigator.of(
                    context,
                    // rootRouter: true,
                  ).push(Routes.itimeTakeLeave).then((val) {
                    if (val != null && val) {
                      ExtendedNavigator.of(context).pop(true);
                    }
                  });
                  // launchScreen(context, Routes.itimeTakeLeave);
                },
                leading: Icon(Icons.airplanemode_active, size: 30),
                title: Text(
                  'Nghỉ phép',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.chevron_right, color: appStore.iconColor),
                ),
              ),
            ),
            Card(
              color: appStore.appBarColor,
              margin: EdgeInsets.all(8),
              elevation: 0.0,
              child: ListTile(
                onTap: () {
                  ExtendedNavigator.of(
                    context,
                    // rootRouter: true,
                  ).push(Routes.itimeCheckinLate).then((val) {
                    if (val != null && val) {
                      ExtendedNavigator.of(context).pop(true);
                    }
                  });
                  // launchScreen(context, Routes.itimeCheckinLate);
                },
                leading: Icon(Icons.assignment_late, size: 30),
                title: Text(
                  'Đi trễ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.chevron_right, color: appStore.iconColor),
                ),
              ),
            ),
            Card(
              color: appStore.appBarColor,
              margin: EdgeInsets.all(8),
              elevation: 0.0,
              child: ListTile(
                onTap: () {
                  ExtendedNavigator.of(
                    context,
                    // rootRouter: true,
                  ).push(Routes.itimeCheckoutSoon).then((val) {
                    if (val != null && val) {
                      ExtendedNavigator.of(context).pop(true);
                    }
                  });
                  // launchScreen(context, Routes.itimeCheckoutSoon);
                },
                leading: Icon(Icons.soap_outlined, size: 30),
                title: Text(
                  'Về sớm',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(Icons.chevron_right, color: appStore.iconColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
