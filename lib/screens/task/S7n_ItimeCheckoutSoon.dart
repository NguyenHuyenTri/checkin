import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/routes/router.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/custom.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ItimeCheckoutSoon extends StatefulWidget {
  @override
  _ItimeCheckoutSoonState createState() => _ItimeCheckoutSoonState();
}

class _ItimeCheckoutSoonState extends State<ItimeCheckoutSoon> {
  // Get list from future
  final advanceSalaryBloc = AdvanceSalaryBloc();
  final shiftBloc = ShiftBloc();
  final checkoutSoonBloc = CheckoutSoonBloc();
  final _repository = new Repository();

  // Get list model
  List<M3200ShiftModel> shiftList = [];

  // Define base data type
  String employeeId;
  String employeeName;
  String companyId;

  double longitude;
  double latitude;

  M3200ShiftModel shift;
  String shiftId;
  String shiftName;

  bool isLoading = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;
  TextEditingController _reasonController = new TextEditingController();

  // Define datetime
  DateTime checkoutDate = DateTime.now();
  DateTime currentDate = DateTime.now();

  TimeOfDay checkoutTime = TimeOfDay.now();

  String period = 'AM';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  final shiftAssignmentBLOC = ShiftAssignmentBloc();

  M3400CompanyModel company;
  M5500EmployeeModel employee;

  List<M3000ShiftAssignmentModel> listShiftAssignment = [];
  List<M3200ShiftModel> listShift = [];

  @override
  void initState() {
    super.initState();

    _getKeySharePreferent();

  }

  @override
  Widget build(BuildContext context) {
    Widget _customDropDownExample(
        BuildContext context, M3200ShiftModel item, String itemDesignation) {
      return Container(
        child: (item?.Name == null)
            ? ListTile(
                contentPadding: EdgeInsets.all(0),
                // leading: CircleAvatar(),
                title: Text(
                  "H??y ch???n ca l??m",
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
    // _init();

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
                'Xin v??? s???m',
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
                if (_reasonController.text == '' || shiftId == null ||  shiftId == 0.toString()) {
                  _showProgress(context, 1).whenComplete(() {
                    _showSnackbar("Vui l??ng nh???p ?????y ????? th??ng tin!");
                  });
                } else {

                  setState(() {
                    isLoading = true;
                  });

                  FocusScope.of(context).requestFocus(FocusNode());

                  _repository.r1500CheckoutSoonProvider
                      .p1500CheckoutSoon(1501, {
                    "IdCompany": companyId.toString(),
                    "IdEmployee": employeeId.toString(),
                    "IdShift": shiftId.toString(),
                    "CheckoutDate":
                        "${checkoutDate.year}-${checkoutDate.month}-${checkoutDate.day}",
                    "CheckoutTime":
                        "${checkoutTime.hour}:${checkoutTime.minute}",
                    "IdStatusApprove": "1",
                    "TrackingLocationLat": latitude.toString(),
                    "TrackingLocationLng": longitude.toString(),
                    "Reason": _reasonController.text,
                    "CreatedAt":
                        "${currentDate.year}-${currentDate.month}-${currentDate.day}",
                  }).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    if (value == true) {
                      ExtendedNavigator.of(context).pop(true);
                    } else {
                      _showSnackbar("G???i y??u c???u th???t b???i!");
                    }
                  });
                }
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: Text(
                  isLoading ? 'G???i' : 'G???i'.toUpperCase(),
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

    // WIDGET SELECT CHECKOUT DATE SECTION
    Widget _selectCheckinDateSection() {
      return GestureDetector(
        onTap: () {
          _selectCheckinDate(context)
              .whenComplete(() => _selectCheckoutTime(context));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Ng??y gi??? v??? s???m',
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
                        '${dateFormat.format(checkoutDate)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${checkoutTime.hour}" + ":" + "${checkoutTime.minute}",
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
    // END WIDGET SELECT CHECKIN DATE SECTION

    // WIDGET SELECT SHIFT SECTION
    Widget _selectShiftSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Ca l??m',
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
                          "??ang t???i ...",
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
                      dropdownBuilder: _customDropDownExample,
                      popupItemBuilder: _customPopupItemBuilderExample,
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
                        contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                        labelText: "T??m ki???m ca l??m",
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
                            'Ca l??m vi???c',
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

    // WIDGET ADD REASON SECTION
    Widget _addReasonSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'L?? do',
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
                  hintText: 'L?? do',
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
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10.0),
              _selectCheckinDateSection(),
              SizedBox(height: 10.0),
              _selectShiftSection(),
              SizedBox(height: 10.0),
              _addReasonSection(),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  /*
  * select day
  * */
  Future<void> _selectCheckinDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        helpText: 'Ch???n ng??y b??o c??o',
        cancelText: 'H???y',
        confirmText: "Ch???n",
        fieldLabelText: 'Ch???n ng??y',
        fieldHintText: 'Month/Date/Year',
        errorFormatText: 'Vui l??ng ch???n ng??y ????ng.',
        errorInvalidText: 'Vui l??ng ch???n ng??y ????ng.',
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
        initialDate: checkoutDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != checkoutDate)
      setState(() {
        checkoutDate = picked;
        print(checkoutDate);
      });
  }

  Future<Null> _selectCheckoutTime(BuildContext context) async {
    final TimeOfDay Picked = await showTimePicker(
        context: context,
        initialTime: checkoutTime,
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
        checkoutTime = Picked;
        print(checkoutTime);
      });
  }

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
      "what": 3207
    };
    shiftBloc.callWhat3207(param);
  }

  _handleShiftReturn(event) async {
    // print('event ${event}');
    print('shiftBLOC listShift3207');
    setState(() {
      listShiftAssignment = [];
      listShift = [];
      listShift = shiftBloc.listShift3207;
      print('shiftBLOC listShift3207 ${listShift}');
      // _prepareHandleCheckinListShift();
    });
  }

  // listen stream
  _listenStream() {
    shiftAssignmentBLOC.shiftAssignmentStream3007
        .listen(_handleShiftAssignmentReturn);

    shiftBloc.shiftStream3207.listen(_handleShiftReturn);

    shiftAssignmentBLOC.callWhat3007(this.company.id, this.employee.id,
        this.employee.IdDepartment, this.employee.IdBranch);
  }

  // show snackbar
  Future<void> _showSnackbar(String title) {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text('${title.toString()}',
          style: primaryTextStyle(color: Colors.white, fontFamily: fontAndika)),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
          label: '???n',
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

    advanceSalaryBloc.dispose();
    shiftBloc.dispose();
    checkoutSoonBloc.dispose();
    super.dispose();
  }
}
