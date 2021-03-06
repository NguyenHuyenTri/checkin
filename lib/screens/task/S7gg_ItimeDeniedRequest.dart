// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:future_progress_dialog/future_progress_dialog.dart';
// import 'package:intl/intl.dart';
// import 'package:month_picker_dialog/month_picker_dialog.dart';
// import 'package:vao_ra/blocs/blocs.dart';
// import 'package:vao_ra/helpers/converter.dart';
// import 'package:vao_ra/routes/router.dart';
// import 'package:vao_ra/shares/shares.dart';
// import 'package:nb_utils/nb_utils.dart';
//
// import '../screens.dart';
//
// class ItimeDeniedRequest extends StatefulWidget {
//   @override
//   _ItimeDeniedRequestState createState() => _ItimeDeniedRequestState();
// }
//
// class _ItimeDeniedRequestState extends State<ItimeDeniedRequest> {
//   // Get list from future
//   final advanceSalaryBloc = AdvanceSalaryBloc();
//
//   // Get list model
//
//   // Define base data type
//   String employeeId;
//   String employeeName;
//   String companyId;
//
//   // Define object from library
//   final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
//   SharedPreferences preferences;
//
//   // Define datetime
//   DateTime selectedDate = DateTime.now();
//   DateTime currentDate = DateTime.now();
//
//   TimeOfDay selectedTime = TimeOfDay.now();
//
//   String period = 'AM';
//   DateFormat dateFormat = DateFormat("dd-MM-yyyy");
//   DateFormat dateFormatSelectmonth = DateFormat("MM-yyyy");
//   DateFormat dateTimeFormat = DateFormat("dd-MM-yyyy hh:mm");
//
//   DateTime initialDate = new DateTime.now();
//
//   @override
//   void initState() {
//     super.initState();
//
//     _getData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // CARD ADVANCE SALARY REQUEST
//     Widget _advanceSalaryRequest(
//         {String createdAt,
//           String money,
//           String statusApprove}) {
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'T???m ???ng l????ng',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${moneyFormat(money.toString())} VN??',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: getColorFromHex("#A0A0A0"),
//                 ),
//               ),
//               statusApprove == 1.toString()
//                   ? Text(
//                 'Ch??? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#F9C130"),
//                 ),
//               )
//                   : statusApprove == 2.toString()
//                   ? Text(
//                 '???? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#38D46D"),
//                 ),
//               )
//                   : statusApprove == 3.toString()
//                   ? Text(
//                 'T??? ch???i',
//                 style: TextStyle(
//                   color: getColorFromHex("#D0011C"),
//                 ),
//               )
//                   : Text(''),
//             ],
//           ),
//           SizedBox(height: 5.0),
//         ],
//       );
//     }
//     // END CARD ADVANCE SALARY REQUEST
//
//     // CARD OVERTIME REQUEST
//     Widget _overtimeRequest(
//         {String createdAt,
//           String overtimeType,
//           String statusApprove}) {
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'L??m th??m gi???',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${overtimeType.toString()}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: getColorFromHex("#A0A0A0"),
//                 ),
//               ),
//               statusApprove == 1.toString()
//                   ? Text(
//                 'Ch??? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#F9C130"),
//                 ),
//               )
//                   : statusApprove == 2.toString()
//                   ? Text(
//                 '???? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#38D46D"),
//                 ),
//               )
//                   : statusApprove == 3.toString()
//                   ? Text(
//                 'T??? ch???i',
//                 style: TextStyle(
//                   color: getColorFromHex("#D0011C"),
//                 ),
//               )
//                   : Text(''),
//             ],
//           ),
//           SizedBox(height: 5.0),
//         ],
//       );
//     }
//     // END CARD OVERTIME REQUEST
//
//     // CARD ON LEAVE REQUEST
//     Widget _onLeaveRequest(
//         {String createdAt,
//           String statusApprove,
//           String shiftName}) {
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Ngh??? ph??p',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${shiftName.toString()}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: getColorFromHex("#A0A0A0"),
//                 ),
//               ),
//               statusApprove == 1.toString()
//                   ? Text(
//                 'Ch??? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#F9C130"),
//                 ),
//               )
//                   : statusApprove == 2.toString()
//                   ? Text(
//                 '???? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#38D46D"),
//                 ),
//               )
//                   : statusApprove == 3.toString()
//                   ? Text(
//                 'T??? ch???i',
//                 style: TextStyle(
//                   color: getColorFromHex("#D0011C"),
//                 ),
//               )
//                   : Text(''),
//             ],
//           ),
//           SizedBox(height: 5.0),
// //          Row(
// //            children: [
// //              Text(
// //                '${shiftName.toString()}',
// //                style: TextStyle(
// //                  fontSize: 14.0,
// //                  color: getColorFromHex("#A0A0A0"),
// //                ),
// //              ),
// //            ],
// //          ),
// //          SizedBox(height: 5.0),
//         ],
//       );
//     }
//     // END CARD ON LEAVE REQUEST
//
//     // CARD CHECKIN LATE REQUEST
//     Widget _checkinLateRequest(
//         {String createdAt,
//           String statusApprove,
//           String shiftName}) {
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Xin ??i tr???',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${shiftName.toString()}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: getColorFromHex("#A0A0A0"),
//                 ),
//               ),
//               statusApprove == 1.toString()
//                   ? Text(
//                 'Ch??? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#F9C130"),
//                 ),
//               )
//                   : statusApprove == 2.toString()
//                   ? Text(
//                 '???? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#38D46D"),
//                 ),
//               )
//                   : statusApprove == 3.toString()
//                   ? Text(
//                 'T??? ch???i',
//                 style: TextStyle(
//                   color: getColorFromHex("#D0011C"),
//                 ),
//               )
//                   : Text(''),
//             ],
//           ),
//           SizedBox(height: 5.0),
//         ],
//       );
//     }
//     // END CARD CHECKIN LATE REQUEST
//
//     // CARD CHECKOUT SOON REQUEST
//     Widget _checkoutSoonRequest(
//         {String createdAt,
//           String statusApprove,
//           String shiftName}) {
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Xin v??? s???m',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${shiftName.toString()}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: getColorFromHex("#A0A0A0"),
//                 ),
//               ),
//               statusApprove == 1.toString()
//                   ? Text(
//                 'Ch??? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#F9C130"),
//                 ),
//               )
//                   : statusApprove == 2.toString()
//                   ? Text(
//                 '???? duy???t',
//                 style: TextStyle(
//                   color: getColorFromHex("#38D46D"),
//                 ),
//               )
//                   : statusApprove == 3.toString()
//                   ? Text(
//                 'T??? ch???i',
//                 style: TextStyle(
//                   color: getColorFromHex("#D0011C"),
//                 ),
//               )
//                   : Text(''),
//             ],
//           ),
//           SizedBox(height: 5.0),
//         ],
//       );
//     }
//     // END CARD CHECKOUT SOON REQUEST
//
//     // CARD BUSINESS TRIP REQUEST
//     Widget _businessTripRequest(
//         {String createdAt,
//           String statusApprove,
//           String place}) {
//       return Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'C??ng t??c/Ra ngo??i',
//                 style: TextStyle(
//                   fontSize: 16.0,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(
//                 '${dateFormat.format(DateTime.parse(createdAt.toString()))}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 5.0),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 '${place.toString()}',
//                 style: TextStyle(
//                   fontSize: 14.0,
//                   color: getColorFromHex("#A0A0A0"),
//                 ),
//               ),
//               statusApprove == 1.toString()
//                   ? Container(
//                 decoration: BoxDecoration(
//                   color: getColorFromHex("#F9C130"),
//                 ),
//                 padding: const EdgeInsets.only(
//                     top: 5.0, bottom: 5.0, left: 45.0, right: 45.0),
//                 child: Text(
//                   'Ch??? duy???t',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//                   : statusApprove == 2.toString()
//                   ? Container(
//                 decoration: BoxDecoration(
//                   color: getColorFromHex("#38D46D"),
//                 ),
//                 padding: const EdgeInsets.only(
//                     top: 5.0, bottom: 5.0, left: 45.0, right: 45.0),
//                 child: Text(
//                   '???? duy???t',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//                   : statusApprove == 3.toString()
//                   ? Container(
//                 decoration: BoxDecoration(
//                   color: getColorFromHex("#D0011C"),
//                 ),
//                 padding: const EdgeInsets.only(
//                     top: 5.0,
//                     bottom: 5.0,
//                     left: 45.0,
//                     right: 45.0),
//                 child: Text(
//                   'T??? ch???i',
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//               )
//                   : Text(''),
//             ],
//           ),
//           SizedBox(height: 5.0),
//         ],
//       );
//     }
//     // END CARD BUSINESS TRIP REQUEST
//
//
//     // WIDGET GET LIST DATA DENIED
//     Widget _getListDataDenied() {
//       return StreamBuilder(
//           stream: advanceSalaryBloc.requestStream2311,
//           builder: (context, snapshot) {
//             switch (snapshot.connectionState) {
//               case ConnectionState.waiting:
//                 return Padding(
//                   padding: const EdgeInsets.only(top: 60.0),
//                   child: SpinKitRipple(size: 60,color: itime_main_color,),
//                 );
//                 break;
//               default:
//                 if (snapshot.hasError) {
//                   return Text('${snapshot.error}');
//                 } else {
//                   return Flexible(
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       itemCount: snapshot.data.length,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3.0, top: 5.0),
//                           child: GestureDetector(
//                             onTap: () {
//                               if(snapshot.data[index]['IsOnLeave'] == '1') {
//                                 launchScreen(context, Routes.itimeOnLeaveDetail, arguments: ItimeOnLeaveDetailArguments(
//                                   employeeId: employeeId,
//                                   idOnLeave: snapshot.data[index]['id'],
//                                   isOnLeave: snapshot.data[index]['IsOnLeave'],
//                                   statusName: snapshot.data[index]['IdStatusApprove'],
//                                 ));
//                               } else if(snapshot.data[index]['IsOvertime'] == '1') {
//                                 launchScreen(context, Routes.itimeOvertimeDetail, arguments: ItimeOvertimeDetailArguments(
//                                   employeeId: employeeId,
//                                   idOvertime: snapshot.data[index]['id'],
//                                   isOvertime: snapshot.data[index]['IsOvertime'],
//                                   statusName: snapshot.data[index]['IdStatusApprove'],
//                                 ));
//                               } else if(snapshot.data[index]['IsAdvanceSalary'] == '1') {
//                                 launchScreen(context, Routes.itimeAdvanceSalaryDetail, arguments: ItimeAdvanceSalaryDetailArguments(
//                                   employeeId: employeeId,
//                                   idAdvanceSalary: snapshot.data[index]['id'],
//                                   isAdvanceSalary: snapshot.data[index]['IsAdvanceSalary'],
//                                   statusName: snapshot.data[index]['IdStatusApprove'],
//                                 ));
//                               } else if(snapshot.data[index]['IsCheckinLate'] == '1') {
//                                 launchScreen(context, Routes.itimeCheckinLateDetail, arguments: ItimeCheckinLateDetailArguments(
//                                   employeeId: employeeId,
//                                   idCheckinLate: snapshot.data[index]['id'],
//                                   isCheckinLate: snapshot.data[index]['IsCheckinLate'],
//                                   statusName: snapshot.data[index]['IdStatusApprove'],
//                                 ));
//                               } else if(snapshot.data[index]['IsCheckoutSoon'] == '1') {
//                                 launchScreen(context, Routes.itimeCheckoutSoonDetail, arguments: ItimeCheckoutSoonDetailArguments(
//                                   employeeId: employeeId,
//                                   idCheckoutSoon: snapshot.data[index]['id'],
//                                   isCheckoutSoon: snapshot.data[index]['IsCheckoutSoon'],
//                                   statusName: snapshot.data[index]['IdStatusApprove'],
//                                 ));
//                               } else if(snapshot.data[index]['IsBusinessTrip'] == '1') {
//                                 launchScreen(context, Routes.itimeBusinessTripDetail, arguments: ItimeBusinessTripDetailArguments(
//                                   employeeId: employeeId,
//                                   idBusinessTrip: snapshot.data[index]['id'],
//                                   isBusinessTrip: snapshot.data[index]['IsBusinessTrip'],
//                                 ));
//                               }
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(5.0),
//                               ),
//                               padding: const EdgeInsets.all(10.0),
//                               width: MediaQuery.of(context).size.width,
//                               child: Column(
//                                 children: [
//                                   // if request is overtime
//                                   snapshot.data[index]['IsOvertime'] == '1'
//                                       ? _overtimeRequest(
//                                     overtimeType: snapshot.data[index]['OvertimeTypeName'],
//                                     statusApprove: snapshot.data[index]['IdStatusApprove'],
//                                     createdAt: snapshot.data[index]['CreatedAt'],
//                                   )
//                                   // if request is advance salary
//                                       : snapshot.data[index]['IsAdvanceSalary'] == '1'
//                                       ? _advanceSalaryRequest(
//                                       createdAt: snapshot.data[index]['CreatedAt'],
//                                       money: snapshot.data[index]['Money'],
//                                       statusApprove: snapshot.data[index]['IdStatusApprove'])
//                                   // if request is business trip
//                                       : snapshot.data[index]['IsBusinessTrip'] == '1'
//                                       ? _businessTripRequest(
//                                     statusApprove: snapshot.data[index]['IdStatusApprove'],
//                                     createdAt: snapshot.data[index]['CreatedAt'],
//                                     place: snapshot.data[index]['Place'],
//                                   )
//                                   // if request is on leave
//                                       : snapshot.data[index]['IsOnLeave'] == '1'
//                                       ? _onLeaveRequest(shiftName: snapshot.data[index]['ShiftName'],
//                                       createdAt: snapshot.data[index]['CreatedAt'],
//                                       statusApprove: snapshot.data[index]['IdStatusApprove'])
//                                   //if request is checkin late
//                                       : snapshot.data[index]['IsCheckinLate'] == '1'
//                                       ? _checkinLateRequest(
//                                       statusApprove: snapshot.data[index]['IdStatusApprove'],
//                                       createdAt: snapshot.data[index]['CreatedAt'],
//                                       shiftName: snapshot.data[index]['ShiftName']
//                                   )
//                                   // if request is checkout soon
//                                       : snapshot.data[index]['IsCheckoutSoon'] == '1'
//                                       ? _checkoutSoonRequest(
//                                       statusApprove: snapshot.data[index]['IdStatusApprove'],
//                                       createdAt: snapshot.data[index]['CreatedAt'],
//                                       shiftName: snapshot.data[index]['ShiftName']
//                                   )
//                                       : Visibility(visible: false, child: Text('')),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//             }
//           });
//     }
//     // END WIDGET GET LIST DATA DENIED
//
//     return Column(
//       children: <Widget>[
//         Container(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 5.0, right: 5.0),
//             child: Card(
//                 elevation: 0.0,
//                 child: ListTile(
//                   onTap: () {
//                     _selectDate(context).whenComplete(() {
//                       print("${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
//                       // _showProgress(context, 2);
//                       // setState(() {
//                       //   _loadList();
//                       // });
//                     });
//                   },
//                   title: Text(
//                     'Ch???n th??ng b??o c??o',
//                     style: primaryTextStyle(),
//                   ),
//                   subtitle: Text(
//                     "${dateFormatSelectmonth.format(selectedDate)}",
//                     style: secondaryTextStyle(),
//                   ),
//                 )),
//           ),
//         ),
//         _getListDataDenied(),
//       ],
//     );
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     showMonthPicker(
//       context: context,
//       firstDate: DateTime(DateTime.now().year - 1, 5),
//       lastDate: DateTime(DateTime.now().year + 1, 9),
//       initialDate: selectedDate ?? this.initialDate,
//       locale: Locale("vi"),
//     ).then((date) {
//       if (date != null) {
//         setState(() {
//           selectedDate = date;
//           print('selectedDate month ${selectedDate}');
//           _loadList();
//         });
//       }
//     });
//     // final DateTime picked = await showDatePicker(
//     //     helpText: 'Ch???n ng??y b??o c??o',
//     //     cancelText: 'H???y',
//     //     confirmText: "Ch???n",
//     //     fieldLabelText: 'Ch???n ng??y',
//     //     fieldHintText: 'Month/Date/Year',
//     //     errorFormatText: 'Vui l??ng ch???n ng??y ????ng.',
//     //     errorInvalidText: 'Vui l??ng ch???n ng??y ????ng.',
//     //     context: context,
//     //     builder: (BuildContext context, Widget child) {
//     //       return Theme(
//     //         data: ThemeData.light().copyWith(
//     //           primaryColor: itime_main_color,
//     //           accentColor: itime_main_color,
//     //           highlightColor: itime_main_color,
//     //           colorScheme: ColorScheme.light(primary: itime_main_color),
//     //           buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
//     //         ),
//     //         child: child,
//     //       );
//     //     },
//     //     initialDate: selectedDate,
//     //     firstDate: DateTime(2015, 8),
//     //     lastDate: DateTime(2101));
//     // if (picked != null && picked != selectedDate)
//     //   setState(() {
//     //     print(picked);
//     //     selectedDate = picked;
//     //   });
//   }
//
//   // get data employeeId, companyId
//   _getData() async {
//     preferences = await SharedPreferences.getInstance();
//     Map<String, dynamic> mapEmployee =
//     jsonDecode(preferences.getString("user"));
//     Map<String, dynamic> mapCompany =
//     jsonDecode(preferences.getString("company"));
//
//     employeeId = mapEmployee['id'];
//     companyId = mapCompany['id'];
//     employeeName = mapEmployee['Fullname'];
// //
// //    advanceSalaryBloc.callWhat2309({
// //      "IdEmployee": employeeId.toString(),
// //      "IdCompany": companyId.toString(),
// //      "CreatedAt":
// //      "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
// //    });
//
//     _loadList();
//   }
//
//   _loadList() {
//     advanceSalaryBloc.callWhat2311({
//       "IdEmployee": employeeId.toString(),
//       "IdCompany": companyId.toString(),
//       "CreatedAt":
//       "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}",
//     });
//   }
//
//   // alert and move screen
//   Future _getFuture(int time) {
//     return Future(() async {
//       await Future.delayed(Duration(seconds: time));
//       return 'Hello, Future Progress Dialog!';
//     });
//   }
//
//   Future<void> _showProgress(BuildContext context, int time) async {
//     await showDialog(
//         context: context,
//         builder: (context) => FutureProgressDialog(_getFuture(time)));
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//
//     advanceSalaryBloc.dispose();
//   }
// }
