
import 'package:flutter/material.dart';
import 'package:vao_ra/blocs/b600_announcement_bloc.dart';
import 'package:vao_ra/repositories/repositories.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';


import 'package:flutter/material.Dart';
import 'package:flutter/rendering.Dart';

import '../../main.dart';

class ItimeDetailNotification extends StatefulWidget {
  final  detailsNotification;
  final String FullName;
  final String CompnayName;
  const ItimeDetailNotification({Key key, this.detailsNotification, this.FullName, this.CompnayName}) : super(key: key);
  @override
  _ItimeDetailNotificationState createState() =>
      _ItimeDetailNotificationState();
}
class _ItimeDetailNotificationState extends State<ItimeDetailNotification> {
  final announcementBloc = new AnnouncementBloc();
  final repository = Repository();
  dynamic detailsNotification;
  bool isChange = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    detailsNotification =widget.detailsNotification;
    if(widget.detailsNotification['Status']=='0'){
      isChange =true;
      repository.r600AnnouncementProvider.p600Announcement(609, {"id":widget.detailsNotification['id'],"Status":"1"});
    }

}
  // Define base data type

  // Define object from library

  // Define datetime

  Future saveStatus() async {

  }

  @override
  Widget build(BuildContext context) {



    // WIDGET SCREENSHOT SECTION
    Widget _alertScreenshotSection() {
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
                      Text('Thông báo',
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
                    Text('Bạn muốn chụp màn hình trang này và lưu vào máy'),
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
                        Navigator.of(context, rootNavigator: true).pop();
                      },
                      child: Container(
                        width: 120,
                        decoration: boxDecoration(bgColor: itime_main_color),
                        padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                        child: Center(
                            child: text("Đồng ý",
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
    // END WIDGET SCREENSHOT SECTION

    // WIDGET APPBAR SECTION
    Widget _appbarSection() {
      return AppBar(
        backgroundColor: iconColorPrimary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: itime_black,
            size: 25,
          ),
          onPressed: () {
            Navigator.pop(context,isChange);
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Chi tiết',
                style: TextStyle(
                  color: appTextColorPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: itime_text_size_normal,
                ),
              ),
            ),
          ],
        ),
//        actions: [
//          InkWell(
//            onTap: () {
//              showDialog(
//                context: context,
//                builder: (BuildContext context) {
//                  return _alertScreenshotSection();
//                },
//              );
//            },
//            child: Padding(
//              padding: const EdgeInsets.only(right: 10.0),
//              child: Center(
//                child: Icon(
//                  Icons.picture_in_picture,
//                  color: itime_main_color,
//                ),
//              ),
//            ),
//          ),
//        ],
      );
    }
    // END WIDGET APPBAR SECTION

    // WIDGET DETAIL INFORMATION BOX FIRST
    Widget _detailInformationBoxFirst() {
      return Padding(
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
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                 child: Text(widget.CompnayName,textAlign: TextAlign.center,style: TextStyle(color:itime_main_color .withOpacity(0.9),fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Nhân viên',style: TextStyle(color: iconColorSecondary,fontSize: 15),),
                    Text(widget.FullName.toUpperCase(),style: TextStyle(color: appSecondaryBackgroundColor,fontSize: 15,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Chi nhánh',style: TextStyle(color: iconColorSecondary,fontSize: 15),),
                    Text('Đà Nẵng',style: TextStyle(color: appSecondaryBackgroundColor,fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              SizedBox(height: 10.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Phòng ban',style: TextStyle(color: iconColorSecondary,fontSize: 15),),
                    Text('Phòng Tài Chính',style: TextStyle(color: appSecondaryBackgroundColor,fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Loại thông báo',style: TextStyle(color: iconColorSecondary,fontSize: 15),),
                    Text('Thông báo lương',style: TextStyle(color: appSecondaryBackgroundColor,fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                ),
              ),

              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Ngày gửi',style: TextStyle(color: iconColorSecondary,fontSize: 15),),
                    Text('06/04/2021 18:32:39',style: TextStyle(color: appSecondaryBackgroundColor,fontSize: 15,fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Divider(height: 1,thickness: 1.5,),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text('Nội dung',style: TextStyle(color: iconColorSecondary,fontSize: 16,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                    alignment: Alignment.centerLeft,
                   child: Text(widget.detailsNotification['Content'],textAlign: TextAlign.left,style: TextStyle(color: iconColorSecondary,fontSize: 16),),
                ),
              ),
              SizedBox(height: 15.0),
              Divider(height: 1,thickness: 1.5,),
              SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Phòng tài chính',style: TextStyle(color: iconColorSecondary,fontSize: 16,fontWeight: FontWeight.bold),),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
            ],
          ),
        ),
      );
    }
    // WIDGET DETAIL INFORMATION BOX FIRST



    return Scaffold(
      backgroundColor: itime_main_background,
      appBar: _appbarSection(),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 10.0),
          _detailInformationBoxFirst(),
          SizedBox(height: 10.0),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }

  void dispose() {
    announcementBloc.dispose();
    // TODO: implement dispose
    super.dispose();
  }


}
