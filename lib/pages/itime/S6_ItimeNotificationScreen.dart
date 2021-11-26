import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:vao_ra/blocs/b400_information_bloc.dart';
import 'package:vao_ra/blocs/b500_rule_bloc.dart';
import 'package:vao_ra/blocs/b600_announcement_bloc.dart';
import 'package:vao_ra/themes/custom.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../routes/router.gr.dart';
import '../../shares/shares.dart';

class ItimeNotificationScreen extends StatefulWidget {
  ItimeNotificationScreen({Key key, this.tabController}) : super(key: key);

  TabController tabController;

  @override
  _ItimeNotificationScreenState createState() =>
      _ItimeNotificationScreenState();
}

class _ItimeNotificationScreenState extends State<ItimeNotificationScreen>
    with SingleTickerProviderStateMixin {
  SharedPreferences preferences;
  TabController _cardController;

  //getList Screen Notification
  final announcementBloc = new AnnouncementBloc();
  final rulesBloc = RuleBloc();
  final infoBloc = InformationBloc();

  // Get list from future

  // Get list model

  // Define base data type
  int _currentSelection = 0;
  String idEmployee;
  String companyId;
  String nameEmployee;
  String companyName;

  dynamic _listUnreadNotification;
  dynamic _listNotification;
  dynamic _listInfo;
  dynamic _listRule;

  double width;
  double height;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime

  // sub function

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: 3);
    init();
  }

  init() async {
    preferences = await SharedPreferences.getInstance();
    Map<String, dynamic> mapEmployee =
        jsonDecode(preferences.getString("user"));
    Map<String, dynamic> mapCompany =
        jsonDecode(preferences.getString("company"));
    idEmployee = mapEmployee['id'];
    companyId = mapCompany['id'];
    nameEmployee = mapEmployee['Fullname'];
    companyName = mapCompany['CompanyName'];

    announcementBloc.announcementStream607.listen(_handleListNotification);

    infoBloc.informationStream407.listen(_handleListInformation);

    rulesBloc.ruleStream507.listen(_handleListRule);

    _getData();
  }

  _getData() {
    rulesBloc.callWhat507({"IdCompany": companyId});
    infoBloc.callWhat407({
      "IdEmployee": idEmployee,
      "IdCompany": companyId,
    });

    announcementBloc
        .callWhat608({"IdEmployee": idEmployee, "IdCompany": companyId});
    announcementBloc.announcementStream608.listen(_handleUnreadNotification);

    announcementBloc
        .callWhat607({"IdEmployee": idEmployee, "IdCompany": companyId});
  }

  _handleUnreadNotification(event) async {
    setState(() {
      _listUnreadNotification = announcementBloc.listAnnouncement608;
    });
  }

  _handleListNotification(event) async {
    setState(() {
      _listNotification = announcementBloc.listAnnouncement607;
    });
  }

  _handleListInformation(event) async {
    setState(() {
      _listInfo = infoBloc.listInformation407;
    });
  }

  _handleListRule(event) async {
    setState(() {
      _listRule = rulesBloc.listRule507;
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  _onRefresh() async {
    try {
      _getData();
      _refreshController.refreshCompleted();
    } catch (e) {
      _refreshController.refreshFailed();
      // _showToast(e.message.toString(), 2);
    }
  }

  @override
  Widget build(BuildContext context) {
    //WIDGET NOTIFICATION
    Widget notification(dynamic listNotification) {
      final action1 = CustomTheme(
        child: CupertinoActionSheet(
          title: Text(
            '+84984544733 gửi yêu cầu chỉnh sửa giờ công (01-10-2020) cho bạn',
            style: boldTextStyle(size: 15, fontFamily: fontAndika),
          ),
          message: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 20,
                    color: getColorFromHex("#636363"),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Đánh dấu là chưa đọc',
                    style: TextStyle(
                      fontFamily: fontAndika,
                      fontSize: itime_text_size_medium,
                      color: getColorFromHex("#636363"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 20,
                    color: itime_main_color,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Xóa thông báo này',
                    style: TextStyle(
                      fontFamily: fontAndika,
                      fontSize: itime_text_size_medium,
                      color: itime_main_color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Hủy',
                style: primaryTextStyle(color: redColor, size: 18),
              )),
        ),
      );
      return WillPopScope(
        onWillPop: () async => false,
        child: SingleChildScrollView(
          child: listNotification.length != 0
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listNotification.length,
                  itemBuilder: (context, index) {
                    print(listNotification[index]['Status']);
                    return GestureDetector(
                      onLongPress: () {
                        showCupertinoModalPopup(
                            context: context,
                            useRootNavigator: false,
                            builder: (BuildContext context) => action1);
                      },
                      onTap: () async {
                        await ExtendedNavigator.of(
                          context,
                          rootRouter: true,
                        )
                            .push(Routes.itimeDetailNotification,
                                arguments: ItimeDetailNotificationArguments(
                                    FullName: nameEmployee,
                                    CompnayName: companyName,
                                    detailsNotification:
                                        listNotification[index]))
                            .then((val) {
                          if (val == true) {
                            int countNotification = int.parse(
                                _listUnreadNotification['countNotification']
                                    ['data'][0]['CountNotification']);

                            setState(() {
                              _listNotification[index]['Status'] = '1';
                              if (countNotification > 0) {
                                setState(() {
                                  _listUnreadNotification['countNotification']
                                          ['data'][0]['CountNotification'] =
                                      (countNotification - 1).toString();
                                });
                              }
                            });
                            announcementBloc.callWhat608({
                              "IdEmployee": idEmployee,
                              "IdCompany": companyId
                            });
                            announcementBloc.callWhat607({
                              "IdEmployee": idEmployee,
                              "IdCompany": companyId
                            });
                          }
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 1.0, bottom: 1.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: getColorFromHex("#FFFFFF"),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            'https://izimoneiii.web.app/assets/images/logo-admin.png'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5.0),
//                              height: 80,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            listNotification[index]['Title']
                                                        .length >
                                                    40
                                                ? listNotification[index]
                                                            ['Title']
                                                        .substring(0, 40) +
                                                    '...'
                                                : listNotification[index]
                                                    ['Title'],
                                            style: TextStyle(
                                              fontSize:
                                                  itime_text_size_normal - 5,
                                              fontWeight:
                                                  listNotification[index]
                                                              ['Status'] ==
                                                          '1'
                                                      ? FontWeight.w400
                                                      : FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            listNotification[index]['Content']
                                                        .length >
                                                    90
                                                ? listNotification[index]
                                                            ['Content']
                                                        .substring(0, 90) +
                                                    '...'
                                                : listNotification[index]
                                                    ['Content'],
                                            style: TextStyle(
                                              fontSize:
                                                  itime_text_size_medium - 3,
                                              color: getColorFromHex('#B6B6B6'),
                                              fontWeight:
                                                  listNotification[index]
                                                              ['Status'] ==
                                                          '1'
                                                      ? FontWeight.normal
                                                      : FontWeight.bold,
                                            ),
                                            maxLines: 2,
                                          ),
                                          Text(
                                            '20 Th 10 18:32',
                                            style: TextStyle(
                                              fontSize:
                                                  itime_text_size_medium - 3,
                                              color: getColorFromHex('#B6B6B6'),
                                              fontWeight:
                                                  listNotification[index]
                                                              ['Status'] ==
                                                          '1'
                                                      ? FontWeight.w400
                                                      : FontWeight.bold,
                                            ),
                                          ),
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
                    );
                  })
              : CircularProgressIndicator(),
        ),
      );
    }
    //END WIDGET NOTIFICATION

    // WIDGET INFORMATION
    Widget information(dynamic listInfo) {
      return listInfo.length != 0
          ? SingleChildScrollView(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listInfo.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        await ExtendedNavigator.of(
                          context,
                          rootRouter: true,
                        )
                            .push(Routes.itimeReadInfo,
                                arguments: ItimeReadInfoArguments(
                                    detailsInfo: listInfo[index]))
                            .then((val) {
                          if (val) {
                            int countInfo = int.parse(
                                _listUnreadNotification['countInfomation']
                                    ['data'][0]['CountInfomation']);
                            setState(() {
                              _listInfo[index]['Status'] = '1';
                              if (countInfo > 0) {
                                setState(() {
                                  _listUnreadNotification['countInfomation']
                                          ['data'][0]['CountInfomation'] =
                                      (countInfo - 1).toString();
                                });
                              }
                            });
                            infoBloc.callWhat407({
                              "IdEmployee": idEmployee,
                              "IdCompany": companyId,
                            });
                            announcementBloc.callWhat608({
                              "IdEmployee": idEmployee,
                              "IdCompany": companyId
                            });
                          }
                        });
                      },
                      child: boxInfoAndRule(
                        title: listInfo[index]['Title'],
                        subtitle: listInfo[index]['Content'],
//                    time: '11:30',
                        image:
                            'https://izimoneiii.web.app/assets/images/logo-admin.png',
                        status: listInfo[index]['Status'],
                      ),
                    );
                  }))
          : Center(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Bạn đang khả dụng hoặc chưa có thông báo mới.'),
                SpinKitRipple(
                  color: itime_main_color,
                  size: 60,
                ),
              ],
            ));
    }
    //END WIDGET INFORMATION

    Widget rule(dynamic listRule) {
      final action1 = CustomTheme(
        child: CupertinoActionSheet(
          title: Text(
            '+84984544733 gửi yêu cầu chỉnh sửa giờ công (01-10-2020) cho bạn',
            style: boldTextStyle(size: 15, fontFamily: fontAndika),
          ),
          message: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 1,
              ),
              Row(
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 20,
                    color: getColorFromHex("#636363"),
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Đánh dấu là chưa đọc',
                    style: TextStyle(
                      fontFamily: fontAndika,
                      fontSize: itime_text_size_medium,
                      color: getColorFromHex("#636363"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Row(
                children: [
                  Icon(
                    Icons.warning,
                    size: 20,
                    color: itime_main_color,
                  ),
                  SizedBox(width: 5.0),
                  Text(
                    'Xóa thông báo này',
                    style: TextStyle(
                      fontFamily: fontAndika,
                      fontSize: itime_text_size_medium,
                      color: itime_main_color,
                    ),
                  ),
                ],
              ),
            ],
          ),
          cancelButton: CupertinoActionSheetAction(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                'Hủy',
                style: primaryTextStyle(color: redColor, size: 18),
              )),
        ),
      );
      return SingleChildScrollView(
          child: listRule.length != 0
              ? ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: listRule.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        showCupertinoModalPopup(
                            context: context,
                            useRootNavigator: false,
                            builder: (BuildContext context) => action1);
                      },
                      onTap: () async {
                        await ExtendedNavigator.of(
                          context,
                          rootRouter: true,
                        )
                            .push(Routes.itimeReadRule,
                                arguments: ItimeReadRuleArguments(
                                  detailsRule: listRule[index],
                                ))
                            .then((val) {
                          if (val != null && val) {}
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 1.0, bottom: 1.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: getColorFromHex("#FFFFFF"),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: CircleAvatar(
                                        radius: 30.0,
                                        backgroundColor: Colors.orange,
                                        backgroundImage: NetworkImage(
                                            'https://izimoneiii.web.app/assets/images/logo-admin.png'),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 5.0),
//                              height: 80,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            listRule[index]['Title'].length > 50
                                                ? listRule[index]['Title']
                                                        .substring(0, 50) +
                                                    '...'
                                                : listRule[index]['Title'],
                                            style: TextStyle(
                                                fontSize:
                                                    itime_text_size_normal - 5,
                                                fontWeight: listRule[index]
                                                            ['Status'] ==
                                                        '1'
                                                    ? FontWeight.w400
                                                    : FontWeight.bold),
                                          ),
                                          Text(
                                            '20 Th 10 18:32',
                                            style: TextStyle(
                                                fontSize:
                                                    itime_text_size_medium - 3,
                                                color:
                                                    getColorFromHex('#B6B6B6'),
                                                fontWeight: listRule[index]
                                                            ['Status'] ==
                                                        '1'
                                                    ? FontWeight.w400
                                                    : FontWeight.bold),
                                          ),
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
                    );
                  })
              : Center(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Bạn đang khả dụng hoặc chưa có thông tin nào'),
                    SpinKitRipple(
                      color: itime_main_color,
                      size: 60,
                    ),
                  ],
                )));
    }
    // WIDGET RULE

    return Scaffold(
      // backgroundColor: Colors.deepOrangeAccent,
      body: SafeArea(
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final maxHeight = constraints.maxHeight;
            final maxWidth = constraints.maxWidth;
            this.height = maxHeight;
            this.width = maxWidth;
            final width = maxWidth;
            return Scaffold(
              backgroundColor: itime_main_background,
              body: DefaultTabController(
                length: 3,
                // child: Expanded(
                  child: Container(
                    // color: Colors.blue,
                    width: width,
                    height: height,
                    child: Column(
                      children:[Expanded(child:
                    SmartRefresher(
                      enablePullDown: true,
                      // enablePullUp: true,
                      header: WaterDropMaterialHeader(distance: 100),
                      footer: CustomFooter(
                        builder: (BuildContext context, LoadStatus mode) {
                          Widget body;
                          if (mode == LoadStatus.idle) {
                            body = Text(
                              "Pull up load more",
                              style: TextStyle(
                                color: Colors.black87,
                                // fontSize: fontSizeRefresh,
                              ),
                            );
                          } else if (mode == LoadStatus.loading) {
                            body = CupertinoActivityIndicator();
                          } else if (mode == LoadStatus.failed) {
                            body = Text(
                              "Load failed! Click retry!",
                              style: TextStyle(
                                color: Colors.black87,
                                // fontSize: fontSizeRefresh,
                              ),
                            );
                          } else if (mode == LoadStatus.canLoading) {
                            body = Text(
                              "Release to load more",
                              style: TextStyle(
                                color: Colors.black87,
                                // fontSize: fontSizeRefresh,
                              ),
                            );
                          } else {
                            body = Column(
                              children: <Widget>[
                                Text(
                                  "No more Data",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    // fontSize: fontSizeRefresh,
                                  ),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            );
                          }
                          return Container(
                            height: 25,
                            child: Center(child: body),
                          );
                        },
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      // onLoading: _onLoadingMore,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setPage(0);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 20.0),
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(30.0),
                                              bottomLeft:
                                                  Radius.circular(30.0)),
                                          color: _currentSelection == 0
                                              ? Colors.white
                                              : Colors.white38,
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                'Thông tin',
                                                style: TextStyle(
                                                  color: _currentSelection == 0
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                              SizedBox(width: 2.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0.0),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        _currentSelection == 0
                                                            ? getColorFromHex(
                                                                "#FF4E44")
                                                            : getColorFromHex(
                                                                "#ff8881"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      _listUnreadNotification !=
                                                              null
                                                          ? _listUnreadNotification[
                                                                      'countNotification']
                                                                  ['data'][0][
                                                              'CountNotification']
                                                          : '0',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setPage(1);
                                      },
                                      child: Container(
                                        height: 50,
                                        color: _currentSelection == 1
                                            ? Colors.white
                                            : Colors.white38,
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 5.0,
                                            bottom: 5.0,
                                            top: 5.0),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                'Thông báo',
                                                style: TextStyle(
                                                  color: _currentSelection == 1
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                              SizedBox(width: 2.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0.0),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        _currentSelection == 1
                                                            ? getColorFromHex(
                                                                "#FF4E44")
                                                            : getColorFromHex(
                                                                "#ff8881"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      _listUnreadNotification !=
                                                              null
                                                          ? _listUnreadNotification[
                                                                      'countInfomation']
                                                                  ['data'][0][
                                                              'CountInfomation']
                                                          : '0',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: GestureDetector(
                                      onTap: () {
                                        setPage(2);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(left: 20.0),
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(30.0),
                                              bottomRight:
                                                  Radius.circular(30.0)),
                                          color: _currentSelection == 2
                                              ? Colors.white
                                              : Colors.white38,
                                        ),
                                        child: Center(
                                          child: Row(
                                            children: [
                                              Text(
                                                'Nội quy',
                                                style: TextStyle(
                                                  color: _currentSelection == 2
                                                      ? Colors.black
                                                      : Colors.grey,
                                                ),
                                              ),
                                              SizedBox(width: 2.0),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0.0),
                                                child: Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        _currentSelection == 2
                                                            ? getColorFromHex(
                                                                "#FF4E44")
                                                            : getColorFromHex(
                                                                "#ff8881"),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      _listUnreadNotification !=
                                                              null
                                                          ? _listUnreadNotification[
                                                                      'countRule']
                                                                  ['data'][0]
                                                              ['CountRule']
                                                          : '0',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // screen[_currentSelection]
                          // List screen = [];
                          Expanded(
                            flex: _cardController.length,
                            child: TabBarView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: _cardController,
                              children: [
                                _listNotification != null
                                    ? notification(
                                        _listNotification,
                                      )
                                    : Center(
                                        child: SpinKitRipple(
                                        color: itime_main_color,
                                        size: 60,
                                      )),
                                _listInfo != null
                                    ? information(_listInfo)
                                    : Center(
                                        child: SpinKitRipple(
                                        color: itime_main_color,
                                        size: 60,
                                      )),
                                _listRule != null
                                    ? rule(_listRule)
                                    : Center(
                                        child: SpinKitRipple(
                                        color: itime_main_color,
                                        size: 60,
                                      ))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    ),
                      ]),
                  ),
                // ),
              ),
            );
          },
        ),
      ),
    );
  }

  void setPage(int index) {
    setState(() {
      _currentSelection = index;
      _cardController.index = index;
    });
    // switch (index) {
    //   case 0:
    //     announcementBloc.announcementStream607.listen(_handleListNotification);
    //     break;
    //   case 1:
    //     infoBloc.informationStream407.listen(_handleListInformation);
    //     break;
    // }
    // init();
  }

  void dispose() {
    _cardController.dispose();
    announcementBloc.dispose();
    rulesBloc.dispose();
    infoBloc.dispose();

    // TODO: implement dispose
    super.dispose();
  }
}
