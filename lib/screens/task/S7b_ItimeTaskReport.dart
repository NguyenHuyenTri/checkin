import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vao_ra/models/TabBarReport.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../models/models.dart';
import '../../pages/pages.dart';
import '../../shares/shares.dart';
import '../screens.dart';

class ItimeTaskReport extends StatefulWidget {
  @override
  _ItimeTaskReportState createState() => _ItimeTaskReportState();
}

class _ItimeTaskReportState extends State<ItimeTaskReport> {
  // Get list from future

  // Get list model
  List<TabBarReport> choices = <TabBarReport>[
    TabBarReport(index: 0, title: 'Tổng quát'),
    TabBarReport(index: 1, title: 'Chi tiết'),
    TabBarReport(index: 2, title: 'Xếp hạng'),
  ];

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
        centerTitle: true,
        backgroundColor: iconColorPrimary,
        leading: Container(
          padding: const EdgeInsets.only(top: 10.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: itime_black,
              size: 25,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Center(
                child: Text(
                  'Báo cáo công việc',
                  style: TextStyle(
                    color: appTextColorPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: itime_text_size_normal + 2,
                    fontFamily: 'OpenSans',
                  ),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 60),
          child: Column(
            children: [
              Divider(
                color: getColorFromHex("#DDDDDD"),
                thickness: 2,
              ),
              Container(
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(width: 3.0, color: itime_main_color),
                    insets: EdgeInsets.symmetric(horizontal: 5.0),
                  ),
                  unselectedLabelColor: Colors.black26,
                  indicatorColor: itime_main_color,
                  labelColor: itime_main_color,
                  labelStyle: TextStyle(
                    fontSize: itime_text_size_medium,
                    fontWeight: FontWeight.w500,
                    fontFamily: fontAndika,
                  ),
                  isScrollable: true,
                  tabs: choices.map<Widget>((TabBarReport tabBarReport) {
                    return Container(
                      width: 80.0,
                      child: Tab(
                        text: tabBarReport.title,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }
    // END WIDGET APPBAR SECTION

    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
            appBarTheme: AppBarTheme(
              elevation: 0, // This removes the shadow from all App Bars.
            ),
            fontFamily: 'Andika',
            visualDensity: VisualDensity.adaptivePlatformDensity,
            unselectedWidgetColor: itime_main_color,
            cursorColor: itime_main_color,
            accentColor: itime_main_color,
            primaryColor: itime_main_color,
            splashColor: itime_main_color,
            pageTransitionsTheme: PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder()
            })),
        supportedLocales: [
          const Locale('vi', "VN"),
          const Locale('en', "US"),
        ],
        home: DefaultTabController(
          length: choices.length,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: itime_main_background,
              appBar: _appbarSection(),
              body: TabBarView(
                children: choices.map((TabBarReport choice) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 10.0),
                    child: ChoicePage(
                      choice: choice,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ChoicePage extends StatelessWidget {
  const ChoicePage({Key key, this.choice}) : super(key: key);
  final TabBarReport choice;

  @override
  Widget build(BuildContext context) {
    if (choice.index == 0) {
      return GeneralTaskReport();
    } else if (choice.index == 1) {
      return DetailTaskReport();
    } else if (choice.index == 2) {
      return RankTaskReport();
    }
  }
}
