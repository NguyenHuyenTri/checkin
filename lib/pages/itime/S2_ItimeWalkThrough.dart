import 'package:flutter/material.dart';
import 'package:vao_ra/routes/router.gr.dart';

import '../../shares/shares.dart';
import '../pages.dart';

/**
 * @author datnq
 * @Date: 30/01/2021
 *
 * Modification Logs
 * DATE   		AUTHOR 		DESCRIPTION
 * ------------------------------------
 * 30/01/2021	DatNQ		  create walk through screen
 */
class ItimeWalkThrough extends StatefulWidget {
  @override
  _ItimeWalkThroughState createState() => _ItimeWalkThroughState();
}

class _ItimeWalkThroughState extends State<ItimeWalkThrough> {
  // Get list from future

  // Get list model
  var titles = [
    title_walk_through_1,
    title_walk_through_2,
    title_walk_through_3,
    title_walk_through_4
  ];

  // Define base data type
  int currentIndexPage = 0;

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime

  // sub function


  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: itime_white_color,
          body: Stack(
            children: <Widget>[
              Container(
                width: size.width,
                height: size.height,
                child: PageView(
                  children: <Widget>[
                    WalkThrough(
                        textContent: title_walk_through_1,
                        subTextContent: subtitle_walk_through_1,
                        bgImg: itime_walkthrough_image_1,
                        index: 0),
                    WalkThrough(
                      textContent: title_walk_through_2,
                      subTextContent: subtitle_walk_through_2,
                      bgImg: itime_walkthrough_image_2,
                      index: 1,
                    ),
                    WalkThrough(
                      textContent: title_walk_through_3,
                      subTextContent: subtitle_walk_through_3,
                      bgImg: itime_walkthrough_image_3,
                      index: 2,
                    ),
                    WalkThrough(
                      textContent: title_walk_through_4,
                      subTextContent: subtitle_walk_through_4,
                      bgImg: itime_walkthrough_image_4,
                      index: 3,
                    ),
                  ],
                  onPageChanged: (value) {
                    setState(() => currentIndexPage = value);
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DotsIndicator(
                      dotsCount: 4,
                      position: currentIndexPage,
                      decorator: DotsDecorator(
                        size: const Size.square(8.0),
                        activeSize: const Size.square(12.0),
                        color: t5ViewColor,
                        activeColor: itime_main_color,
                      )),
                ),
              )
            ],
          )),
    );
  }
}

class WalkThrough extends StatelessWidget {
  final String textContent;
  final String subTextContent;
  final String bgImg;
  final int index;

  WalkThrough(
      {Key key, this.textContent, this.subTextContent, this.index, this.bgImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          width: size.width,
          height: size.height,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: size.height * 0.05),
                height: size.height * 0.4,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    bgImg != null
                        ? Image.asset(bgImg,
                            width: size.width,
                            height: size.height * 0.5,
                            fit: BoxFit.fill)
                        : Container(),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.08,
              ),
              text(
                textContent,
                textColor: itime_main_color,
                fontSize: itime_text_size_medium + 2,
                fontFamily: fontAndika,
                fontWeight: FontWeight.w600,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28.0),
                child: text(subTextContent,
                    fontSize: itime_text_size_medium,
                    fontFamily: fontAndika,
                    maxLine: 7,
                    isCentered: true),
              )
            ],
          ),
        ),
        index == 3
            ? Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  onTap: () {
                    launchScreen(context, Routes.itimeLogin);
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 16, right: 16, bottom: 50),
                    alignment: Alignment.center,
                    height: size.width / 8,
                    child: text('Tiếp Tục',
                        textColor: itime_white_color,
                        fontSize: itime_text_size_medium,
                        fontWeight: FontWeight.bold,
                        fontFamily: fontAndika,
                        isCentered: true),
                    decoration:
                        boxDecoration(bgColor: itime_main_color, radius: 8),
                  ),
              ))
            : Container()
      ],
    );
  }
}
