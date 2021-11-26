import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:smart_select/smart_select.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/routes/router.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/custom.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeOvertimeRequest extends StatefulWidget {
  @override
  _ItimeOvertimeRequestState createState() => _ItimeOvertimeRequestState();
}

class _ItimeOvertimeRequestState extends State<ItimeOvertimeRequest> {
  // Get list from future
  final overtimeTypeBloc = new OvertimeTypeBloc();

  // final branchBloc = new BranchBloc();
  final _repository = new Repository();

  // Get list model
  List<M2100OvertimeTypeModel> overtimeTypeList = [];
  List<M6300BranchModel> branchList = [];

  // Define base data type
  String employeeId;
  String companyId;

  M2100OvertimeTypeModel overtimeType;

  String overtimeTypeId;
  List<S2Choice<String>> optionsOvertimeType = [];

  String overtimeTypeName;

  String branch;
  String branchId;
  String branchName;

  String rate;

  bool isLoading = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;
  TextEditingController _amountOfHourController = new TextEditingController();
  TextEditingController _reasonController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  // Define datetime
  DateTime selectedStartDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();

  DateTime selectedEndDate = DateTime.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  DateTime selectedDate = DateTime.now();

  String period = 'AM';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  @override
  void initState() {
    super.initState();

    _listenStream();
  }

  @override
  Widget build(BuildContext context) {
    Widget _customDropDownExample(BuildContext context,
        M2100OvertimeTypeModel item, String itemDesignation) {
      return Container(
        child: (item?.Name == null)
            ? ListTile(
                contentPadding: EdgeInsets.all(0),
                // leading: CircleAvatar(),
                title: Text(
                  "Hãy chọn loại làm thêm giờ",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            : ListTile(
                contentPadding: EdgeInsets.all(0),
                // leading: CircleAvatar(
                //   backgroundImage: NetworkImage(item.Name),
                // ),
                title: Text(item.Name),
                // subtitle: Text(
                //   item.Name.toString(),
                // ),
              ),
      );
    }

    Widget _customPopupItemBuilderExample(
        BuildContext context, M2100OvertimeTypeModel item, bool isSelected) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
        child: ListTile(
          selected: isSelected,
          title: Text(item.Name),
          // subtitle: Text(item.Name.toString()),
          // leading: CircleAvatar(
          //   backgroundImage: NetworkImage(item.Name),
          // ),
        ),
      );
    }

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
                'Làm thêm giờ',
                style: TextStyle(
                  color: appTextColorPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: itime_text_size_normal + 2,
                ),
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (!isLoading) {
                FocusScope.of(context).requestFocus(FocusNode());

                // selectedStartDate
                // selectedStartTime

                // selectedEndDate
                // selectedEndTime

                DateTime datetimeStart = new DateTime(
                    selectedStartDate.year,
                    selectedStartDate.month,
                    selectedStartDate.day,
                    selectedStartTime.hour,
                    selectedStartDate.minute);
                DateTime datetimeEnd = new DateTime(
                    selectedEndDate.year,
                    selectedEndDate.month,
                    selectedEndDate.day,
                    selectedEndTime.hour,
                    selectedEndTime.minute);
                Duration difference = datetimeEnd.difference(datetimeStart);
                //
                double totalHours = difference.inMinutes / 60;

                print('diff ${difference.inMinutes / 60}');

                print(
                    '_reasonController.text ${_reasonController.text} overtimeTypeId.text ${overtimeTypeId}');
                if (totalHours <= 0) {
                  _showSnackbar("Tổng số giờ làm thêm không hợp lệ");
                } else if (_reasonController.text == null ||
                        _reasonController.text == '' ||
                        overtimeTypeId == null ||
                        overtimeTypeId == 0.toString()
                    // branchId == 0.toString()
                    ) {
                  _showProgress(context, 1).whenComplete(() {
                    _showSnackbar("Vui lòng nhập đầy đủ thông tin!");
                  });
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  FocusScope.of(context).requestFocus(FocusNode());
                  _showProgress(context, 3);
                  _repository.r1800OvertimeProvider.p1800Overtime(1801, {
                    "IdCompany": companyId.toString(),
                    "IdEmployee": employeeId.toString(),
                    "IdOvertimeType": overtimeTypeId.toString(),
                    "FromTime":
                        "${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day} ${selectedStartTime.hour}:${selectedStartTime.minute}",
                    "EndTime":
                        "${selectedEndDate.year}-${selectedEndDate.month}-${selectedEndDate.day} ${selectedEndTime.hour}:${selectedEndTime.minute}",
                    "IdStatusApprove": "1",
                    "Reason": _reasonController.text,
                    "Content": _contentController.text,
                    "OvertimeHour":
                        double.parse((totalHours).toStringAsFixed(1)),
                    "OvertimeBranch": branchName,
                    "CreatedAt":
                        '${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}',
                  }).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    if (value == true) {
                      _contentController.clear();
                      _amountOfHourController.clear();
                      _reasonController.clear();

                      // Navigator.pop(context);
                      // Navigator.pop(context);
                      // Navigator.pop(context, true);
                      ExtendedNavigator.of(context).pop(true);
                    } else {
                      _showSnackbar("Gửi yêu cầu thất bại!");
                    }
                  });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25),
              child: Center(
                child: Text(
                  isLoading ? 'Gửi' : 'Gửi'.toUpperCase(),
                  style: TextStyle(
                      fontSize: itime_text_size_medium,
                      color: isLoading ? Colors.grey : itime_main_color,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      );
    }
    // END WIDGET APPBAR SECTION

    // WIDGET OVERTIME TYPE SECTION
    Widget _overtimeTypeSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Loại làm thêm giờ',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                    color: itime_main_color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: overtimeTypeList.length == 0
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Center(
                        child: Text(
                          "Đang tải ...",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : DropdownSearch<M2100OvertimeTypeModel>(
                      mode: Mode.BOTTOM_SHEET,
                      maxHeight: 300,
                      items:
                          overtimeTypeList.map((M2100OvertimeTypeModel model) {
                        return model;
                      }).toList(),
                      dropdownSearchDecoration: InputDecoration(
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 1.0),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: itime_main_color, width: 1.0),
                        ),
                      ),
                      dropdownBuilder: _customDropDownExample,
                      popupItemBuilder: _customPopupItemBuilderExample,
                      onChanged: (data) {
                        setState(() {
                          overtimeTypeId = data.id;
                        });
                        overtimeType = data;
                        print(
                            'ON overtimeTypeId ${overtimeTypeId} overtimeType ${overtimeType}');
                      },
                      selectedItem: overtimeType,
                      showSearchBox: true,
                      searchBoxDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        labelText: "Tìm kiếm loại làm thêm giờ",
                      ),
                      popupTitle: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: itime_main_color,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Loại làm thêm giờ',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      popupShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                    ),
            )
          ],
        ),
      );
    }
    // END OVERTIME TYPE SECTION

    // WIDGET SELECT START DATE SECTION
    Widget _selectStartDateSection() {
      return GestureDetector(
        onTap: () {
          _selectStartDate(context)
              .whenComplete(() => _selectStartTime(context));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Bắt đầu lúc',
                    style: TextStyle(
                      fontSize: itime_text_size_medium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: itime_text_size_medium,
                      fontWeight: FontWeight.bold,
                      color: itime_main_color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                  child: Row(
                    children: [
                      Text(
                        '${dateFormat.format(selectedStartDate)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${selectedStartTime.hour}" +
                            ":" +
                            "${selectedStartTime.minute}",
                        style: secondaryTextStyle(),
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
    // END WIDGET SELECT START DATE SECTION

    // WIDGET SELECT END DATE SECTION
    Widget _selectEndDateSection() {
      return GestureDetector(
        onTap: () {
          _selectEndDate(context).whenComplete(() => _selectEndTime(context));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Kết thúc lúc',
                    style: TextStyle(
                      fontSize: itime_text_size_medium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '*',
                    style: TextStyle(
                      fontSize: itime_text_size_medium,
                      fontWeight: FontWeight.bold,
                      color: itime_main_color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.0),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 15.0, bottom: 15.0),
                  child: Row(
                    children: [
                      Text(
                        '${dateFormat.format(selectedEndDate)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${selectedEndTime.hour}" +
                            ":" +
                            "${selectedEndTime.minute}",
                        style: secondaryTextStyle(),
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
    // END WIDGET SELECT END DATE SECTION

    // WIDGET AMOUNT OF HOUR SECTION
    Widget _amountOfHourSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Số giờ',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Container(
              height: 50,
              child: TextFormField(
                controller: _amountOfHourController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0',
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: itime_main_color, width: 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET AMOUNT OF HOUR SECTION

    // WIDGET ADD REASON SECTION
    Widget _addReasonSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Lý do',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                    color: itime_main_color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Container(
              child: TextFormField(
                controller: _reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Nội dung',
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: itime_main_color, width: 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET ADD REASON SECTION

    // WIDGET ADD CONTENT SECTION
    Widget _addContentSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Nội dung trao đổi',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  '*',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                    color: itime_main_color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Container(
              child: TextFormField(
                controller: _contentController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Nội dung trao đổi',
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.transparent, width: 1.0),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: itime_main_color, width: 1.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET ADD CONTENT SECTION

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        key: scaffoldKey,
        appBar: _appbarSection(),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10.0),
              _overtimeTypeSection(),
              SizedBox(height: 10.0),
              _selectStartDateSection(),
              SizedBox(height: 10.0),
              _selectEndDateSection(),
              // SizedBox(height: 10.0),
              // _amountOfHourSection(),
              // SizedBox(height: 10.0),
              // _branchOvertimeSection(),
              SizedBox(height: 10.0),
              _addReasonSection(),
              SizedBox(height: 10.0),
              _addContentSection(),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  /*
  * select start date
  * */
  Future<void> _selectStartDate(BuildContext context) async {
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
        initialDate: selectedStartDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedStartDate)
      setState(() {
        selectedStartDate = picked;
        print(selectedStartDate);
      });
  }

  /*
  * select start time
  * */
  Future<Null> _selectStartTime(BuildContext context) async {
    final TimeOfDay Picked = await showTimePicker(
        context: context,
        initialTime: selectedStartTime,
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
        selectedStartTime = Picked;
        print(selectedStartTime);
      });
  }

  /*
  * select end date
  * */
  Future<void> _selectEndDate(BuildContext context) async {
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
        initialDate: selectedEndDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedEndDate)
      setState(() {
        selectedEndDate = picked;
        print(selectedEndDate);
      });
  }

  /*
  * select end time
  * */
  Future<Null> _selectEndTime(BuildContext context) async {
    final TimeOfDay Picked = await showTimePicker(
        context: context,
        initialTime: selectedEndTime,
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
        selectedEndTime = Picked;
        print(selectedEndTime);
      });
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

    // get data overtime type
    overtimeTypeBloc.callWhat2100();
    // get data branch
    // branchBloc.callWhat6300();
  }

  // listen stream
  _listenStream() {
    overtimeTypeBloc.overtimeTypeStream2100.listen((event) {
      setState(() {
        overtimeTypeList = overtimeTypeBloc.listOvertimeType2100;
        print('overtimeTypeList ${overtimeTypeList}');
        for (var i = 0; i < overtimeTypeList.length; i++) {
          optionsOvertimeType.add(S2Choice<String>(
              value: overtimeTypeList[i].id, title: overtimeTypeList[i].Name));
        }
        print('optionsOvertimeType ${optionsOvertimeType}');
      });
    });
    // branchBloc.branchStream6300.listen((event) {
    //   branchList = branchBloc.listBranch6300;
    // });
    _getData();
  }

  /*
 * alert dialog
 * */
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
    overtimeTypeBloc.dispose();
    // branchBloc.dispose();

    super.dispose();
  }
}
