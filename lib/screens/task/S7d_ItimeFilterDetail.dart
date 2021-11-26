import 'package:flutter/material.dart';
import 'package:vao_ra/pages/pages.dart';
import 'package:vao_ra/shares/CheckboxGroup.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeFilterDetail extends StatefulWidget {
  @override
  _ItimeFilterDetailState createState() => _ItimeFilterDetailState();
}

class _ItimeFilterDetailState extends State<ItimeFilterDetail> {
  // Get list from future

  // Get list model
  List<String> _checked = [];

  // Define base data type

  // Define object from library

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
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Lọc',
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
          Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: Visibility(
              visible: false,
              child: IconButton(
                icon: Icon(
                  Icons.more_vert,
                  color: itime_main_color,
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      );
    }
    // END WIDGET APPBAR SECTION

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: _appbarSection(),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: EdgeInsets.only(left: 10.0, top: 10.0),
                    color: getColorFromHex("#EBEBEB"),
                    height: MediaQuery.of(context).size.height,
                    child: Text(
                      'Phòng ban',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: itime_text_size_medium,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: getColorFromHex("#FFFFFF"),
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: <Widget>[
                        CheckboxGroup(
                          labels: <String>[
                            "Giám đốc",
                            "Kỹ thuật",
                            "Thiết kế",
                            "Marketing",
                            "Tiếp thị",
                            "Kinh doanh",
                            "Nhân sự",
                            "Kế toán",
                            "IT",
                          ],
                          checked: _checked,
                          onChange: (bool isChecked, String label, int index) =>
                              print(
                                  "isChecked: $isChecked   label: $label  index: $index"),
                          onSelected: (List selected) => setState(() {
                            if (selected.length > 1) {
                              selected.removeAt(0);
                              print('selected length  ${selected.length}');
                            } else {
                              print("only one");
                            }
                            _checked = selected;
                          }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: Colors.black,
                    height: 50,
                    child: Center(
                      child: Text(
                        'HỦY',
                        style: TextStyle(
                          color: getColorFromHex("#FFFFFF"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    color: itime_main_color,
                    height: 50,
                    child: Center(
                      child: Text(
                        'LỌC',
                        style: TextStyle(
                          color: getColorFromHex("#FFFFFF"),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
