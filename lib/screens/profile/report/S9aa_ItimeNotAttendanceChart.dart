import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:vao_ra/models/OrdinalSales.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeNotAttendanceChart extends StatefulWidget {
  @override
  _ItimeNotAttendanceChartState createState() =>
      _ItimeNotAttendanceChartState();
}

class _ItimeNotAttendanceChartState extends State<ItimeNotAttendanceChart> {
  @override
  Widget build(BuildContext context) {
//    Widget chartContainer = Column(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: [Text('Chart Viewer')],
//    );

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
                'Chấm công',
                style: TextStyle(
                  color: appTextColorPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: itime_text_size_normal + 2,
                ),
              ),
            ),
          ],
        ),
      );
    }
    // END WIDGET APPBAR SECTION

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        appBar: _appbarSection(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: GroupedFillColorBarChart.withSampleData(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
