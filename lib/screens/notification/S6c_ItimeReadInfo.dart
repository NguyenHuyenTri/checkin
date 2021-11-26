import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vao_ra/pages/pages.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/themes.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeReadInfo extends StatefulWidget {
  const ItimeReadInfo({Key key, this.detailsInfo}) : super(key: key);
  final detailsInfo;

  @override
  _ItimeReadInfoState createState() => _ItimeReadInfoState();
}

class _ItimeReadInfoState extends State<ItimeReadInfo> {
  final repository = Repository();
  bool isComfirm = false;
  bool isChange=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.detailsInfo);
    if(widget.detailsInfo['Status']=='0'){
      repository.r400InformationProvider.p400Information(409, {"id":widget.detailsInfo['id'],"Status":"1"});
      isChange =true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final action1 = CustomTheme(
      child: CupertinoActionSheet(
        message: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.check_circle_outline,
                  size: 20,
                  color: getColorFromHex("#636363"),
                ),
                SizedBox(width: 5.0),
                Text(
                  'Danh sách xác nhận đã xem',
                  style: TextStyle(
                    fontFamily: fontAndika,
                    fontSize: itime_text_size_medium,
                    color: getColorFromHex("#636363"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                launchScreen(context, Routes.itimeEditInfo);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Chỉnh sửa thông tin này',
                    style: TextStyle(
                      fontFamily: fontAndika,
                      fontSize: itime_text_size_medium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.restore_from_trash,
                    size: 20,
                    color: itime_main_color,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Xóa thông tin này',
                    style: TextStyle(
                      fontFamily: fontAndika,
                      fontSize: itime_text_size_medium,
                      color: itime_main_color,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 20,
                    color: itime_main_color,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Hủy',
                    style: TextStyle(
                      fontFamily: fontAndika,
                      fontSize: itime_text_size_medium,
                      color: itime_main_color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
            Navigator.pop(context, isChange);
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
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 5.0),
        //     child: IconButton(
        //       icon: Icon(
        //         Icons.more_vert,
        //         color: itime_main_color,
        //       ),
        //       onPressed: () {
        //         showCupertinoModalPopup(
        //             context: context,
        //             builder: (BuildContext context) => action1);
        //       },
        //     ),
        //   ),
        // ],
      );
    }
    // END WIDGET APPBAR SECTION

    // WIDGET READ INFORMATION
    Widget _readInformation() {
      return Column(
        children: <Widget>[
          // Information creater
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: getColorFromHex("#FFFFFF"),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(
      widget.detailsInfo['Title'],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: itime_text_size_medium,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          widget.detailsInfo['CreatAt'],
                          style: TextStyle(
                            color: getColorFromHex("#979797"),
                            fontSize: itime_text_size_medium,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          'Người tạo: Admin',
                          style: TextStyle(
                            color: getColorFromHex("#979797"),
                            fontSize: itime_text_size_medium,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    // END WIDGET READ INFORMATION

    // WIDGET SEND QUESTION
    Widget _sendQuestion() {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Container(
          decoration: BoxDecoration(
            color: getColorFromHex("#FFFFFF"),
//            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Text(
                          'Phản hồi',
                          style: TextStyle(
                            fontSize: itime_text_size_medium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.0),
                    EditText(
                      hint: 'Đặt câu hỏi hoặc phản hồi thông tin...',
                      isPassword: false,
                      isReadOnly: false,
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: 120,
                            decoration: BoxDecoration(color: itime_main_color),
                            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: Center(
                                child: text("Gửi",
                                    textColor: white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        appBar: _appbarSection(),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.0),
            _readInformation(),
            SizedBox(height: 10.0),
            // Information text field read only
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: getColorFromHex("#FFFFFF"),
            borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10.0),
                          Row(
                            children: [
                              Text(
                                'Nội dung',
                                style: TextStyle(
                                  fontSize: itime_text_size_medium,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            widget.detailsInfo['Content'],
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: iconColorSecondary, fontSize: 16),
                          ),
                          SizedBox(height: 10.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
//            SizedBox(height: 10.0),
//            _sendQuestion(),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
