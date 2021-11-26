import 'dart:async';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/blocs/b2500_timekeeping_bloc.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/pages/pages.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';
// import 'package:sn_progress_dialog/progress_dialog.dart';

class ItimeCheckoutNormal extends StatefulWidget {
  ItimeCheckoutNormal(
      {Key key, this.tabController, this.shift, this.company, this.employee})
      : super(key: key);

  TabController tabController;

  final M3200ShiftModel shift;
  final M3400CompanyModel company;
  final M5500EmployeeModel employee;

  @override
  _ItimeCheckoutNormalState createState() => _ItimeCheckoutNormalState();
}

class _ItimeCheckoutNormalState extends State<ItimeCheckoutNormal> {
  // Get list from future

  // Get list model

  // Define base data type

  // Define object from library
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  // Define datetime

  // sub function

  // Map
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor pinLocationIcon;
  Set<Marker> _markers = {};

  CameraPosition _initLocationMap;

  bool waitToGetLocation = true;

  bool processing = false;

  Geolocator geolocator = Geolocator();

  _initState() async {
    position = await _determinePosition();

    await _getAddressFromLatLng();

    print('position ${position}');
    _initLocationMap = CameraPosition(
      target: LatLng(this.position.latitude, this.position.longitude),
      zoom: 8.4746,
    );

    _initMarker();

    timekeepingBloc.timekeepingStream2508.listen(_handleTimeKeepingReturn);
  }

  _handleTimeKeepingReturn(event) async {
    print('_handleTimeKeepingReturn call close dialog');
    _progressDialog.dismissProgressDialog(context);
    processing = false;
    ExtendedNavigator.of(context).pop(true);
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.postalCode}, ${place.country}";
        waitToGetLocation = false;
        _initMarker();
      });
    } catch (e) {
      print(e);
    }
  }

  Position position;
  String _currentAddress;

  bool mapReady = false;

  final timekeepingBloc = TimekeepingBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/marker.png')
        .then((onValue) {
      pinLocationIcon = onValue;
    });

    _initState();
  }

  @override
  void dispose() {
    timekeepingBloc.dispose();
    super.dispose();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _initMarker() async {
    try {
      _markers.clear();
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(
              widget.employee.id.toString(),
            ),
            position: LatLng(
              this.position.latitude,
              this.position.longitude,
            ),
            icon: pinLocationIcon,
            infoWindow: InfoWindow(
              title: _currentAddress,
              // snippet: _currentAddress,
            ),
          ),
        );
        // Go to the positon
        _goToTheMarker(this.position.latitude, this.position.longitude);
      });

      print(_markers);

      setState(() {
        this.mapReady = true;
      });

      // WidgetsFlutterBinding.ensureInitialized();
    } catch (e) {
      // _showToast(e.message.toString(), 2);
    }
  }

  Future<void> _goToTheMarker(double lat, double lng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, lng),
          tilt: 59.440717697143555,
          zoom: 15,
        ),
      ),
    );
  }

  // sub function
  String _formatMinute(DateTime dateTime) {
    return DateFormat('mm').format(dateTime);
  }

  String _formatHour(DateTime dateTime) {
    return DateFormat('HH').format(dateTime);
  }

  Future getFuture() {
    return Future(() async {
      await Future.delayed(Duration(seconds: 1));
    });
  }

  Future<void> showProgress(BuildContext context) async {
    var result = await showDialog(
      context: context,
      builder: (context) =>
          FutureProgressDialog(getFuture(), message: Text('Đang xử lý...')),
    );
  }

  // ProgressDialog pd;
  ProgressDialog _progressDialog = ProgressDialog();

  @override
  Widget build(BuildContext context) {
    // this.pd = ProgressDialog(context: context);

    // WIDGET APPBAR SECTION
    Widget _appbarSection() {
      return AppBar(
        bottomOpacity: 0.0,
        elevation: 0.0,
        backgroundColor: iconColorPrimary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: Text(
                'Ra ca làm',
                style: TextStyle(
                  color: appTextColorPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: itime_text_size_normal + 2,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
//              Navigator.pushReplacement(
//                  context,
//                  MaterialPageRoute(
//                      builder: (context) => ItimeBottomNavigation(
//                            tabPage: 0,
//                          )));
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0, left: 25.0),
              child: Center(
                child: Icon(
                  Icons.clear,
                  color: itime_black,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      );
    }
    // END WIDGET APPBAR SECTION

    // WIDGET POSITION INFORMATION SECTION
    Widget _positionInformationSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Text(
          //   'Thông tin vị trí:',
          //   style: TextStyle(
          //     color: getColorFromHex("#B5B5B5"),
          //   ),
          // ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: getColorFromHex("#FFFFFF"),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width / 2,
                  width: MediaQuery.of(context).size.width,
                  child: this.mapReady == true
                      ? GoogleMap(
                          myLocationEnabled: true,
                          mapType: MapType.hybrid,
                          markers: _markers,
                          initialCameraPosition: _initLocationMap,
                          onMapCreated: (GoogleMapController controller) {
                            if (!_controller.isCompleted) {
                              _controller.complete(controller);
                            } else {}
                          },
                          gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>[
                            new Factory<OneSequenceGestureRecognizer>(
                              () => new EagerGestureRecognizer(),
                            ),
                          ].toSet(),
                        )
                      : Center(),
                ),
              ],
            ),
          ),
        ],
      );
    }
    // END WIDGET POSITION INFORMATION SECTION

    // WIDGET CONNECT INTERNET SECTION
    Widget _connectInternetSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: getColorFromHex("#FFFFFF"),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: RichText(
                        text: TextSpan(
                          text: 'Vị trí của bạn hiện tại: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: itime_text_size_medium,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: _currentAddress != null
                                  ? _currentAddress
                                  : 'Không thể lấy địa chỉ hiện tại',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: itime_text_size_medium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 50,
                      child: Text(
                        'Vui lòng cho phép ứng dụng sử dụng quyền \'Truy Cập Vị Trí\' để hoạt động. Nếu bạn không cho phép ứng dụng sẽ không thể hoạt động!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: getColorFromHex("#B5B5B5"),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );
    }
    // END WIDGET CONNECT INTERNET SECTION

    // WIDGET SHIFT INFO SECTION
    Widget _shiftInfoSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: getColorFromHex("#FFFFFF"),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      // padding: const EdgeInsets.only(
                      //     left: 10.0, top: 15.0, bottom: 15.0),
                      child: Text(
                        widget.shift.Name,
                        style: TextStyle(
                            fontSize: itime_text_size_medium,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Từ ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: itime_text_size_medium,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: widget.shift.StartHour.toString() +
                                  ' giờ ' +
                                  widget.shift.StartMinute.toString() +
                                  ' phút',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: itime_text_size_medium,
                              ),
                            ),
                            TextSpan(
                              text: ' đến ',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: itime_text_size_medium,
                              ),
                            ),
                            TextSpan(
                              text: widget.shift.EndHour.toString() +
                                  ' giờ ' +
                                  widget.shift.EndMinute.toString() +
                                  ' phút',
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: itime_text_size_medium,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      widget.shift.canCheckoutAction == true
                          ? CountdownTimer(
                              endTime: widget.shift.checkoutCountDown,
                              onEnd: () {
                                widget.shift.canCheckoutAction = false;
                              },
                              widgetBuilder: (_, CurrentRemainingTime time) {
                                if (time == null) {
                                  return Text(
                                    'Đã hết thời gian điểm danh ra ca',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: itime_text_size_medium,
                                    ),
                                  );
                                }
                                return Text(
                                  'Kết thúc ra sau ${time.hours == null ? '00' : (time.hours < 10 ? '0' + time.hours.toString() : time.hours.toString())}:${time.min == null ? '00' : (time.min < 10 ? '0' + time.min.toString() : time.min.toString())}:${time.sec == null ? '00' : (time.sec < 10 ? '0' + time.sec.toString() : time.sec.toString())}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: itime_text_size_medium,
                                  ),
                                );
                              },
                            )
                          : (widget.shift.canWillCheckoutAction == true
                              ? CountdownTimer(
                                  endTime: widget.shift.checkoutWillCountDown,
                                  onEnd: () {
                                    widget.shift.canWillCheckoutAction = false;
                                    widget.shift.canCheckoutAction = true;
                                  },
                                  widgetBuilder:
                                      (_, CurrentRemainingTime time) {
                                    if (time == null) {
                                      return Text(
                                        'Đã ghi nhận',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          // color: Colors.green,
                                          fontSize: itime_text_size_medium,
                                        ),
                                      );
                                    }
                                    // print('lol ${time}');
                                    return Text(
                                      'Ra ca sau ${time.hours == null ? '00' : (time.hours < 10 ? '0' + time.hours.toString() : time.hours.toString())}:${time.min == null ? '00' : (time.min < 10 ? '0' + time.min.toString() : time.min.toString())}:${time.sec == null ? '00' : (time.sec < 10 ? '0' + time.sec.toString() : time.sec.toString())}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.redAccent,
                                        fontSize: itime_text_size_medium,
                                      ),
                                    );
                                  },
                                )
                              : Center()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
    // END WIDGET SHIFT INFO SECTION

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: itime_main_background,
        key: scaffoldKey,
        appBar: _appbarSection(),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _positionInformationSection(),
                  SizedBox(height: 10.0),
                  _connectInternetSection(),
                  SizedBox(height: 10.0),
                  _shiftInfoSection(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: <Widget>[
              // Expanded(
              //   flex: 2,
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.pop(context);
              //     },
              //     child: Padding(
              //       padding: const EdgeInsets.all(10.0),
              //       child: Container(
              //         color: Colors.black,
              //         height: 50,
              //         child: Center(
              //           child: Text(
              //             'Trở về',
              //             style: TextStyle(
              //               color: getColorFromHex("#FFFFFF"),
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    if (!waitToGetLocation && !processing) {
                      setState(() {
                        processing = true;
                      });
                      _progressDialog.showProgressDialog(context,
                          barrierColor: Colors.black54,
                          textToBeDisplayed: 'Đang xử lý ...', onDismiss: () {
                      });

                      var param = {
                        "id": widget.shift.timeKeeping.id,
                        "IdCompany": widget.company.id,
                        "IdEmployee": widget.employee.id,
                        "IdShift": widget.shift.id,
                        "CheckoutLat": this.position.latitude,
                        "CheckoutLng": this.position.longitude,
                        "CheckoutFace": null,
                        "CheckoutFaceStatus": null,
                        "CheckoutTime": DateTime.now().toString(),
                      };

                      timekeepingBloc.callWhat2508(param);

                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: waitToGetLocation || processing ? Colors.grey : itime_main_color,
                      ),
                      height: 50,
                      child: Center(
                        child: Text(
                          'XÁC NHẬN',
                          style: TextStyle(
                            color: getColorFromHex("#FFFFFF"),
                          ),
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
