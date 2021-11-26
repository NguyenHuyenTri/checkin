import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/GeneralColors.dart';
import 'package:vao_ra/shares/GeneralSizes.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:vao_ra/blocs/b5500_employee_bloc.dart';
import 'dart:convert';

import 'S9c_ItimePersonalInformation.dart';

class ItimeProfileMain extends StatefulWidget {
  @override
  _ItimeProfileMainState createState() => _ItimeProfileMainState();
}

class _ItimeProfileMainState extends State<ItimeProfileMain> {
  final employeeBloc = EmployeeBloc();
  dynamic profilesEmployee;

  SharedPreferences preferences;
  String employeeId;
  String companyName;

  @override
  void initState() {
    super.initState();
    getDataEmployee();
  }

  // LOAD DATA PROFILES
  getDataEmployee() async {
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> mapEmployee =
        jsonDecode(preferences.getString("user"));
    Map<String, dynamic> mapCompany =
        jsonDecode(preferences.getString("company"));
    employeeId = mapEmployee['id'];
    companyName = mapCompany['CompanyName'];

    if (employeeId != null)
      employeeBloc.callWhat5510({
        "IdEmployee": employeeId,
      });
  }

  // WIDGET ACCOUNT INFORMATION SECTION
  Widget _accountInformationSection() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: getColorFromHex("#FFFFFF"),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Nguyễn Huyền Trí',
                      style: TextStyle(
                        fontSize: itime_text_size_medium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Container(
                      width: MediaQuery.of(context).size.width - 150,
                      child: Text(
                        companyName,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Text(
                      '0358720099',
                    ),
                    SizedBox(height: 3.0),
                  ],
                ),
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: itime_main_color,
                    image: DecorationImage(
                        image: NetworkImage(
                            'https://scontent.fdad4-1.fna.fbcdn.net/v/t1.6435-9/131099524_3479755855581840_3704586785001698229_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=Iwnfngk0B00AX9QCYOK&_nc_ht=scontent.fdad4-1.fna&oh=c38fa2a0bae92a409bc375190fca976b&oe=60D3DC66'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ],
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () async {
                print('get over here');
                final result = await Navigator.pushNamed(
                    context, Routes.itimePersonalInformation);
                if (result) {
                  print('call');
                  employeeBloc.callWhat5510({
                    "IdEmployee": employeeId,
                  });
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 0.0),
                  decoration: BoxDecoration(
                    color: getColorFromHex("#FFFFFF"),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, size: 20),
                      Text(
                        'Chỉnh sửa',
                        style: TextStyle(
                          fontSize: itime_text_size_medium,
                          // color: itime_main_color,
                          // fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // END WIDGET ACCOUNT INFORMATION SECTION

  // WIDGET MANAGER AND REPORT SECTION
  Widget _managerAndReportSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: getColorFromHex("#FFFFFF"),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            InkWell(
              onTap: () {
                launchScreen(context, Routes.itimeTimeKeeperReport);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.assessment, color: Colors.pink),
                        SizedBox(width: 5.0),
                        Text('Báo cáo'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                launchScreen(context, Routes.itimeTakeLeaveList);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.compare_arrows, color: Colors.green),
                        SizedBox(width: 5.0),
                        Text('Quản lý phép'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                launchScreen(context, Routes.itimeSalaryCoupon);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.monetization_on, color: Colors.purple),
                        SizedBox(width: 5.0),
                        Text('Phiếu lương'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
//            Divider(),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Container(
//                  padding: EdgeInsets.all(5.0),
//                  child: Row(
//                    children: <Widget>[
//                      Icon(Icons.work, color: Colors.orange),
//                      SizedBox(width: 5.0),
//                      Text('Quản lý KPI'),
//                    ],
//                  ),
//                ),
//              ],
//            ),
          ],
        ),
      ),
    );
  }

  // END WIDGET MANAGER AND REPORT SECTION

  // WIDGET OTHER SECTION
  Widget _otherSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: getColorFromHex("#FFFFFF"),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                ExtendedNavigator.of(context, rootRouter: true)
                    .push(Routes.itimeCameraTrain);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.face_outlined, color: Colors.redAccent),
                        SizedBox(width: 5.0),
                        Text('Quản lý dữ liệu khuôn mặt'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            InkWell(
              onTap: () {
                launchScreen(context, Routes.itimeSendError);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.warning, color: Colors.green),
                        SizedBox(width: 5.0),
                        Text('Báo lỗi'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.refresh, color: Colors.lightBlue),
                      SizedBox(width: 5.0),
                      Text('Làm mới ứng dụng'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // END WIDGET OTHER SECTION

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _accountInformationSection(),
        SizedBox(height: 10.0),
        _managerAndReportSection(),
        SizedBox(height: 20.0),
        _otherSection(),
        SizedBox(height: 10.0),
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    employeeBloc.dispose();
    super.dispose();
  }
}
