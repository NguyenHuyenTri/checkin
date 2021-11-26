import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:vao_ra/blocs/blocs.dart';
import 'package:vao_ra/helpers/place_service.dart';
import 'package:vao_ra/models/m3200_shift_model.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/screens/task/S7p_ItimeGoogleAddressAutoComplete.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/custom.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeBusinessTrip extends StatefulWidget {
  @override
  _ItimeBusinessTripState createState() => _ItimeBusinessTripState();
}

class _ItimeBusinessTripState extends State<ItimeBusinessTrip> {
  // Get list from future
  final shiftBloc = ShiftBloc();
  final _repository = new Repository();

  // Get list model
  List<M3200ShiftModel> shiftList = [];

  // Define base data type
  String employeeId;
  String companyId;

  String shift;
  String shiftId;
  String shiftName;

  bool isLoading = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  SharedPreferences preferences;
  TextEditingController _placeController = new TextEditingController();
  TextEditingController _reasonController = new TextEditingController();

  // Define datetime
  DateTime selectedFromDate = DateTime.now();
  TimeOfDay selectedFromTime = TimeOfDay.now();

  DateTime selectedToDate = DateTime.now();
  TimeOfDay selectedToTime = TimeOfDay.now();

  DateTime selectedDate = DateTime.now();

  String period = 'AM';
  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  // Prediction _prediction;

  @override
  void initState() {
    super.initState();

    _listenStream();
  }

  final kGoogleApiKey = "API_KEY";

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
                'Công tác/Ra ngoài',
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
                if (_placeController.text == '' || _reasonController.text == ''
                    // || shiftId == 0.toString()
                    ) {
                  _showProgress(context, 1).whenComplete(() {
                    _showSnackbar("Vui lòng nhập đầy đủ thông tin!");
                  });
                } else {
                  setState(() {
                    isLoading = true;
                  });
                  _showProgress(context, 3);
                  _repository.r1700BusinessTripProvider
                      .p1700BusinessTrip(1701, {
                    "IdCompany": companyId.toString(),
                    "IdEmployee": employeeId.toString(),
                    "FromTime":
                        "${selectedFromDate.year}-${selectedFromDate.month}-${selectedFromDate.day} ${selectedFromTime.hour}:${selectedFromTime.minute}",
                    "EndTime":
                        "${selectedToDate.year}-${selectedToDate.month}-${selectedToDate.day} ${selectedToTime.hour}:${selectedToTime.minute}",
                    "Place": _placeController.text,
                    "TrackingPlace": _placeController.text,
                    // "IdShift": shiftId.toString(),
                    "Reason": _reasonController.text,
                    "CreatedAt":
                        '${selectedDate.year.toString()}-${selectedDate.month.toString()}-${selectedDate.day.toString()}',
                  }).then((value) {
                    setState(() {
                      isLoading = false;
                    });
                    if (value == true) {
                      _placeController.clear();
                      _placeController.clear();
                      _reasonController.clear();

                      // Navigator.pop(context);
                      // Navigator.pop(context);
                      // Navigator.pop(context, true);
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

    // WIDGET SELECT FROM DATE SECTION
    Widget _selectFromDateSection() {
      return GestureDetector(
        onTap: () {
          _selectFromDate(context).whenComplete(() => _selectFromTime(context));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Từ',
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
                        '${dateFormat.format(selectedFromDate)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${selectedFromTime.hour}" +
                            ":" +
                            "${selectedFromTime.minute}",
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
    // END WIDGET SELECT FROM DATE SECTION

    // WIDGET SELECT TO DATE SECTION
    Widget _selectToDateSection() {
      return GestureDetector(
        onTap: () {
          _selectToDate(context).whenComplete(() => _selectToTime(context));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Text(
                    'Đến',
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
                        '${dateFormat.format(selectedToDate)}',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 15.0,
                        ),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        "${selectedToTime.hour}" +
                            ":" +
                            "${selectedToTime.minute}",
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
    // END WIDGET SELECT TO DATE SECTION

    String _streetNumber = '';
    String _street = '';
    String _city = '';
    String _zipCode = '';

    // WIDGET LOCATED SECTION
    Widget _locatedSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Địa điểm',
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
            GestureDetector(
              onTap: () async {
                // generate a new token here
                final sessionToken = Uuid().v4();
                final Suggestion result = await showSearch(
                  context: context,
                  delegate: AddressSearch(sessionToken),
                );
                // This will change the text displayed in the TextField
                if (result != null) {
                  final placeDetails = await PlaceApiProvider(sessionToken)
                      .getPlaceDetailFromId(result.placeId);
                  setState(() {
                    _placeController.text = result.description;
                    _streetNumber = placeDetails.streetNumber;
                    _street = placeDetails.street;
                    _city = placeDetails.city;
                    _zipCode = placeDetails.zipCode;
                  });
                }
              },
              child: Container(
                height: 50,
                child: TextFormField(
                  enabled: false,
                  controller: _placeController,
                  onTap: () async {
                  },
                  decoration: InputDecoration(
                    hintText: 'Địa điểm',
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: Colors.transparent, width: 0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: Colors.transparent, width: 0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                          Radius.circular(8.0)),
                      borderSide: BorderSide(
                          color: Colors.transparent, width: 0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET LOCATED SECTION

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
            StreamBuilder<List<M3200ShiftModel>>(
                stream: shiftBloc.shiftStream3200,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Container(
                        height: 50,
                        child: DropdownSearch<Object>(
                          mode: Mode.BOTTOM_SHEET,
                          maxHeight: 300,
                          items: shiftList.map((M3200ShiftModel model) {
                            return '${model.Name} - ${model.id}';
                          }).toList(),
                          dropdownSearchDecoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
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
                          onChanged: (data) {},
                          selectedItem: "Loading...",
                          showSearchBox: true,
                          searchBoxDecoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
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
                      );
                      break;
                    default:
                      if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      } else {
                        return Container(
                          height: 50,
                          child: DropdownSearch<Object>(
                            mode: Mode.BOTTOM_SHEET,
                            maxHeight: 300,
                            items: shiftList.map((M3200ShiftModel model) {
                              return '${model.Name} - ${model.id}';
                            }).toList(),
                            dropdownSearchDecoration: InputDecoration(
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
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
                            onChanged: (data) {
                              // Get string from data
                              shift = data;
                              // Cut string from stringCompany
                              var parts = shift.toString().split('-');
                              // First string on parts
                              shiftName = parts[0].trim();
                              // Second string on parts
                              shiftId = parts.sublist(1).join('-').trim();
                              // Third string on parts
                              shiftName = parts[1].trim();
                              shiftId = parts.sublist(2).join('-').trim();
                              print(
                                  'in ra mã ca làm việc' + shiftId.toString());
                            },
                            hint: "-- Chọn ca làm việc --",
                            showSearchBox: true,
                            searchBoxDecoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
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
                        );
                      }
                  }
                }),
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
              _selectFromDateSection(),
              SizedBox(height: 10.0),
              _selectToDateSection(),
              SizedBox(height: 10.0),
              _locatedSection(),
              // SizedBox(height: 10.0),
              // _selectShiftSection(),
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

  Future<Null> _selectFromTime(BuildContext context) async {
    final TimeOfDay Picked = await showTimePicker(
        context: context,
        initialTime: selectedFromTime,
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
        selectedFromTime = Picked;
        print(selectedFromTime);
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

  Future<Null> _selectToTime(BuildContext context) async {
    final TimeOfDay Picked = await showTimePicker(
        context: context,
        initialTime: selectedToTime,
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
        selectedToTime = Picked;
        print(selectedToTime);
      });
  }

  // get data employeeId, companyId
  _getData() async {
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> mapEmployee =
        jsonDecode(preferences.getString("user"));
    Map<String, dynamic> mapCompany =
        jsonDecode(preferences.getString("company"));

    employeeId = mapEmployee['id'];
    companyId = mapCompany['id'];

    // _prediction = await PlacesAutocomplete.show(
    //     context: context,
    //     apiKey: kGoogleApiKey,
    //     mode: Mode.overlay, // Mode.fullscreen
    //     language: "vi",
    //     components: [new Component(Component.country, "vn")]);
    // // shiftBloc.callWhat3200();
  }

  // listen stream
  _listenStream() {
    // shiftBloc.shiftStream3200.listen((event) {
    //   shiftList = shiftBloc.listShift3200;
    // });
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
    shiftBloc.dispose();
    super.dispose();
  }
}
