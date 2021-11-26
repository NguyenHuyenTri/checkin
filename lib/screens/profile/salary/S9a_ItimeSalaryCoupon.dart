import 'package:flutter/material.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeSalaryCoupon extends StatefulWidget {
  @override
  _ItimeSalaryCouponState createState() => _ItimeSalaryCouponState();
}

class _ItimeSalaryCouponState extends State<ItimeSalaryCoupon> {
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
                'Phiếu lương',
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

    // WIDGET INFORMATION HUMAN RESOURCE SECTION
    Widget _aboutInformationHRSection() {
      return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Table(
                border: TableBorder.all(
                  color: getColorFromHex("#C1C1C1"),
                ),
                children: [
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                      child: Center(child: Text('Mã NV')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text('NV10001')),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                      child: Center(
                        child: Text('Họ & Tên'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text('Nguyễn Huyền Trí'),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                      child: Center(
                        child: Text('Chức danh'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text('Nhân viên'),
                      ),
                    ),
                  ]),
                ]),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Table(
                border: TableBorder.all(
                  color: getColorFromHex("#C1C1C1"),
                ),
                children: [
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                      child: Center(child: Text('Lương đóng BHBB')),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text('11.000.000')),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                      child: Center(
                        child: Text('Ngày công đi làm'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text('15'),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                      child: Center(
                        child: Text('Ngày công chuẩn'),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                        child: Text('26'),
                      ),
                    ),
                  ]),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Text(
                  '(Thông tin của nhân sự)',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: getColorFromHex("#A1A1A1")),
                ),
              ),
            ),
          ),
        ],
      );
    }
    // END WIDGET INFORMATION HUMAN RESOURCE SECTION

    // WIDGET SALARY INCOME SECTION
    Widget _salaryIncomeSection() {
      return Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Table(
                border: TableBorder.all(
                  color: getColorFromHex("#C1C1C1"),
                ),
                children: [
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('STT'),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                      child: Text('Thu nhập'),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: getColorFromHex("#B1B1B1"),
                      ),
                      child: Text('Số tiền'),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text('1'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Lương chính'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text('8.000.000'),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text('2'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Tổng phụ cấp'),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text('6.000.000'),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '2.1',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Trách nhiệm',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '3.000.000',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '2.2',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Ăn trưa',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '1.500.000',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '2.3',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Điện thoại',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '1.000.000',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                  ]),
                  TableRow(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '2.4',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Xăng xe',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: getColorFromHex("#FFFFFF"),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        '500.000',
                        style: TextStyle(
                          color: getColorFromHex("#767676"),
                        ),
                      ),
                    ),
                  ]),
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Center(
                child: Text(
                  '(Thông tin về lương, thưởng, bảo hiểm và phụ cấp)',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: getColorFromHex("#A1A1A1")),
                ),
              ),
            ),
          ),
        ],
      );
    }
    // END WIDGET SALARY INCOME SECTION

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        appBar: _appbarSection(),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _aboutInformationHRSection(),
            _salaryIncomeSection(),
          ],
        ),
      ),
    );
  }
}
