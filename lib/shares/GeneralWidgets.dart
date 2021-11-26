import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vao_ra/models/OrdinalSales.dart';
import 'package:vao_ra/shares/GeneralSizes.dart';
import 'package:vao_ra/shares/GeneralStrings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../shares/GeneralColors.dart';

Widget spinKitCircleLoading(Color colors) {
  return SpinKitCircle(color: colors);
}

Widget text(var text,
    {var fontSize = itime_text_size_medium,
    textColor = t5TextColorSecondary,
    var fontFamily = fontRegular,
    var isCentered = false,
    var maxLine = 1,
    var fontWeight,
    var latterSpacing = 0.25}) {
  return Text(text,
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
      maxLines: maxLine,
      style: TextStyle(
          fontFamily: fontFamily,
          fontSize: fontSize,
          color: textColor,
          height: 1.5,
          fontWeight: fontWeight,
          letterSpacing: latterSpacing));
}

showToast(BuildContext aContext, String caption) {
  Scaffold.of(aContext).showSnackBar(SnackBar(
      content: text(caption,
          textColor: itime_white_color,
          fontSize: itime_text_size_medium,
          isCentered: false)));
}

BoxDecoration boxDecoration(
    {double radius,
    Color color = Colors.transparent,
    Color bgColor = itime_white_color,
    var showShadow = false}) {
  return BoxDecoration(
      //gradient: LinearGradient(colors: [bgColor, whiteColor]),
      color: bgColor,
      boxShadow: showShadow
          ? [BoxShadow(color: t5ShadowColor, blurRadius: 10, spreadRadius: 2)]
          : [BoxShadow(color: Colors.transparent)],
      border: Border.all(color: color),
      borderRadius: BorderRadius.all(Radius.circular(radius)));
}

class EditText extends StatefulWidget {
  var isPassword;
  var isSecure;
  var fontSize;
  var textColor;
  var fontFamily;
  var text;
  var hint;
  var maxLine;
  var isEnable;
  var isReadOnly;
  TextEditingController mController;

  VoidCallback onPressed;

  EditText(
      {var this.fontSize = itime_text_size_medium,
      var this.textColor = t5TextColorSecondary,
      var this.fontFamily = fontRegular,
      var this.isPassword = true,
      var this.hint = "",
      var this.isSecure = false,
      var this.text = "",
      var this.mController,
      var this.isEnable,
      var this.isReadOnly,
      var this.maxLine = 1});

  @override
  State<StatefulWidget> createState() {
    return EditTextState();
  }
}

class EditTextState extends State<EditText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.mController,
      obscureText: widget.isPassword,
      style:
          TextStyle(fontSize: itime_text_size_medium, fontFamily: fontAndika),
      enabled: widget.isEnable,
      maxLines: widget.maxLine,
      readOnly: widget.isReadOnly,
      decoration: InputDecoration(
        suffixIcon: widget.isSecure
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.isPassword = !widget.isPassword;
                  });
                },
                child: new Icon(
                  widget.isPassword ? Icons.visibility : Icons.visibility_off,
                  color:
                      widget.isPassword ? itime_main_color : itime_main_color,
                ),
              )
            : null,
        contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
        hintText: widget.hint,
        hintStyle: TextStyle(color: itime_hint_color),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: t5ViewColor, width: 0.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(color: t5ViewColor, width: 0.0),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    return null;
  }
}

TextFormField editTextStyle(var hintText, {isPassword = true}) {
  return TextFormField(
    style: TextStyle(fontSize: itime_text_size_medium, fontFamily: fontRegular),
    obscureText: isPassword,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.fromLTRB(16, 10, 16, 10),
      hintText: hintText,
      hintStyle: TextStyle(color: itime_main_color),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: t5ViewColor, width: 0.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: t5ViewColor, width: 0.0),
      ),
    ),
  );
}

Widget checkbox(String title, bool boolValue) {
  return Row(
    children: <Widget>[
      Text(title),
      Checkbox(
        activeColor: itime_main_color,
        value: boolValue,
        onChanged: (bool value) {
          boolValue = value;
        },
      )
    ],
  );
}

//////////////////////////////////////////////////////////////////////////////
Widget boxInfoAndRule({String title, String subtitle ,String image,String status,BuildContext context}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0, top:1.0, bottom: 1.0),
    child: Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: getColorFromHex("#FFFFFF"),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: image== null ?Center(
                  child:spinKitCircleLoading(itime_main_color) ,
                ):
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.white,
                  backgroundImage:NetworkImage(
                      image,
                  ),
                ),
//                Padding(
//                  padding: const EdgeInsets.only(right: 5.0),
//                  child: Container(
//                    width: 60,
//                    height: 60,
//                    decoration: BoxDecoration(
//                      color: Colors.red,
//                      borderRadius: BorderRadius.circular(50.0),
//                    ),
//                  ),
//                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.only(left: 5.0, top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title.length > 50 ? title.substring(0, 60) : title,
                            style: TextStyle(
                              fontSize: itime_text_size_normal - 5,
                                fontWeight: status == '1' ? FontWeight.w500:FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Text(
                            subtitle.length>35? subtitle.toString().substring(0,35)+'...':
                            '${subtitle.toString()}',
                            // overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: itime_text_size_medium - 3,
                              color: getColorFromHex('#B6B6B6'),
                                fontWeight: status == '1' ? FontWeight.w400:FontWeight.bold,
                            ),
                            // maxLines: 1,
                            // softWrap: false,
                          ),
                        ],
                      ),
//                      Container(
//                        child: Text(
//                          '${time.toString()}',
//                          textDirection: TextDirection.rtl,
//                        ),
//                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
////////////////////////////////////////////////////////////////////////////

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

class GroupedFillColorBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedFillColorBarChart(this.seriesList, {this.animate});

  factory GroupedFillColorBarChart.withSampleData() {
    return new GroupedFillColorBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.
  factory GroupedFillColorBarChart.withRandomData() {
    return new GroupedFillColorBarChart(_createRandomData());
  }

  /// Create random data.
  static List<charts.Series<OrdinalSales, String>> _createRandomData() {
    final random = new Random();

    final desktopSalesData = [
      new OrdinalSales('2014', random.nextInt(100)),
      new OrdinalSales('2015', random.nextInt(100)),
      new OrdinalSales('2016', random.nextInt(100)),
      new OrdinalSales('2017', random.nextInt(100)),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', random.nextInt(100)),
      new OrdinalSales('2015', random.nextInt(100)),
      new OrdinalSales('2016', random.nextInt(100)),
      new OrdinalSales('2017', random.nextInt(100)),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', random.nextInt(100)),
      new OrdinalSales('2015', random.nextInt(100)),
      new OrdinalSales('2016', random.nextInt(100)),
      new OrdinalSales('2017', random.nextInt(100)),
    ];

    return [
      // Blue bars with a lighter center color.
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      ),
      // Solid red bars. Fill color will default to the series color if no
      // fillColorFn is configured.
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      ),
      // Hollow green bars.
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.transparent,
      ),
    ];
  }
  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      // Configure a stroke width to enable borders on the bars.
      defaultRenderer: new charts.BarRendererConfig(
          groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      // Blue bars with a lighter center color.
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      ),
      // Solid red bars. Fill color will default to the series color if no
      // fillColorFn is configured.
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (OrdinalSales sales, _) => sales.year,
      ),
      // Hollow green bars.
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.transparent,
      ),
    ];
  }
}