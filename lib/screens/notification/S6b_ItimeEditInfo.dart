import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../main.dart';

class ItimeEditInfo extends StatefulWidget {
  @override
  _ItimeEditInfoState createState() => _ItimeEditInfoState();
}

class _ItimeEditInfoState extends State<ItimeEditInfo> {
  // Get list from future

  // Get list model

  // Define base data type
  String categoryName;
  bool showAdvanced = false;
  bool isAttachInfo = false;
  bool isComfirm = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime

  // sub function
  void _pressAdvanced() {
    setState(() {
      showAdvanced = !showAdvanced;
    });
  }

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
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Thông tin',
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
            onTap: () {
              scaffoldKey.currentState.hideCurrentSnackBar();
              scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text('Chỉnh sửa thông tin thành công!',
                    style: primaryTextStyle(
                        color: Colors.white, fontFamily: fontAndika)),
                duration: Duration(seconds: 2),
                action: SnackBarAction(
                    label: 'Ẩn',
                    onPressed: () {
                      scaffoldKey.currentState.hideCurrentSnackBar();
                    }),
              ));
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Center(
                child: Text(
                  'Gửi'.toUpperCase(),
                  style: TextStyle(
                      fontSize: itime_text_size_medium,
                      color: itime_main_color,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      );
    }
    // END WIDGET APPBAR SECTION

    // WIDGET SELECT INFORMATION TYPE SECTION
    Widget _informationTypeSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Danh mục',
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
            DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 300,
              items: [
                "Danh mục thông tin 1",
                "Danh mục thông tin 2",
                "Danh mục thông tin 3",
                "Danh mục thông tin 4"
              ],
              onChanged: (String data) {
                categoryName = data;
                print(categoryName);
              },
//                    selectedItem: "Chọn loại thông tin",
              hint: "Chọn loại thông tin",
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Tìm kiếm danh mục",
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
                    'Danh mục',
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
          ],
        ),
      );
    }
    // END WIDGET SELECT INFORMATION TYPE SECTION

    // WIDGET ALERT ADD CATEGORY SECTION
    Widget _alertAddCategorySection() {
      return AlertDialog(
        backgroundColor: appStore.scaffoldBackground,
        content: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(height: 50, color: itime_main_color),
                  Column(
                    children: [
                      Text('Thêm loại mới',
                          textAlign: TextAlign.center,
                          style: boldTextStyle(
                              color: getColorFromHex("#FFFFFF"), size: 18)),
                    ],
                  )
                ],
              ),
              20.height,
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    EditText(
                      hint: 'Nhập nội dung',
                      isPassword: false,
                      isReadOnly: false,
                    ),
                  ],
                ),
              ),
              16.height,
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        width: 120,
                        decoration: boxDecoration(bgColor: Colors.black87),
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Center(
                            child: text("Hủy",
                                textColor: white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: 120,
                        decoration: boxDecoration(bgColor: itime_main_color),
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Center(
                            child: text("Tạo",
                                textColor: white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
              16.height,
            ],
          ),
        ),
        contentPadding: EdgeInsets.all(0),
      );
    }
    // END WIDGET ALERT ADD CATEGORY SECTION

    // WIDGET ADD INFO AND SHOW ADVANCED SECTION
    Widget _buttonAddAndShowSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _alertAddCategorySection();
                  },
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Thêm danh mục',
                    style: TextStyle(
                      fontSize: itime_text_size_medium,
                      color: itime_main_color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.0),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: itime_main_color,
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: itime_main_color,
                  )),
            ),
            SizedBox(width: 10.0),
            InkWell(
              onTap: () {
                _pressAdvanced();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Nâng cao',
                    style: TextStyle(
                      fontSize: itime_text_size_medium,
                      color: itime_main_color,
                    ),
                  ),
                  SizedBox(width: 2.0),
                  showAdvanced == false
                      ? Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Icon(
                            Icons.arrow_drop_up,
                            color: itime_main_color,
                          ),
                        )
                      : Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Icon(
                            Icons.arrow_drop_down,
                            color: itime_main_color,
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET ADD INFO AND SHOW ADVANCED SECTION

    // WIDGET SELECT AREA SECTION
    Widget _selectAreaSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Vùng',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 300,
              items: ["Vùng 1", "Vùng 2", "Vùng 3", "Vùng 4"],
              onChanged: (String data) {
                categoryName = data;
                print(categoryName);
              },
//                    selectedItem: "Chọn loại thông tin",
              hint: "Chọn vùng",
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Tìm kiếm vùng",
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
                    'Vùng',
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
          ],
        ),
      );
    }
    // END WIDGET SELECT AREA SECTION

    // WIDGET SELECT BRANCH SECTION
    Widget _selectBranchSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Chi nhánh',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 300,
              items: [
                "Chi nhánh 1",
                "Chi nhánh 2",
                "Chi nhánh 3",
                "Chi nhánh 4"
              ],
              onChanged: (String data) {
                categoryName = data;
                print(categoryName);
              },
              hint: "Chọn chi nhánh",
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Tìm kiếm chi nhánh",
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
                    'Chi nhánh',
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
          ],
        ),
      );
    }
    // END WIDGET SELECT BRANCH SECTION

    // WIDGET SELECT DEPARTMENT SECTION
    Widget _selectDepartmentSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Phòng ban',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 300,
              items: [
                "Phòng ban 1",
                "Phòng ban 2",
                "Phòng ban 3",
                "Phòng ban 4"
              ],
              onChanged: (String data) {
                categoryName = data;
                print(categoryName);
              },
              hint: "Chọn phòng ban",
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Tìm kiếm phòng ban",
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
                    'Phòng ban',
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
          ],
        ),
      );
    }
    // END WIDGET SELECT DEPARTMENT SECTION

    // WIDGET SELECT EMPLOYEE SECTION
    Widget _selectEmployeeSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Nhân viên',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            DropdownSearch<String>(
              mode: Mode.BOTTOM_SHEET,
              maxHeight: 300,
              items: [
                "Nhân viên 1",
                "Nhân viên 2",
                "Nhân viên 3",
                "Nhân viên 4"
              ],
              onChanged: (String data) {
                categoryName = data;
                print(categoryName);
              },
              hint: "Chọn nhân viên",
              showSearchBox: true,
              searchBoxDecoration: InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                labelText: "Tìm kiếm nhân viên",
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
                    'Nhân viên',
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
          ],
        ),
      );
    }
    // END WIDGET SELECT EMPLOYEE SECTION

    // WIDGET ADD IMAGE DOCUMENT SECTION
    Widget _addImageDocumentSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Tài liệu',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
//                  EditText(
//                    hint: 'Thêm',
//                    isPassword: false,
//                  ),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                width: MediaQuery.of(context).size.width,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: getColorFromHex('#C2C8CD'),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: itime_main_color,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Thêm',
                      style: TextStyle(
                        fontSize: itime_text_size_medium,
                        fontWeight: FontWeight.w500,
                        color: getColorFromHex('#C2C8CD'),
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
    // END WIDGET ADD IMAGE DOCUMENT SECTION

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
              ],
            ),
            SizedBox(height: 5.0),
            EditText(
              hint: 'Tiêu đề',
              isPassword: false,
              isReadOnly: false,
            ),
          ],
        ),
      );
    }
    // END WIDGET ADD TITLE SECTION

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
              ],
            ),
            SizedBox(height: 5.0),
            EditText(
              hint: 'Nhập nội dung',
              isPassword: false,
              maxLine: 3,
              isReadOnly: false,
            ),
          ],
        ),
      );
    }
    // END WIDGET ADD CONTENT SECTION

    // WIDGET ATTACH INFORMATION AND CONFIRM
    Widget _attachInfoAndConfirm() {
      return Column(
        children: <Widget>[
          Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Switch(
                  value: isAttachInfo,
                  onChanged: (value) {
                    setState(() {
                      isAttachInfo = value;
                      print(isAttachInfo);
                    });
                  },
                  activeTrackColor: itime_light_red,
                  activeColor: itime_main_color,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                'Ghim thông tin',
                style: TextStyle(
                  fontSize: itime_text_size_medium,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Transform.scale(
                scale: 1.2,
                child: Switch(
                  value: isComfirm,
                  onChanged: (value) {
                    setState(() {
                      isComfirm = value;
                      print(isComfirm);
                    });
                  },
                  activeTrackColor: itime_light_red,
                  activeColor: itime_main_color,
                ),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Yêu cầu xác nhận đã xem',
                    style: TextStyle(
                      fontSize: itime_text_size_medium,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      'Người xem sẽ được yêu cầu xác nhận đã xem thông tin',
                      style: TextStyle(
                        letterSpacing: 0.5,
                        fontSize: itime_text_size_medium - 1,
                        fontWeight: FontWeight.w500,
                        color: getColorFromHex('#BFBFBF'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
    // END WIDGET ATTACH INFORMATION AND CONFIRM

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        appBar: _appbarSection(),
        key: scaffoldKey,
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _informationTypeSection(),
            SizedBox(height: 10.0),
            _buttonAddAndShowSection(),
            SizedBox(height: 10.0),
            showAdvanced == false
                ? Text('')
                : Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: getColorFromHex("#E1E1E1"),
                          )),
                      child: Column(
                        children: <Widget>[
                          _selectAreaSection(),
                          _selectBranchSection(),
                          _selectDepartmentSection(),
                          _selectEmployeeSection(),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                  ),
            SizedBox(height: 10.0),
            _addImageDocumentSection(),
            SizedBox(height: 10.0),
            _addTitleSection(),
            SizedBox(height: 10.0),
            _addContentSection(),
            SizedBox(height: 10.0),
            _attachInfoAndConfirm(),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
