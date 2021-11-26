import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class PayrollTab extends StatefulWidget {
  @override
  _PayrollTabState createState() => _PayrollTabState();
}

class _PayrollTabState extends State<PayrollTab> {
  // Get list from future

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
  DateTime currentDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();

  String period = 'AM';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy hh:mm");

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Center(child: Text('Đang phát triển'))
        // Padding(
        //   padding: EdgeInsets.all(10.0),
        //   child: Column(
        //     children: <Widget>[
        //       Container(
        //         padding: EdgeInsets.all(10.0),
        //         width: MediaQuery.of(context).size.width,
        //         decoration: BoxDecoration(
        //           color: getColorFromHex("#FFFFFF"),
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(8.0),
        //           ),
        //         ),
        //         child: Column(
        //           children: [
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số công tháng ${currentDate.month}',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('2 công'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Giờ công thực tế',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('9.517'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số giờ làm dư giờ',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0 giờ 0 phút'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số giờ làm thêm',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0 giờ 0 phút'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Giờ công tiêu chuẩn',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('152 giờ'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Giờ công tăng ca',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0 giờ'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số ngày nghỉ tiêu chuẩn',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0 ngày'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số ngày nghỉ tiêu chuẩn (thử việc)',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0 ngày'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số ngày nghỉ không lương (chính thức)',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0 ngày'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Công chuẩn',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('15 ngày'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 20.0),
        //       Container(
        //         padding: EdgeInsets.all(10.0),
        //         width: MediaQuery.of(context).size.width,
        //         decoration: BoxDecoration(
        //           color: getColorFromHex("#FFFFFF"),
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(8.0),
        //           ),
        //         ),
        //         child: Column(
        //           children: [
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số giờ về sớm',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0 giờ 27 phút'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số giờ đi muộn',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('9 giờ 2 phút'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số giờ đi muộn, về sớm',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('9 giờ 29 phút'),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //       SizedBox(height: 20.0),
        //       Container(
        //         padding: EdgeInsets.all(10.0),
        //         width: MediaQuery.of(context).size.width,
        //         decoration: BoxDecoration(
        //           color: getColorFromHex("#FFFFFF"),
        //           borderRadius: BorderRadius.all(
        //             Radius.circular(8.0),
        //           ),
        //         ),
        //         child: Column(
        //           children: [
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số lần quên checkin',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số lần quên checkout',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('0'),
        //                           // Icon(Icons.arrow_forward_ios, size: 15,),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //             Divider(),
        //             Container(
        //               padding: EdgeInsets.all(5.0),
        //               child: Row(
        //                 children: <Widget>[
        //                   Expanded(
        //                     flex: 4,
        //                     child: Container(
        //                       child:Text(
        //                         'Số lần quên checkin/checkout',
        //                         style: TextStyle(
        //                           fontSize: itime_text_size_medium,
        //                         ),
        //                       ),
        //                     ),
        //                   ),
        //                   Expanded(
        //                     flex: 2,
        //                     child: Container(
        //                       child: Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: [
        //                           Text('14'),
        //                         ],
        //                       ),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
