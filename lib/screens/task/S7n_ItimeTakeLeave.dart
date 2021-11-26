import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/custom.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeTakeLeave extends StatefulWidget {
  @override
  _ItimeTakeLeaveState createState() => _ItimeTakeLeaveState();
}

class _ItimeTakeLeaveState extends State<ItimeTakeLeave> {
  // Get list from future
  final shiftBloc = new ShiftBloc();
  final typeLeaveBloc = new TypeLeaveBloc();
  final onLeaveTypeBloc = new OnLeaveTypeBloc();

//  final advanceSalaryBloc = new AdvanceSalaryBloc();
  final _repository = new Repository();

  // Get list model
  List<M1300OnLeaveTypeModel> onLeaveTypeList = [];
  List<M1400TypeLeaveModel> typeLeaveList = [];
  List<M3200ShiftModel> shiftList = [];

  // Define base data type
  String employeeId;
  String companyId;

  M3200ShiftModel shift;
  String shiftId;
  String shiftName;

  M1300OnLeaveTypeModel onLeaveType;
  String onLeaveTypeId;
  String onLeaveTypeName;

  M1400TypeLeaveModel typeLeave;
  String typeLeaveId;
  String typeLeaveName;

  bool isLoading = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;
  TextEditingController _handoverToController = new TextEditingController();
  TextEditingController _handoverToPhoneController =
      new TextEditingController();
  TextEditingController _reasonController = new TextEditingController();
  TextEditingController _contentController = new TextEditingController();

  // Define datetime
  DateTime selectedDate = DateTime.now();

  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  String period = 'AM';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  // sub function

  final shiftAssignmentBLOC = ShiftAssignmentBloc();

  M3400CompanyModel company;
  M5500EmployeeModel employee;

  List<M3000ShiftAssignmentModel> listShiftAssignment = [];
  List<M3200ShiftModel> listShift = [];

  @override
  void initState() {
    super.initState();

    _getKeySharePreferent();
    // _init();
  }

  @override
  Widget build(BuildContext context) {
    Widget _customDropDownTypeLeave(BuildContext context,
        M1400TypeLeaveModel item, String itemDesignation) {
      return Container(
        child: (item?.Name == null)
            ? ListTile(
                contentPadding: EdgeInsets.all(0),
                // leading: CircleAvatar(),
                title: Text(
                  "Hãy chọn thời gian nghỉ",
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

    Widget _customPopupItemBuilderTypeLeave(
        BuildContext context, M1400TypeLeaveModel item, bool isSelected) {
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

    Widget _customDropDownShift(
        BuildContext context, M3200ShiftModel item, String itemDesignation) {
      return Container(
        child: (item?.Name == null)
            ? ListTile(
                contentPadding: EdgeInsets.all(0),
                // leading: CircleAvatar(),
                title: Text(
                  "Hãy chọn ca nghỉ",
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

    Widget _customPopupItemBuilderShift(
        BuildContext context, M3200ShiftModel item, bool isSelected) {
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

    Widget _customDropDownOnLeaveType(BuildContext context,
        M1300OnLeaveTypeModel item, String itemDesignation) {
      return Container(
        child: (item?.Name == null)
            ? ListTile(
                contentPadding: EdgeInsets.all(0),
                // leading: CircleAvatar(),
                title: Text(
                  "Hãy chọn loại nghỉ phép",
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

    Widget _customPopupItemBuilderOnLeaveType(
        BuildContext context, M1300OnLeaveTypeModel item, bool isSelected) {
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
                'Đề nghị nghỉ phép',
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
                if (typeLeaveId == null ||
                    typeLeaveId == '0' ||
                    onLeaveTypeId == null ||
                    onLeaveTypeId == '0' ||
                    _handoverToController.text == null ||
                    _handoverToController.text == '' ||
                    _contentController.text == null ||
                    _contentController.text == '' ||
                    _reasonController.text == null ||
                    _reasonController.text == '') {
                  _showProgress(context, 1).whenComplete(() {
                    _showSnackbar("Vui lòng nhập đầy đủ thông tin!");
                  });
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  FocusScope.of(context).requestFocus(FocusNode());
                  try {
                    _showProgress(context, 4);
                    _repository.r1100OnLeaveProvider.p1100OnLeave(1101, {
                      "IdCompany": companyId.toString(),
                      "IdEmployee": employeeId.toString(),
                      "IdTypeLeave": typeLeaveId.toString(),
                      "IdOnLeaveType": onLeaveTypeId.toString(),
                      "IdShift": shiftId.toString(),
                      "IdStatusApprove": "1",
                      "FromDate":
                          "${selectedFromDate.year}-${selectedFromDate.month}-${selectedFromDate.day}",
                      "StartTime":
                          "${selectedFromDate.year.toString()}-${selectedFromDate.month.toString()}-${selectedFromDate.day.toString()} ${selectedFromDate.hour}:${selectedFromDate.minute}",
                      "ToDate":
                          "${selectedToDate.year.toString()}-${selectedToDate.month.toString()}-${selectedToDate.day.toString()}",
                      "EndTime":
                          "${selectedToDate.year.toString()}-${selectedToDate.month.toString()}-${selectedToDate.day.toString()} ${selectedToDate.hour}:${selectedToDate.minute}",
                      "Reason": _reasonController.text,
                      "HandoverTo": _handoverToController.text,
                      "Phone": _handoverToPhoneController.text,
                      "Content": _contentController.text,
                      "CreatedAt":
                          '${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}',
                    }).then((rs) {
                      print('value response ${rs}');
                      setState(() {
                        isLoading = false;
                      });
                      if (rs['error'] != null && rs['error'] != "") {
                        _showSnackbar(rs['error']);
                      } else {
                        _handoverToController.clear();
                        _handoverToPhoneController.clear();
                        _reasonController.clear();
                        _contentController.clear();
                        ExtendedNavigator.of(context).pop(true);
                      }
                    });
                  } catch (e) {
                    setState(() {
                      isLoading = false;
                    });
                    print('eee ${e}');
                    _showSnackbar("Gửi yêu cầu thất bại!");
                  }
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
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

    // WIDGET TYPE SECTION
    Widget _typeSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Loại thời gian',
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
              child: typeLeaveList.length == 0
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
                  : DropdownSearch<M1400TypeLeaveModel>(
                      mode: Mode.BOTTOM_SHEET,
                      maxHeight: 300,
                      items: typeLeaveList.map((M1400TypeLeaveModel model) {
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
                      // onChanged: (data) {},
                      // selectedItem: "Loading...",
                      dropdownBuilder: _customDropDownTypeLeave,
                      popupItemBuilder: _customPopupItemBuilderTypeLeave,
                      onChanged: (data) {
                        setState(() {
                          typeLeaveId = data.id;
                        });
                        typeLeave = data;
                        if (typeLeave.id == '1') {
                          //  Nghi 1/2 ngay
                          DateTime _date = new DateTime.now();
                          DateTime _fromDate =
                              new DateTime(_date.year, _date.month, _date.day);
                          DateTime _toDate = new DateTime(
                              _date.year, _date.month, _date.day, 23, 59, 59);
                          selectedFromDate = _fromDate;
                          selectedToDate = _toDate;
                        } else if (typeLeave.id == '2') {
                          //  Nghi 1 ngay
                          DateTime _date = new DateTime.now();
                          DateTime _fromDate =
                              new DateTime(_date.year, _date.month, _date.day);
                          DateTime _toDate = new DateTime(
                              _date.year, _date.month, _date.day, 23, 59, 59);
                          selectedFromDate = _fromDate;
                          selectedToDate = _toDate;
                        } else if (typeLeave.id == '3') {
                          //  Nghi nhieu ngay
                          DateTime _date = new DateTime.now();
                          DateTime _fromDate =
                              new DateTime(_date.year, _date.month, _date.day);
                          DateTime _toDate = new DateTime(_date.year,
                              _date.month, _date.day + 1, 23, 59, 59);
                          selectedFromDate = _fromDate;
                          selectedToDate = _toDate;
                        }
                        print(
                            'ON selectedFromDate ${selectedFromDate} selectedToDate ${selectedToDate}');
                        print(
                            'ON typeLeaveId ${typeLeaveId} typeLeave ${typeLeave}');
                      },
                      selectedItem: typeLeave,
                      showSearchBox: true,
                      searchBoxDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        labelText: "Tìm kiếm loại",
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
                            'Loại',
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
            ),
          ],
        ),
      );
    }
    // END TYPE SECTION

    // WIDGET SELECT SHIFT SECTION
    Widget _selectShiftSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Ca làm',
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
              child: listShift.length == 0
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
                  : DropdownSearch<M3200ShiftModel>(
                      mode: Mode.BOTTOM_SHEET,
                      maxHeight: 300,
                      items: listShift.map((M3200ShiftModel model) {
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
                      dropdownBuilder: _customDropDownShift,
                      popupItemBuilder: _customPopupItemBuilderShift,
                      onChanged: (data) {
                        setState(() {
                          shiftId = data.id;
                        });
                        shift = data;
                        print('ON shiftId ${shiftId} shift ${shift}');
                      },
                      selectedItem: shift,
                      showSearchBox: true,
                      searchBoxDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                        labelText: "Tìm kiếm ca làm",
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
                            'Ca làm việc',
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
            ),
          ],
        ),
      );
    }
    // END SELECT SHIFT  SECTION

    // WIDGET SELECT DATE SECTION
    Widget _selectDateSection() {
      return GestureDetector(
        onTap: () {
          _selectDate(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Ngày',
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
                        '${dateFormat.format(selectedDate)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0,
                        ),
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
    // END WIDGET SELECT DATE SECTION

    // WIDGET SELECT FROM DATE SECTION
    Widget _selectFromDateSection() {
      return GestureDetector(
        onTap: () {
          _selectFromDate(context);
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              width: MediaQuery.of(context).size.width - 20,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${dateFormat.format(selectedFromDate)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET SELECT FROM DATE SECTION

    // WIDGET SELECT END DATE SECTION
    Widget _selectEndDateSection() {
      return GestureDetector(
        onTap: () {
          _selectToDate(context);
        },
        child: Column(
          children: <Widget>[
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
                      '${dateFormat.format(selectedToDate)}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET SELECT END DATE SECTION

    // WIDGET TAKE LEAVE TYPE SECTION
    Widget _takeLeaveTypeSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Loại nghỉ phép',
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
              child: listShift.length == 0
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
                  : Container(
                      height: 50,
                      child: DropdownSearch<M1300OnLeaveTypeModel>(
                        mode: Mode.BOTTOM_SHEET,
                        maxHeight: 300,
                        items:
                            onLeaveTypeList.map((M1300OnLeaveTypeModel model) {
                          return model;
                        }).toList(),
                        dropdownSearchDecoration: InputDecoration(
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.transparent, width: 1.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: itime_main_color, width: 1.0),
                          ),
                        ),
                        dropdownBuilder: _customDropDownOnLeaveType,
                        popupItemBuilder: _customPopupItemBuilderOnLeaveType,
                        onChanged: (data) {
                          setState(() {
                            onLeaveTypeId = data.id;
                          });
                          onLeaveType = data;
                          print(
                              'ON onLeaveTypeId ${onLeaveTypeId} onLeaveType ${onLeaveType}');
                        },
                        selectedItem: onLeaveType,
                        showSearchBox: true,
                        searchBoxDecoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                          labelText: "Tìm kiếm loại nghỉ phép",
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
                              'Loại nghỉ phép',
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
                    ),
            ),
          ],
        ),
      );
    }
    // END TAKE LEAVE TYPE SECTION

    // WIDGET ADD HANDOVER TO SECTION
    Widget _addHandoverToSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Người bàn giao',
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
                controller: _handoverToController,
                decoration: InputDecoration(
                  hintText: 'Người bàn giao',
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
    // END WIDGET ADD HANDOVER TO SECTION

    // WIDGET ADD HANDOVER TO PHONE SECTION
    Widget _addHandoverToPhoneSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Số điện thoại (nếu có)',
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
                keyboardType: TextInputType.number,
                controller: _handoverToPhoneController,
                decoration: InputDecoration(
                  hintText: 'Số điện thoại người bàn giao',
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
    // END WIDGET ADD HANDOVER TO PHONE SECTION

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
                  hintText: 'Lý do',
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
                  'Nội dung',
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
              _typeSection(),
              SizedBox(height: 10.0),
              typeLeave != null && typeLeave.id == '1'
                  ? _selectShiftSection()
                  : Center(),
              typeLeave != null && typeLeave.id == '1'
                  ? SizedBox(height: 10.0)
                  : Center(),
              typeLeave != null && (typeLeave.id == '1' || typeLeave.id == '2')
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                'Chọn ngày nghỉ',
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
                          Row(
                            children: [
                              _selectFromDateSection(),
                            ],
                          ),
                          SizedBox(height: 10.0)
                        ],
                      ))
                  : Center(),
              typeLeave != null && typeLeave.id == '3'
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Text(
                                'Chọn khoảng ngày nghỉ',
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
                          Row(
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  width: 15,
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: _selectFromDateSection()),
                              Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  width: 15,
                                ),
                              ),
                              Text('Đến'),
                              Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  width: 15,
                                ),
                              ),
                              Container(
                                  width: MediaQuery.of(context).size.width / 3,
                                  child: _selectEndDateSection()),
                              Flexible(
                                fit: FlexFit.tight,
                                child: SizedBox(
                                  width: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ))
                  : Center(),
              SizedBox(height: 10.0),
              _takeLeaveTypeSection(),
              SizedBox(height: 10.0),
              _addHandoverToSection(),
              SizedBox(height: 10.0),
              _addHandoverToPhoneSection(),
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
  * select date
  * */
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
        selectedDate = picked;
        print(selectedDate);
      });
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
              accentColor: itime_main_color,
              highlightColor: itime_main_color,
              colorScheme: ColorScheme.light(primary: itime_main_color),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
        initialDate: selectedFromDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedFromDate)
      setState(() {
        selectedFromDate = picked;
        print(selectedFromDate);
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
              accentColor: itime_main_color,
              highlightColor: itime_main_color,
              colorScheme: ColorScheme.light(primary: itime_main_color),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
            ),
            child: child,
          );
        },
        initialDate: selectedToDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedToDate)
      setState(() {
        selectedToDate = picked;
        print(selectedToDate);
      });
  }

  // Future<Null> _selectStartTime(BuildContext context) async {
  //   final TimeOfDay Picked = await showTimePicker(
  //       context: context,
  //       initialTime: selectedStartTime,
  //       builder: (BuildContext context, Widget child) {
  //         return CustomTheme(
  //           child: MediaQuery(
  //             data:
  //                 MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
  //             child: child,
  //           ),
  //         );
  //       });
  //
  //   if (Picked != null)
  //     setState(() {
  //       selectedStartTime = Picked;
  //       print(selectedStartTime);
  //     });
  // }

  // Future<Null> _selectEndTime(BuildContext context) async {
  //   final TimeOfDay Picked = await showTimePicker(
  //       context: context,
  //       initialTime: selectedEndTime,
  //       builder: (BuildContext context, Widget child) {
  //         return CustomTheme(
  //           child: MediaQuery(
  //             data:
  //                 MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
  //             child: child,
  //           ),
  //         );
  //       });
  //
  //   if (Picked != null)
  //     setState(() {
  //       selectedEndTime = Picked;
  //       print(selectedEndTime);
  //     });
  // }

  // get data employeeId, companyId
  _getKeySharePreferent() async {
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> mapEmployee =
        jsonDecode(preferences.getString("user"));
    Map<String, dynamic> mapCompany =
        jsonDecode(preferences.getString("company"));

    employeeId = mapEmployee['id'];
    companyId = mapCompany['id'];

    // get email and id company
    preferences = await SharedPreferences.getInstance();
    final String userJSON = preferences.getString('user');
    final String companyJSON = preferences.getString('company');
    this.employee = M5500EmployeeModel.fromJson(json.decode(userJSON));
    this.company = M3400CompanyModel.fromJson(json.decode(companyJSON));
    print('employee id ${this.employee.id}');
    print('company id ${this.company.id}');

    _listenStream();
  }

  _handleShiftAssignmentReturn(event) {
    setState(() {
      listShiftAssignment = shiftAssignmentBLOC.listShiftAssignment3007;
    });
    // print('listShiftAssignment ${listShiftAssignment}');
    List<int> arrayShiftAssignmentID = [];
    for (var i = 0; i < listShiftAssignment.length; i++) {
      arrayShiftAssignmentID.add(int.parse(listShiftAssignment[i].IdShift));
    }

    print('arrayShiftAssignmentID ${arrayShiftAssignmentID}');
    var param = {
      "arrayID": arrayShiftAssignmentID,
      "IdCompany": this.company.id,
      "IdEmployee": this.employee.id,
      "IdEmployee": this.employee.id,
      "IsOvertimeShift": 0,
      "what": 3208
    };
    shiftBloc.callWhat3208(param);
  }

  _handleShiftReturn(event) async {
    // print('event ${event}');
    print('shiftBLOC listShift3208');
    setState(() {
      listShiftAssignment = [];
      listShift = [];
      listShift = shiftBloc.listShift3208;
      print('shiftBLOC listShift3208 ${listShift}');
      // _prepareHandleCheckinListShift();
    });
  }

  // listen stream
  _listenStream() {
    shiftAssignmentBLOC.shiftAssignmentStream3007
        .listen(_handleShiftAssignmentReturn);

    shiftBloc.shiftStream3208.listen(_handleShiftReturn);

    shiftAssignmentBLOC.callWhat3007(this.company.id, this.employee.id,
        this.employee.IdDepartment, this.employee.IdBranch);

    typeLeaveBloc.typeLeaveStream1400.listen((event) {
      print('call callWhat1400 end ${DateTime.now()}');
      setState(() {
        typeLeaveList = typeLeaveBloc.listTypeLeave1400;
      });
    });

    onLeaveTypeBloc.onLeaveTypeStream1300.listen((event) {
      setState(() {
        onLeaveTypeList = onLeaveTypeBloc.listOnLeaveType1300;
      });
    });

    typeLeaveBloc.callWhat1400();
    onLeaveTypeBloc.callWhat1300();
  }

  // _init() {
  //   _getKeySharePreferent();
  //
  //   // shiftBloc.callWhat3200();
  //
  //   print('call callWhat1400 start ${DateTime.now()}');
  // }

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
    shiftBloc.dispose();
    onLeaveTypeBloc.dispose();
    typeLeaveBloc.dispose();

    super.dispose();
  }
}
