import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:custom_progress_dialog/custom_progress_dialog.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vao_ra/blocs/b2500_timekeeping_bloc.dart';
import 'package:vao_ra/helpers/detector_painters.dart';
import 'package:vao_ra/helpers/dioultibaohq.dart';
import 'package:vao_ra/helpers/utils.dart';
import 'package:vao_ra/models/models.dart';
import 'package:vao_ra/pages/pages.dart';
import 'package:vao_ra/routes/router.gr.dart';
import 'package:vao_ra/shares/shares.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:image/image.dart' as imglib;
import 'package:path_provider/path_provider.dart';
import 'package:quiver/collection.dart';
import 'package:mime/mime.dart';

class ItimeCheckinCamera extends StatefulWidget {
  ItimeCheckinCamera(
      {Key key, this.tabController, this.shift, this.company, this.employee})
      : super(key: key);

  TabController tabController;

  final M3200ShiftModel shift;
  final M3400CompanyModel company;
  final M5500EmployeeModel employee;

  @override
  _ItimeCheckinCameraState createState() => _ItimeCheckinCameraState();
}

class _ItimeCheckinCameraState extends State<ItimeCheckinCamera> {
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

    timekeepingBloc.timekeepingStream2501.listen(_handleTimeKeepingReturn);
  }

  _handleTimeKeepingReturn(event) {
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

  /*
  * CAMERA SECTION INIT START
  * */

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  String randomStringFacePath = '';
  File imageFaceFile;
  List<int> imageFaceBytes = [];

  bool waitToGetFace = true;
  String faceImageStringBase64 = '';
  String nameFaceLabel = '';
  File jsonFile;
  dynamic _scanResults;
  CameraController _camera;
  var interpreter;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.front;
  dynamic data = {};
  double threshold = 1.0;
  Directory tempDir;
  List e1;
  bool _faceFound = false;

  bool _stopDetect = false;

  double width;
  double widthContent;
  double height;
  double cameraPreviewWidth;
  double cameraPreviewHeight;
  double cameraWidth;
  double cameraHeight;
  double cameraWidthDynamic;
  double cameraHeightDynamic;
  double heightAppBar;
  M3400CompanyModel company;
  M5500EmployeeModel employee;

  Future _disposeCamera() async {
    await this._camera.stopImageStream();
    await this._camera.dispose();
    this._camera = null;
  }

  Future loadModel() async {
    try {
      final gpuDelegateV2 = tfl.GpuDelegateV2(
          options: tfl.GpuDelegateOptionsV2(
        false,
        tfl.TfLiteGpuInferenceUsage.fastSingleAnswer,
        tfl.TfLiteGpuInferencePriority.minLatency,
        tfl.TfLiteGpuInferencePriority.auto,
        tfl.TfLiteGpuInferencePriority.auto,
      ));

      var interpreterOptions = tfl.InterpreterOptions()
        ..addDelegate(gpuDelegateV2);
      interpreter = await tfl.Interpreter.fromAsset('mobilefacenet.tflite',
          options: interpreterOptions);
    } on Exception {
      print('Failed to load model.');
    }
  }

  void _initializeCamera() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userJSON = prefs.getString('user');
    final String companyJSON = prefs.getString('company');
    this.employee = M5500EmployeeModel.fromJson(json.decode(userJSON));
    this.company = M3400CompanyModel.fromJson(json.decode(companyJSON));
    print('employee id ${this.employee.id}');
    print('company id ${this.company.id}');

    await loadModel();
    CameraDescription description = await getCamera(_direction);

    ImageRotation rotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );

    _camera =
        CameraController(description, ResolutionPreset.low, enableAudio: false);
    await _camera.initialize();
    await Future.delayed(Duration(milliseconds: 500));
    tempDir = await getApplicationDocumentsDirectory();

    String _embPath = tempDir.path + '/face.json';
    jsonFile = new File(_embPath);
    if (jsonFile.existsSync()) data = json.decode(jsonFile.readAsStringSync());

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );
    this.cameraPreviewWidth = _camera.value.previewSize.width;
    this.cameraPreviewHeight = _camera.value.previewSize.height;

    if (this.cameraPreviewWidth < this.cameraPreviewHeight) {
      this.cameraHeight = this.widthContent;
      this.cameraWidth = (this.cameraPreviewWidth * this.cameraHeight) /
          this.cameraPreviewHeight;
    } else {
      this.cameraWidth = this.widthContent;
      this.cameraHeight = (this.cameraPreviewWidth * this.cameraWidth) /
          this.cameraPreviewHeight;
    }

    print(
        'init this.cameraWidth ${this.cameraWidth} this.cameraHeight ${this.cameraHeight}');

    this.cameraWidthDynamic = this.cameraWidth;
    this.cameraHeightDynamic = this.cameraHeight;

    _camera.startImageStream((CameraImage image) {
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        String res;

        if (this.cameraPreviewWidth < this.cameraPreviewHeight) {
          this.cameraHeight = this.widthContent;
          this.cameraWidth = (this.cameraPreviewWidth * this.cameraHeight) /
              this.cameraPreviewHeight;
        } else {
          this.cameraWidth = this.widthContent;
          this.cameraHeight = (this.cameraPreviewWidth * this.cameraWidth) /
              this.cameraPreviewHeight;
        }

        this.cameraWidthDynamic = this.cameraWidth;
        this.cameraHeightDynamic = this.cameraHeight;

        if (_camera.value.deviceOrientation != DeviceOrientation.portraitUp ||
            _camera.value.deviceOrientation != DeviceOrientation.portraitDown) {
          // print('Vai loz that');
          double temp = this.cameraWidthDynamic;
          // this.cameraWidthDynamic = this.cameraHeightDynamic;
          // this.cameraHeightDynamic = temp;
        }

        dynamic finalResult = Multimap<String, Face>();
        detect(image, _getDetectionMethod(), rotation).then(
          (dynamic result) async {
            if (!_stopDetect) {
              if (result.length == 0)
                _faceFound = false;
              else
                _faceFound = true;
              Face _face;
              imglib.Image convertedImage =
                  _convertCameraImage(image, _direction);

              if (_faceFound && waitToGetFace && nameFaceLabel.length > 0) {
                this.imageFaceBytes = await convertImagetoPng(image);
                // setState(() {
                waitToGetFace = false;
                // });
                print('this.imageFaceBytes ${this.imageFaceBytes.runtimeType}');
                print('this.imageFaceFile ${this.imageFaceFile.runtimeType}');
              }
              for (_face in result) {
                double x, y, w, h;
                x = (_face.boundingBox.left - 10);
                y = (_face.boundingBox.top - 10);
                w = (_face.boundingBox.width + 10);
                h = (_face.boundingBox.height + 10);
                imglib.Image croppedImage = imglib.copyCrop(
                    convertedImage, x.round(), y.round(), w.round(), h.round());
                croppedImage = imglib.copyResizeCropSquare(croppedImage, 112);
                // int startTime = new DateTime.now().millisecondsSinceEpoch;
                res = _recog(croppedImage);
                // int endTime = new DateTime.now().millisecondsSinceEpoch;
                // print("Inference took ${endTime - startTime}ms");
                finalResult.add(res, _face);
              }
              setState(() {
                _scanResults = finalResult;
              });

              _isDetecting = false;
            }
          },
        ).catchError(
          (_) {
            _isDetecting = false;
          },
        );
      }
    });
  }

  Future<List<int>> convertImagetoPng(CameraImage image) async {
    try {
      imglib.Image img;
      if (image.format.group == ImageFormatGroup.yuv420) {
        img = _convertYUV420(image);
      } else if (image.format.group == ImageFormatGroup.bgra8888) {
        img = _convertBGRA8888(image);
      }

      imglib.PngEncoder pngEncoder = new imglib.PngEncoder();

      // Convert to png
      List<int> png = pngEncoder.encodeImage(img);
      return png;
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

// CameraImage YUV420_888 -> PNG -> Image (compresion:0, filter: none)
// Black
  imglib.Image _convertYUV420(CameraImage image) {
    var img = imglib.Image(image.width, image.height); // Create Image buffer

    Plane plane = image.planes[0];
    const int shift = (0xFF << 24);

    // Fill image buffer with plane[0] from YUV420_888
    for (int x = 0; x < image.width; x++) {
      for (int planeOffset = 0;
          planeOffset < image.height * image.width;
          planeOffset += image.width) {
        final pixelColor = plane.bytes[planeOffset + x];
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        // Calculate pixel color
        var newVal =
            shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

        img.data[planeOffset + x] = newVal;
      }
    }

    return img;
  }

// CameraImage BGRA8888 -> PNG
// Color
  imglib.Image _convertBGRA8888(CameraImage image) {
    return imglib.Image.fromBytes(
      image.width,
      image.height,
      image.planes[0].bytes,
      format: imglib.Format.bgra,
    );
  }

  Future<List<int>> convertYUV420toImageColor(CameraImage image) async {
    try {
      final int width = image.width;
      final int height = image.height;
      final int uvRowStride = image.planes[1].bytesPerRow;
      final int uvPixelStride = image.planes[1].bytesPerPixel;

      print("uvRowStride: " + uvRowStride.toString());
      print("uvPixelStride: " + uvPixelStride.toString());

      // imgLib -> Image package from https://pub.dartlang.org/packages/image
      var img = imglib.Image(width, height); // Create Image buffer

      // Fill image buffer with plane[0] from YUV420_888
      for (int x = 0; x < width; x++) {
        for (int y = 0; y < height; y++) {
          final int uvIndex =
              uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
          final int index = y * width + x;

          final yp = image.planes[0].bytes[index];
          final up = image.planes[1].bytes[uvIndex];
          final vp = image.planes[2].bytes[uvIndex];
          // Calculate pixel color
          int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
          int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
              .round()
              .clamp(0, 255);
          int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
          // color: 0x FF  FF  FF  FF
          //           A   B   G   R
          img.data[index] = (0xFF << 24) | (b << 16) | (g << 8) | r;
        }
      }

      imglib.PngEncoder pngEncoder = new imglib.PngEncoder(level: 0, filter: 0);
      List<int> png = pngEncoder.encodeImage(img);
      waitToGetFace = false;
      return png;
      // return Image.memory(png);
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

  HandleDetection _getDetectionMethod() {
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
      ),
    );
    return faceDetector.processImage;
  }

  Widget _buildResults() {
    const Text noResultsText = const Text('');
    if (_scanResults == null ||
        _camera == null ||
        !_camera.value.isInitialized) {
      return noResultsText;
    }
    CustomPainter painter;

    final Size imageSize = Size(
      _camera.value.previewSize.height,
      _camera.value.previewSize.width,
    );
    this.cameraPreviewWidth = _camera.value.previewSize.width;
    this.cameraPreviewHeight = _camera.value.previewSize.height;

    final double widthBox = this.widthContent;
    final double heightBox =
        (this.cameraPreviewWidth * widthBox) / this.cameraPreviewHeight;

    // final Size imageSize = Size(
    //   this.cameraHeight,
    //   this.cameraWidth,
    // );

    painter = FaceDetectorPainter(imageSize, _scanResults);
    return CustomPaint(
      size: Size(
        this.cameraHeightDynamic,
        this.cameraWidthDynamic,
      ),
      painter: painter,
    );
  }

  Widget _buildImage() {
    if (_camera == null || !_camera.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return _camera == null
        ? const Center(child: Text('Đang tải'))
        : Stack(
            // fit: StackFit.expand,
            overflow: Overflow.clip,
            children: <Widget>[
              // Positioned(
              //   left: 0,
              //   top: 0,
              //   width: this.widthContent,
              //   height: this.widthContent,
              //   child: Container(
              //     width: this.widthContent,
              //     height: this.widthContent,
              //     // color: Colors.green,
              //   ),
              // ),
              Positioned(
                left: 0,
                top: 0,
                width: this.widthContent,
                height: this.widthContent,
                child: Container(
                  width: this.widthContent,
                  height: this.widthContent,
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.all(0.0),
                  // decoration: BoxDecoration(
                  //     // color: Colors.white,
                  //     borderRadius: BorderRadius.circular(5.0),
                  //     border: Border.all(width: 4, color: Colors.blue)),
                  child: OverflowBox(
                    minWidth: this.cameraWidthDynamic,
                    minHeight: this.cameraHeightDynamic,
                    maxWidth: this.cameraWidthDynamic,
                    maxHeight: this.cameraHeightDynamic,
                    child: _camera != null
                        ? CameraPreview(_camera)
                        : Center(
                            child: Text('Đang tải'),
                          ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                width: this.widthContent,
                height: this.widthContent,
                child: Container(
                  width: this.widthContent,
                  height: this.widthContent,
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.all(0.0),
                  // decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.25),
                  //     borderRadius: BorderRadius.circular(5.0),
                  //     border: Border.all(width: 4, color: Colors.blue)),
                  child: OverflowBox(
                    minWidth: this.cameraWidthDynamic,
                    minHeight: this.cameraHeightDynamic,
                    maxWidth: this.cameraWidthDynamic,
                    maxHeight: this.cameraHeightDynamic,
                    child: _camera != null
                        ? _buildResults()
                        : Center(
                            child: Text('Đang tải'),
                          ),
                  ),
                ),
              ),
              // Positioned(
              //   left: 0,
              //   top: 0,
              //   width: this.cameraWidthDynamic,
              //   height: this.cameraHeightDynamic,
              //   child: _camera != null
              //       ? Container(
              //           width: _camera != null
              //               ? this.cameraWidthDynamic + 100
              //               : this.width,
              //           height: _camera != null
              //               ? this.cameraHeightDynamic
              //               : this.width,
              //           color: Colors.red,
              //           child: _camera != null
              //               ? CameraPreview(_camera)
              //               : Center(
              //                   child: Text('Đang tải'),
              //                 ),
              //         )
              //       : Center(child: Text('Đang tải')),
              // ),
              // Positioned(
              //   left: 10,
              //   top: 10,
              //   width: this.width,
              //   height: this.width + 0,
              //   child: RichText(
              //     text: TextSpan(
              //       text: 'this.width ${this.width }',
              //       style: TextStyle(
              //         color: Colors.black,
              //         fontSize: itime_text_size_medium,
              //       ),
              //       children: <TextSpan>[
              //         TextSpan(
              //           text: '\nthis.widthContent ${this.widthContent}',
              //           style: TextStyle(
              //             color: Colors.blueAccent,
              //             fontSize: itime_text_size_medium,
              //           ),
              //         ),
              //         TextSpan(
              //           text: '\nthis.cameraWidthDynamic ${this.cameraWidthDynamic}',
              //           style: TextStyle(
              //             color: Colors.blueAccent,
              //             fontSize: itime_text_size_medium,
              //           ),
              //         ),
              //         TextSpan(
              //           text: '\nthis.cameraHeightDynamic ${this.cameraHeightDynamic}',
              //           style: TextStyle(
              //             color: Colors.blueAccent,
              //             fontSize: itime_text_size_medium,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Positioned(
                right: 15,
                top: 15,
                child: GestureDetector(
                  onTap: () {
                    _toggleCameraDirection();
                  },
                  child: Container(
                    width: 70,
                    height: 70,
                    margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(35),
                    ),
                    child: _direction == CameraLensDirection.back
                        ? const Icon(
                            Icons.camera_front,
                            color: Colors.white,
                          )
                        : const Icon(Icons.camera_rear, color: Colors.white),
                  ),
                ),
              ),
            ],
          );
  }

  String detectNameFromKey(String nameKey) {
    var splitInfo = nameKey.split('_');
    var userName = 'Không xác định';
    var companyName = 'Không xác định';
    if (this.employee.id.toString() == splitInfo[0]) {
      userName = this.employee.Fullname;
    }
    if (this.company.id.toString() == splitInfo[1]) {
      companyName = this.company.CompanyName;
    }
    return userName + ' - ' + companyName;
  }

  void _toggleCameraDirection() async {
    if (_direction == CameraLensDirection.back) {
      _direction = CameraLensDirection.front;
    } else {
      _direction = CameraLensDirection.back;
    }
    await _camera.stopImageStream();
    await _camera.dispose();

    setState(() {
      _camera = null;
    });

    _initializeCamera();
  }

  imglib.Image _convertCameraImage(
      CameraImage image, CameraLensDirection _dir) {
    int width = image.width;
    int height = image.height;
    // imglib -> Image package from https://pub.dartlang.org/packages/image
    var img = imglib.Image(width, height); // Create Image buffer
    const int hexFF = 0xFF000000;
    final int uvyButtonStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        // Calculate pixel color
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        img.data[index] = hexFF | (b << 16) | (g << 8) | r;
      }
    }
    var img1 = (_dir == CameraLensDirection.front)
        ? imglib.copyRotate(img, -90)
        : imglib.copyRotate(img, 90);
    return img1;
  }

  String _recog(imglib.Image img) {
    List input = imageToByteListFloat32(img, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    List output = List(1 * 192).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    e1 = List.from(output);
    return compare(e1).toUpperCase();
  }

  String compare(List currEmb) {
    if (data.length == 0) return "Không có dữ liệu";
    double minDist = 999;
    double currDist = 0.0;
    String predRes = "Không tìm thấy danh tính";
    for (String label in data.keys) {
      currDist = euclideanDistance(data[label], currEmb);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predRes = detectNameFromKey(label);
        if (nameFaceLabel != predRes) {
          // Change face label if user change camera
          // setState(() {
          waitToGetFace = true;
          nameFaceLabel = predRes;
          // });
        }
      }
    }
    print(minDist.toString() + " " + predRes);
    return predRes;
  }

  /*
  * CAMERA SECTION INIT END
  * */

  void _checkFaceModelBeforeInit() async {
    tempDir = await getApplicationDocumentsDirectory();

    String _embPath = tempDir.path + '/face.json';
    jsonFile = new File(_embPath);
    if (jsonFile.existsSync()) {
      BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
              'assets/images/marker.png')
          .then((onValue) {
        pinLocationIcon = onValue;
      });
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

      _initState();

      Future.delayed(const Duration(milliseconds: 1500), () {
        _initializeCamera();
      });
    } else {
      print('Chay thang vo day');
      ExtendedNavigator.of(context)
          .push(Routes.itimeCameraTrain,
              arguments: ItimeCameraTrainArguments(shift: widget.shift))
          .then((val) {
        if (val != null && val) {
          _checkFaceModelBeforeInit();
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _checkFaceModelBeforeInit();
  }

  @override
  void dispose() {
    _disposeCamera();
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

  // ProgressDialog pd;
  ProgressDialog _progressDialog = ProgressDialog();

  @override
  Widget build(BuildContext context) {
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
                  height: MediaQuery.of(context).size.width / 3,
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
                          text: 'Nhận diện khuôn mặt: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: itime_text_size_medium,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: nameFaceLabel != null
                                  ? nameFaceLabel
                                  : 'Không thể xác định danh tính',
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
                        'Vui lòng cho phép ứng dụng sử dụng quyền \'Truy Cập Vị Trí\' và \'Truy Cập Camera\' để hoạt động. Nếu bạn không cho phép ứng dụng sẽ không thể hoạt động!',
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

    return Scaffold(
      // backgroundColor: Colors.deepOrangeAccent,
      // backgroundColor: HexColor('#EF6F6C'),
      body: SafeArea(
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double height = constraints.maxHeight;
            double width = constraints.maxWidth;
            this.width = width;
            this.widthContent = width - 20;
            this.height = height;
            AppBar appBar = AppBar(
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
                      'Vào ca làm việc',
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
            this.heightAppBar = appBar.preferredSize.height;

            return Scaffold(
              appBar: appBar,
              body: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: this.widthContent,
                            width: this.widthContent,
                            child: _buildImage()),
                        SizedBox(height: 10.0),
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
                        onTap: () async {
                          if (!waitToGetLocation &&
                              !waitToGetFace &&
                              !processing) {
                            setState(() {
                              processing = true;
                              _stopDetect = true;
                            });
                            _progressDialog.showProgressDialog(context,
                                barrierColor: Colors.black54,
                                textToBeDisplayed: 'Đang xử lý ...',
                                onDismiss: () {});

                            final directory = await getTemporaryDirectory();
                            // return directory.path;

                            this.randomStringFacePath =
                                this.getRandomString(15) + '-faceSelect.png';

                            print('directory ${directory.path}');
                            print(
                                'directory ${directory.path + '/' + randomStringFacePath}');

                            this.imageFaceFile = await File(
                                    directory.path + '/' + randomStringFacePath)
                                .writeAsBytes(imageFaceBytes);
                            // bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes)
                            print('this.imageFaceFile ${this.imageFaceFile}');

                            final mimeTypeData = lookupMimeType(
                                this.imageFaceFile.path,
                                headerBytes: [0xFF, 0xD8]).split('/');

                            final response =
                                await DioUtilBaohq.uploadImageFaceCheckin(
                                    this.imageFaceFile, mimeTypeData);

                            var param = {
                              "IdCompany": widget.company.id,
                              "IdEmployee": widget.employee.id,
                              "IdShift": widget.shift.id,
                              "CheckinLat": this.position.latitude,
                              "CheckinLng": this.position.longitude,
                              "CheckinTime": DateTime.now().toString(),
                              "CheckinFace": response.toString(),
                              "CheckinFaceStatus": nameFaceLabel,
                              "CheckoutLat": null,
                              "CheckoutLng": null,
                              "CheckoutFace": null,
                              "CheckoutFaceStatus": null,
                              "CheckoutTime": null,
                              "IdTimekeepingStatus": 1,
                            };

                            timekeepingBloc.callWhat2501(param);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: waitToGetLocation || processing
                                  ? Colors.grey
                                  : itime_main_color,
                            ),
                            height: 50,
                            child: Center(
                              child: Text(
                                'XÁC NHẬN VÀO CA',
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
            );
          },
        ),
      ),
    );
  }
}
