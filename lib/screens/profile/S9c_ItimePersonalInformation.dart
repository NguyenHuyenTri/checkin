import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/blocs/b5500_employee_bloc.dart';
import 'package:vao_ra/pages/itime/S9_ItimeProfileScreen.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/screens/screens.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/custom.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimePersonalInformation extends StatefulWidget {
  @override
  _ItimePersonalInformationState createState() =>
      _ItimePersonalInformationState();
}

class _ItimePersonalInformationState extends State<ItimePersonalInformation> {
  static final String uploadEndPoint =
      'https://api.mifago.com/p1izitime/P5Upload/UploadImageProfiles.php?';
  final employeeBloc = EmployeeBloc();
  final repository = Repository();

  SharedPreferences preferences;
  String employeeId;

  // EDITING CONTROLLER
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  String get _phone => _phoneController.text;

  String get _fullName => _fullNameController.text;

  String get _address => _addressController.text;

  String _id;
  bool update = false;

  //DATE TIME PICKER
  DateTime selectedStartDate;
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  // Define base data type
  int _radioValue = 1;
  String _textResult = '';

  //STATUS UPLOAD

  bool statusEditProfile = false;
  bool statusEditImage = false;
  bool statusUploadProfile = false;
  bool statusUploadImage = false;
  bool isLoadUpload;
  bool isDataChange = false;

  //UPLOAD FILE
  Dio dio = new Dio();
  File _image;
  final picker = ImagePicker();
  Response response;
  String progress;

  @override
  void initState() {
    super.initState();
    getDataEmployeeProflie();
  }

  getDataEmployeeProflie() async {
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> mapEmployee =
    jsonDecode(preferences.getString("user"));
    employeeId = mapEmployee['id'];
    employeeBloc.callWhat5513({
      "IdEmployee": employeeId,
    });
  }

  Future saveProfiles() async {
    isDataChange = true;

    print('upload employee');
    _setUploadProfile(false);
    print({
      "Fullname": _fullName,
      "Gender": _radioValue,
      "Birthday": DateFormat('yyyy-MM-dd').format(selectedStartDate),
      "Phone": _phone,
      "Address": _address,
      "id": _id,
    });
    try {
      await employeeBloc.callWhat5511({
        "Fullname": _fullName,
        "Gender": _radioValue,
        "Birthday": DateFormat('yyyy-MM-dd').format(selectedStartDate),
        "Phone": _phone,
        "Address": _address,
        "id": _id,
      });
      alert('G????i y??u c????u tha??nh c??ng !!!');
      _resetUpload();
      isDataChange = true;
    } catch (e) {
      alert('G????i y??u c????u th????t ba??i !!!');
    }
  }

  Future saveImage() async {
    print('L??u');
    _setUploadProfile(false);
    String name = DateFormat('dd-MM-yyyy-hh:mm').format(DateTime.now()) +
        '-' +
        _image.path.split('/').last;
    print(name);
    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        _image.path,
        filename: name,
        //show only filename from path
      ),
    });
    response = await dio.post(
      uploadEndPoint,
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent / total * 100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" +
              " Bytes of " "$total Bytes - " +
              percentage +
              " % uploaded";
          //update the progress
          print(progress);
          isLoadUpload = true;
        });
      },
    );

    if (response.statusCode == 200) {
      print(response.toString());
      String link =
          "https://api.mifago.com/p1izitime/P5Upload/" + response.toString();
      print(link);
      repository.r5500EmployeeProvider.p5500Employee(5512, {
        "id": _id,
        "Image": link,
      });
      setState(() {
        isLoadUpload = false;
      });
      _setEditImage(false);
      isDataChange = true;
      alert('G????i y??u c????u tha??nh c??ng !!!');
      //print response from server
    } else {
      alert('G????i y??u c????u th????t ba??i');
      print("Error during connection to server.");
    }
  }

  Future alert(String value) async {
    scaffoldKey.currentState.hideCurrentSnackBar();
    scaffoldKey.currentState.hasFloatingActionButton;
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(value,
          style: primaryTextStyle(color: Colors.white, fontFamily: fontAndika)),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
          label: '???n',
          onPressed: () {
            scaffoldKey.currentState.hideCurrentSnackBar();
          }),
    ));
  }

  // Get list from future
  // Get list from future
  // Time
  formatTime(date) {
    DateTime parseDate = new DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputFormat = DateFormat('dd/MM/yyyy');
    return outputFormat.format(inputDate);
  }

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime

  // sub function

  @override
  Widget build(BuildContext context) {
    final action1 = CustomTheme(
      child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return CupertinoActionSheet(
              actions: [
                CupertinoActionSheetAction(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 20,
                        color: getColorFromHex("#636363").withOpacity(0.5),
                      ),
                      SizedBox(width: 5.0),
                      Text(
                        'Ch???p ???nh ?????i di???n m???i',
                        style: TextStyle(
                          fontFamily: fontAndika,
                          fontSize: itime_text_size_medium,
                          color: getColorFromHex("#636363"),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () async {
                    _image = null;
                    _setEditImage(false);
                    _setUploadImage(false);
                    final pickedFile =
                    await picker.getImage(source: ImageSource.camera);
                    setState(() {
                      if (pickedFile != null) {
                        _image = File(pickedFile.path);
                        _setEditImage(true);
                        _setUploadImage(true);
                        Navigator.pop(context);
                      }
                    });
                  },
                ),
                CupertinoActionSheetAction(
                    onPressed: () async {
                      _image = null;
                      _setEditImage(false);
                      _setUploadImage(false);
                      final pickedFile =
                      await picker.getImage(source: ImageSource.gallery);
                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                          _setUploadImage(true);
                          Navigator.pop(context);
                          _setEditImage(true);
                        }
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.picture_in_picture,
                          size: 20,
                        ),
                        SizedBox(width: 5.0),
                        Text(
                          'Ch???n ???nh ?????i di???n',
                          style: TextStyle(
                            fontFamily: fontAndika,
                            fontSize: itime_text_size_medium,
                            color: getColorFromHex("#636363"),
                          ),
                        ),
                      ],
                    ))
              ],
            );
          }),
    );

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
            Navigator.pop(context, isDataChange);
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Th??ng tin c?? nh??n',
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
          InkWell(
            onTap: statusUploadProfile == true ? saveProfiles : saveImage,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10.0),
              child: Center(
                child: Text(
                  statusEditProfile == true
                      ? 'L??u'.toUpperCase()
                      : statusEditImage == true
                      ? '??????i'.toUpperCase()
                      : '',
                  style: TextStyle(
                      fontSize: itime_text_size_medium,
                      color: statusUploadImage == true ||
                          statusUploadProfile == true
                          ? itime_main_color
                          : appTextColorSecondary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      );
    }
    // END WIDGET APPBAR SECTION
    // _radioValue = int.parse(snapshot.data[0]['Gender']);
    // _phoneController.text = snapshot.data[0]['Phone'];
    // _addressController.text = snapshot.data[0]['Address'];
    // selectedStartDate = DateFormat("yyyy-MM-dd")
    //     .parse(snapshot.data[0]['Birthday']);
    // _fullNameController.text = snapshot.data[0]['Fullname'];
    // _id = employeeId;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: getColorFromHex("F9F9F9"),
        key: scaffoldKey,
        appBar: _appbarSection(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              SizedBox(height: 10.0),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      showCupertinoModalPopup(
                          context: context,
                          builder: (BuildContext context) => action1);
                    },
                    child: Center(
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
//                                image: DecorationImage(
//                                  image: NetworkImage(
//                                    'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
//                                  ),
//                                ),
                                ),
                                child: CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: _image == null
                                      ? NetworkImage('https://scontent.fdad4-1.fna.fbcdn.net/v/t1.6435-9/131099524_3479755855581840_3704586785001698229_n.jpg?_nc_cat=108&ccb=1-3&_nc_sid=09cbfe&_nc_ohc=Iwnfngk0B00AX9QCYOK&_nc_ht=scontent.fdad4-1.fna&oh=c38fa2a0bae92a409bc375190fca976b&oe=60D3DC66'
                                      )
                                      : FileImage(_image),
                                  backgroundColor: Colors.transparent,
                                ),
                              ), //Container
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
//                                  color: itime_main_color,
                                    borderRadius:
                                    BorderRadius.circular(30),
                                  ),
                                  child: Icon(
                                    Icons.camera_enhance,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              isLoadUpload == true
                                  ? Align(
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator())
                                  : Container(),
                            ], //<Widget>[]
                          ),
                        ),
                      ),
                    ), //Stack
//                  Container(
//                    width: 100,
//                    height: 100,

//                    decoration: BoxDecoration(
//                      color: itime_main_color,
//                      borderRadius: BorderRadius.circular(50.0),
//                    ),
//                  ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: getColorFromHex("#FFFFFF"),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'M?? NV:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      'NV-10001'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'H??? v?? t??n:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: TextFormField(
                                onChanged: (value) => checkValid(),
                                controller: _fullNameController,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Nguy????n Huy????n Tri??'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'Gi???i t??nh:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: new Row(
                                children: <Widget>[
                                  Row(
                                    children: [
                                      new Radio(
                                        value: 0,
                                        groupValue: _radioValue,
                                        onChanged:
                                        _handleRadioValueChange,
                                      ),
                                      new Text('Nam'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      new Radio(
                                        value: 1,
                                        groupValue: _radioValue,
                                        onChanged:
                                        _handleRadioValueChange,
                                      ),
                                      new Text('N???'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'Ng??y sinh:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: InkWell(
                                child: Text(
                                  '23/05/1998',
                                  style: TextStyle(
                                    fontSize: itime_text_size_medium,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                '?????a ch???:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: TextFormField(
                                controller: _addressController,
                                textInputAction: TextInputAction.next,
                                onChanged: (value) => checkValid(),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '??a?? N????ng'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'S??? ??i???n tho???i:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: TextFormField(
                                controller: _phoneController,
                                onChanged: (value) => checkValid(),
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '0358720099'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: getColorFromHex("#FFFFFF"),
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'Ph??ng ban:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Moblie App'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'Ch???c v???:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Nh??n vi??n'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'Chi nh??nh:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Izisoft'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'V??ng:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Izisoft'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              child: Text(
                                'L????ng/Gi??? c??ng:',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('0'),
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
      ),
    );
  }

  //SET STATE
  _setEditProfile(bool value) {
    setState(() {
      statusEditProfile = value;
    });
  }

  _setUploadProfile(bool value) {
    setState(() {
      statusUploadProfile = value;
    });
  }

  _setEditImage(bool value) {
    setState(() {
      statusEditImage = value;
    });
  }

  _setUploadImage(bool value) {
    setState(() {
      statusUploadImage = value;
    });
  }

  _resetUpload() {
    _setEditProfile(false);
    _setUploadImage(false);
    _setUploadProfile(false);
    _setEditImage(false);
  }

  // Change State

  _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
    checkValid();
  }

  checkValid() {
    print('Phone:' +
        _phone +
        '\nDate' +
        selectedStartDate.toString() +
        '\n FullName:' +
        _fullName +
        '\n Id' +
        _id +
        '\n Address:' +
        _address +
        '\nGender' +
        _radioValue.toString());
    _setEditProfile(true);
    _setUploadImage(false);
    if (_id != null) {
      if (_address.length > 8 &&
          _phone.length >= 9 &&
          _phone.length <= 12 &&
          _fullName.length >= 8) {
        _setUploadProfile(true);
      } else {
        _setUploadProfile(false);
      }
    }
  }

  @override
  void dispose() {
    employeeBloc.dispose();
    super.dispose();
  }
}
