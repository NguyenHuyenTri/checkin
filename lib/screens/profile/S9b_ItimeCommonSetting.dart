import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vao_ra/blocs/authentication/authentication.dart';
import 'package:vao_ra/blocs/lang/select_language_notifier.dart';
import 'package:vao_ra/helpers/dioultibaohq.dart';
import 'package:vao_ra/models/LanguageModel.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:vao_ra/pages/root/root_page.i18n.dart';

class ItimeCommonSetting extends StatefulWidget {
  @override
  _ItimeCommonSettingState createState() => _ItimeCommonSettingState();
}

class _ItimeCommonSettingState extends State<ItimeCommonSetting> {
  // Get list from future
  AuthenticationBloc authBloc;

  // Get list model

  // Define base data type
  String isLanguage;

  // Define object from library
  SharedPreferences preferences;

  // Define datetime

  // sub function
  void _handleLogout() async {
    await DioUtilBaohq.deleteToken();
    authBloc.add(UserLoggedOut());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthenticationBloc>(context);

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
                'Cài đặt',
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

    Widget _showSelectLanguage() {
      showDialog(
          context: context,
          builder: (context) {
            final _selectLanguage =
                Provider.of<SelectLanguageNotifier>(context);

            return AlertDialog(
              title: Text('Chọn ngôn ngữ'),
              content: Container(
                height: 150,
                child: Column(
                  children: languages
                      .map((e) => RadioListTile(
                          title: Text(e),
                          value: e,
                          groupValue: _selectLanguage.currentLang,
                          onChanged: (value) async {
                            preferences = await SharedPreferences.getInstance();
                            await preferences.setString("language", value);
                            setState(() {
                              _selectLanguage.updateLanguage(value);
                              isLanguage = preferences.getString("language");
                              if (isLanguage == 'Tiếng việt' ||
                                  isLanguage == 'Vietnamese') {
                                print('tieng viet');
                                Navigator.of(context).pop();
                              } else if (isLanguage == 'Tiếng anh' ||
                                  isLanguage == 'English') {
                                print('tieng anh');
                                Navigator.of(context).pop();
                              }
                            });
                          }))
                      .toList(),
                ),
              ),
            );
          });
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
                // padding: const EdgeInsets.only(
                //     left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
                decoration: BoxDecoration(
                  color: getColorFromHex("#FFFFFF"),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _showSelectLanguage();
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 15.0, bottom: 10.0),
                        decoration: BoxDecoration(
                          // color: getColorFromHex("#FFFF00"),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    color: itime_main_color,
                                    size: 25,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Ngôn ngữ'.i18n,
                                    style: TextStyle(
                                      fontSize: itime_text_size_medium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
//                                Text(
//                                  '${isLanguage.toString()}'
//                                      .i18n,
//                                  style: TextStyle(
//                                    fontSize: itime_text_size_medium,
//                                    color: getColorFromHex("#A1A1A1"),
//                                  ),
//                                ),
                                  SizedBox(width: 5.0),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: getColorFromHex("#A1A1A1"),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                    GestureDetector(
                      onTap: () {
                        launchScreen(context, Routes.itimeAlertSetting);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 10.0, bottom: 15.0),
                        decoration: BoxDecoration(
                          // color: getColorFromHex("#FFFF00"),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.notifications,
                                    color: getColorFromHex("#EDA200"),
                                    size: 25,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Cài đặt cảnh báo'.i18n,
                                    style: TextStyle(
                                      fontSize: itime_text_size_medium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: getColorFromHex("#A1A1A1"),
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: getColorFromHex("#FFFFFF"),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Cài đặt lưu trữ'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: itime_text_size_medium - 2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Xóa dữ liệu tạm'),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Text(
                            'Xóa dữ liệu hình ảnh lưu trên máy của bạn khi vào/ra ca',
                            style: TextStyle(
                              fontSize: itime_text_size_medium - 3,
                              color: getColorFromHex("#A1A1A1"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                _handleLogout();
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 15.0, bottom: 15.0),
                  decoration: BoxDecoration(
                    color: getColorFromHex("#FFFFFF"),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'Đăng xuất tài khoản',
                      style: TextStyle(
                        fontSize: itime_text_size_medium,
                        color: itime_main_color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
