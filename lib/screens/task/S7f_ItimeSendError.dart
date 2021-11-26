import 'package:flutter/material.dart';
import 'package:vao_ra/pages/pages.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeSendError extends StatefulWidget {
  @override
  _ItimeSendErrorState createState() => _ItimeSendErrorState();
}

class _ItimeSendErrorState extends State<ItimeSendError> {
  // Get list from future

  // Get list model

  // Define base data type

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
            Icons.clear,
            color: itime_black,
            size: 25,
          ),
          onPressed: () {
//            Navigator.pushReplacement(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => ItimeBottomNavigation(
//                          tabPage: 0,
//                        )));
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
                'Báo lỗi',
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
                content: Text('Gửi yêu cầu thành công!',
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

    // WIDGET ADD ERROR DESCRIPTION SECTION
    Widget _addErrorDescriptionSection() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Text(
                  'Mô tả',
                  style: TextStyle(
                    fontSize: itime_text_size_medium - 2,
                    color: getColorFromHex("#989898"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5.0),
            EditText(
              hint: 'Mô tả lỗi',
              isPassword: false,
              maxLine: 3,
              isReadOnly: true,
            ),
          ],
        ),
      );
    }
    // END WIDGET ADD DESCRIPTION SECTION

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
            _addErrorDescriptionSection(),
            SizedBox(height: 10.0),
            _selectImageSection(),
          ],
        ),
      ),
    );
  }
}
