import 'package:flutter/material.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/screens/screens.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';

class ItimeProfileScreen extends StatefulWidget {
  ItimeProfileScreen({Key key, this.tabController,this.update}) : super(key: key);

  TabController tabController;
  final update;
  @override
  _ItimeProfileScreenState createState() => _ItimeProfileScreenState();
}

class _ItimeProfileScreenState extends State<ItimeProfileScreen> {

  dynamic profiles;
  @override
  Widget build(BuildContext context) {


    final ItimeProfileScreen args =
        ModalRoute.of(context).settings.arguments;
    // RESULT DATA PUSH PROFILES

    if(args!=null){
      profiles = args.update;
      print(profiles.toString()+'ok');
    }


    return WillPopScope(
      onWillPop: () async=> false,
      child: Scaffold(

        backgroundColor: itime_main_background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: iconColorPrimary,
          title: Text(
            'Quản lý tài khoản',
            style: TextStyle(
              color: appTextColorPrimary,
              fontSize: itime_text_size_normal + 2,
              fontWeight: FontWeight.w600,
            ),
          ),

          actions: [
            InkWell(
              onTap: (){
                launchScreen(context, Routes.itimeCommonSetting);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 25.0),
                child: Center(
                  child: Icon(Icons.settings, size: 25, color: itime_black,),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            ItimeProfileMain(),
          ],
        ),
      ),
    );
  }
}
