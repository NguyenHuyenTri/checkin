import 'package:flutter/material.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeEditRule extends StatefulWidget {
  @override
  _ItimeEditRuleState createState() => _ItimeEditRuleState();
}

class _ItimeEditRuleState extends State<ItimeEditRule> {
  // Get list from future

  // Get list model

  // Define base data type
  bool isDisplay = false;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime

  // sub function

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
//        title: Center(
//          child: Text(
//            'Nội quy',
//            style: TextStyle(
//              color: appTextColorPrimary,
//              fontWeight: FontWeight.w600,
//              fontSize: itime_text_size_normal + 2,
//            ),
//          ),
//        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Nội quy',
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
                content: Text('Chỉnh sửa nội quy thành công!',
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

    // WIDGET DISPLAY OR HIDE SECTION
    Widget _displayOrHideSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Hiển thị/Ẩn',
                  style: TextStyle(
                    fontSize: itime_text_size_medium - 2,
                    color: getColorFromHex("#989898"),
                  ),
                ),
              ],
            ),
            Transform.scale(
              scale: 1.2,
              child: Switch(
                value: isDisplay,
                onChanged: (value) {
                  setState(() {
                    isDisplay = value;
                    print(isDisplay);
                  });
                },
                activeTrackColor: itime_light_red,
                activeColor: itime_main_color,
              ),
            ),
          ],
        ),
      );
    }
    // WIDGET DISPLAY OR HIDE SECTION

    // WIDGET SELECT IMAGE SECTION
    Widget _selectImageSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Hình ảnh',
                  style: TextStyle(
                    fontSize: itime_text_size_medium - 2,
                    color: getColorFromHex("#989898"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: getColorFromHex("#E9EBEC"),
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    color: getColorFromHex("#E9EBEC"),
                  )),
              child: Icon(
                Icons.add,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET SELECT IMAGE SECTION

    // WIDGET ADD DESCRIPTION SECTION
    Widget _addDescriptionSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Mô tả',
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
    // END WIDGET ADD DESCRIPTION SECTION

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

    // WIDGET ADD CONTENT SECTION
    Widget _addContentSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Chi tiết',
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

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        key: scaffoldKey,
        appBar: _appbarSection(),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.0),
            _addTitleSection(),
            SizedBox(height: 10.0),
            _displayOrHideSection(),
            SizedBox(height: 10.0),
            _selectImageSection(),
            SizedBox(height: 10.0),
            _addDescriptionSection(),
            SizedBox(height: 10.0),
            _addImageDocumentSection(),
            SizedBox(height: 10.0),
            _addContentSection(),
            20.height,
          ],
        ),
      ),
    );
  }
}
