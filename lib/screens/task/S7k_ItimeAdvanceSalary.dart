import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/models/m2200_advancesalarytype_model.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeAdvanceSalary extends StatefulWidget {
  @override
  _ItimeAdvanceSalaryState createState() => _ItimeAdvanceSalaryState();
}

class _ItimeAdvanceSalaryState extends State<ItimeAdvanceSalary> {
  // Get list from future, bloc
  final _repository = Repository();
  final advanceSalaryTypeBloc = new AdvanceSalaryTypeBloc();

//  final advanceSalaryBloc = new AdvanceSalaryBloc();

  // Get list model
  List<M2200AdvanceSalaryTypeModel> advanceSalaryList = [];

  // Define base data type
  String companyId;
  String employeeId;

  M2200AdvanceSalaryTypeModel advanceSalary;
  String advanceSalaryName;
  String advanceSalaryId;
  String companyName;

  bool isLoading = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;
  TextEditingController _titleController = new TextEditingController();
  TextEditingController _moneyController = new TextEditingController();
  TextEditingController _reasonController = new TextEditingController();

  // Define datetime
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
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
        M2200AdvanceSalaryTypeModel item, String itemDesignation) {
      return Container(
        child: (item?.Name == null)
            ? ListTile(
                contentPadding: EdgeInsets.all(0),
                // leading: CircleAvatar(),
                title: Text(
                  "Hãy chọn loại tạm ứng",
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

    Widget _customPopupItemBuilderExample(BuildContext context,
        M2200AdvanceSalaryTypeModel item, bool isSelected) {
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
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Tạm ứng',
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
                if (companyId.toString() == '' ||
                    employeeId.toString() == '' ||
                    advanceSalaryId == null ||
                    advanceSalaryId.toString() == '' ||
                    _titleController.text == '' ||
                    _moneyController.text == '') {
                  _showProgress(context, 1).whenComplete(() {
                    _showSnackbar("Vui lòng nhập đầy đủ thông tin!");
                  });
                } else if (int.parse(_moneyController.text) > 10000000) {
                  _showProgress(context, 1).whenComplete(() {
                    _showSnackbar("Ứng số tiền quá quy định!");
                  });
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  _showProgress(context, 3);
                  _repository.r2300AdvanceSalaryProvider
                      .p2300AdvanceSalary(2301, {
                    "IdEmployee": employeeId.toString(),
                    "IdCompany": companyId.toString(),
                    "Money": _moneyController.text,
                    "Title": _titleController.text,
                    "AllowanceDay":
                        '${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}',
                    "Reason": _reasonController.text,
                    "IdStatusApprove": "1",
                    "CreatedAt":
                        '${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}',
                  }).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    if (value == true) {
                      _titleController.clear();
                      _moneyController.clear();
                      _reasonController.clear();
                      ExtendedNavigator.of(context).pop(true);
                    } else {
                      _showProgress(context, 1).whenComplete(() {
                        _showSnackbar("Gửi yêu cầu thất bại!");
                      });
                    }
                  });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0, left: 25.0),
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

    // WIDGET SELECT ALLOWANCE DATE SECTION
    Widget _selectAllowanceDateSection() {
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
                    'Ngày ứng',
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
                  child: Text(
                    '${dateFormat.format(selectedDate)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    // END WIDGET SELECT ALLOWANCE DATE SECTION

    // WIDGET ADD TITLE SECTION
    Widget _addTitleSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Tiêu đề',
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
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Nhập tiêu đề',
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
    // END WIDGET ADD TITLE SECTION

    // WIDGET ADVANCE SALARY TYPE SECTION
    Widget _advanceSalaryTypeSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Loại tạm ứng',
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
              child: advanceSalaryList.length == 0
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
                  : DropdownSearch<M2200AdvanceSalaryTypeModel>(
                      mode: Mode.BOTTOM_SHEET,
                      maxHeight: 300,
                      items: advanceSalaryList
                          .map((M2200AdvanceSalaryTypeModel model) {
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
                      dropdownBuilder: _customDropDownExample,
                      popupItemBuilder: _customPopupItemBuilderExample,
                      onChanged: (data) {
                        setState(() {
                          advanceSalaryId = data.id;
                        });
                        advanceSalary = data;
                        print(
                            'ON advanceSalaryId ${advanceSalaryId} advanceSalary ${advanceSalary}');
                      },
                      selectedItem: advanceSalary,
                      showSearchBox: true,
                      searchBoxDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        labelText: "Tìm kiếm loại ứng lương",
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
                            'Loại tạm ứng',
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
    // END WIDGET ADVANCE SALARY TYPE SECTION

    // WIDGET ADVANCE SALARY MONEY SECTION
    Widget _advanceSalaryMoneySection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Tiền ứng',
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
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: _moneyController,
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
    // END WIDGET ADVANCE SALARY MONEY SECTION

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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        key: scaffoldKey,
        appBar: _appbarSection(),
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10.0),
              _selectAllowanceDateSection(),
              SizedBox(height: 10.0),
              _addTitleSection(),
              SizedBox(height: 10.0),
              _advanceSalaryTypeSection(),
              SizedBox(height: 10.0),
              _advanceSalaryMoneySection(),
              SizedBox(height: 10.0),
              _addReasonSection(),
            ],
          ),
        ),
      ),
    );
  }

  /*
  * selected date with date time picker
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
        print(picked);
        selectedDate = picked;
      });
  }

  /*
  * get data from user json and company json
  * */
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
    companyName = mapCompany['CompanyName'];

    // get data advance salary
    advanceSalaryTypeBloc.callWhat2200();
  }

  // listen stream
  _listenStream() {
    advanceSalaryTypeBloc.advanceSalaryTypeStream2200.listen((event) {
      setState(() {
        advanceSalaryList = advanceSalaryTypeBloc.listAdvanceSalaryType2200;
      });
    });

    _getData();
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
    advanceSalaryTypeBloc.dispose();
    super.dispose();
//    advanceSalaryBloc.dispose();
  }
}
