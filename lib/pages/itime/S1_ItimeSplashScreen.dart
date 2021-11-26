import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:vao_ra/pages/itime/S2_ItimeWalkThrough.dart';
import 'package:vao_ra/shares/GeneralColors.dart';

import '../../routes/router.gr.dart';
import '../../shares/GeneralWidgets.dart';
import '../../shares/GeneralImages.dart';
import '../../shares/GeneralBehaviors.dart';

/**
 * @author datnq
 * @Date: 28/01/2021
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 28/01/2021	DatNQ		  create splash screen
 */
class ItimeSplashScreen extends StatefulWidget {
  @override
  _ItimeSplashScreenState createState() => _ItimeSplashScreenState();
}

class _ItimeSplashScreenState extends State<ItimeSplashScreen> {

  // Get list from future

  // Get list model

  // Define base data type

  // Define object from library

  // Define datetime

  // sub function


  @override
  void initState() {
    super.initState();

  }

//  @override
//  void dispose() {
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        fontFamily: 'OpenSans',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage(itime_splash_image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.6,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    spinKitCircleLoading(itime_main_color),
                  ],
                ),
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
}