import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vao_ra/pages/pages.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:vao_ra/themes/custom.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeReadRule extends StatefulWidget {
  final detailsRule ;
  const ItimeReadRule({Key key, this.detailsRule}) : super(key: key);
  @override
  _ItimeReadRuleState createState() => _ItimeReadRuleState();
}

class _ItimeReadRuleState extends State<ItimeReadRule> {

  final repository = Repository();
  bool isComfirm = false;
  bool isChange = false;
  dynamic detailsRule;
  // Define object from library
  double scale = 0.0;
  // Define datetime
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailsRule= widget.detailsRule;
  }
  // sub function
  Future saveStatus() async {
    repository.r400InformationProvider.p400Information(409, {"id":detailsRule['id'],"Status":"1"});
    isChange =true;
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
                launchScreen(context, Routes.itimeEditRule);
              },
              child: Row(
                children: [
                  Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Chỉnh sửa nội quy này',
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
                    'Xóa nội quy này',
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
//            Navigator.pushReplacement(
//                context,
//                MaterialPageRoute(
//                    builder: (context) => ItimeBottomNavigation(
//                          tabPage: 1,
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

    Widget _confirmSection() {
      return  Row(
        children: [
          Transform.scale(
            scale: 1.2,
            child: Switch(
              value: isComfirm,

              onChanged: (value)  {
                if(!isComfirm)
                  setState(()  {
                    isComfirm = value;
                    saveStatus();
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
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  'Xác nhận đã xem đọc nội quy',
                  style: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  isComfirm ?
                  'Bạn đã xác nhận xem nội quy này':'Vui lòng xác nhận đã đọc nội quy.',
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
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: getColorFromHex("#FFFFFF"),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      detailsRule['Title'],
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: itime_text_size_medium,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Container(
                        height: 450,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: getColorFromHex("#F2F2F2"),
                          image: DecorationImage(
                            image: NetworkImage(
                              detailsRule['Image'],
                            ),
                            fit: BoxFit.fill,
                            alignment: Alignment(-.2, 0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            'Thứ hai 11-04-2021 07:00',
                            style: TextStyle(
                              color: getColorFromHex("#979797"),
                              fontSize: itime_text_size_medium,
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            'Giám đốc: Lê Hồng Phương',
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
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                alignment: Alignment.center,
                child: Text(detailsRule['Description'] ,style: TextStyle(
                  fontSize: itime_text_size_medium,
                  fontWeight: FontWeight.w700,
                ),),
              ),
            ),
            SizedBox(height: 10.0),
            // _confirmSection(),
            // SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
