import 'package:flutter/material.dart';

import 'dart:convert';
import '../../screens/screens.dart';

import '../../shares/shares.dart';

class ItimeTaskScreen extends StatefulWidget {
  ItimeTaskScreen({Key key, this.tabController}) : super(key: key);

  TabController tabController;
  @override
  _ItimeTaskScreenState createState() => _ItimeTaskScreenState();
}

class _ItimeTaskScreenState extends State<ItimeTaskScreen> {
  // Get list from future

  // Get list model

  // Define base data type

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime

  // sub function

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: itime_main_background,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 10.0),
          ItimeMainTask(),
        ],
      ),
    );
  }
}
