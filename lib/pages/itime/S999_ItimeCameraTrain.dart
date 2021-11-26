import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:image/image.dart' as imglib;
import 'package:vao_ra/helpers/detector_painters.dart';
import 'package:vao_ra/helpers/utils.dart';
import 'package:vao_ra/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:path_provider/path_provider.dart';
import 'package:quiver/collection.dart';
import 'package:vao_ra/routes/router.dart';

class ItimeCameraTrain extends StatefulWidget {
  ItimeCameraTrain({Key key, this.tabController, this.shift}) : super(key: key);

  final M3200ShiftModel shift;

  TabController tabController;

  @override
  ItimeCameraTrainPageState createState() => ItimeCameraTrainPageState();
}

class ItimeCameraTrainPageState extends State<ItimeCameraTrain> {
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
  final TextEditingController _name = new TextEditingController();

  double width;
  double height;
  double cameraPreviewWidth;
  double cameraPreviewHeight;
  double cameraWidth;
  double cameraHeight;
  double heightAppBar;
  M3400CompanyModel company;
  M5500EmployeeModel employee;

  final List<List<String>> stepAddFace = [
    [
      'Nhìn chính diện vào camera trong',
      'giây',
    ],
    [
      'Ngước mặt từ từ trong',
      'giây, mắt nhìn vào camera',
    ],
    [
      'Cúi đầu từ từ trong trong',
      'giây, mắt nhìn vào camera',
    ],
    [
      'Nghiêng trái từ từ trong',
      'giây, mắt nhìn vào camera',
    ],
    [
      'Nghiêng phải từ trong',
      'giây, mắt nhìn vào camera',
    ],
  ];
  int curentStepAddFace = -1;

  int endTimeAddSingleImageFace = 0;
  bool curentStepAddFaceIsDone = false;

  @override
  void initState() {
    print('init camera train');
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print("WidgetsBinding");
    //   _initializeCamera();
    // });
    Future.delayed(const Duration(milliseconds: 1500), () {
      _initializeCamera();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _disposeCamera();
    super.dispose();
  }

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

    _camera.startImageStream((CameraImage image) {
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        String res;
        dynamic finalResult = Multimap<String, Face>();
        detect(image, _getDetectionMethod(), rotation).then(
          (dynamic result) async {
            if (result.length == 0)
              _faceFound = false;
            else
              _faceFound = true;
            Face _face;
            imglib.Image convertedImage =
                _convertCameraImage(image, _direction);
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
          },
        ).catchError(
          (_) {
            _isDetecting = false;
          },
        );
      }
    });
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

    this.cameraWidth = this.width;
    this.cameraHeight =
        (this.cameraPreviewWidth * this.cameraWidth) / this.cameraPreviewHeight;

    // final Size imageSize = Size(
    //   this.cameraHeight,
    //   this.cameraWidth,
    // );

    painter = FaceDetectorPainter(imageSize, _scanResults);
    return CustomPaint(
      size: Size(
        this.cameraWidth,
        this.cameraHeight,
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

    return Container(
      width: this.width,
      height: this.height,
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(child: Text('Đang tải'))
          : Stack(
              // fit: StackFit.expand,
              children: <Widget>[
                Positioned(
                  left: 0,
                  top: 0,
                  width: this.width,
                  height: _camera != null ? this.cameraHeight : 50,
                  child: _camera != null
                      ? Container(
                          width: this.width,
                          height: _camera != null ? this.cameraHeight : 50,
                          color: Colors.green,
                          child: _camera != null
                              ? CameraPreview(_camera)
                              : Center(child: Text('Đang tải')),
                        )
                      : Center(child: Text('Đang tải')),
                ),
                _buildResults(),
                Positioned(
                  left: 0,
                  top: this.cameraHeight,
                  child: Container(
                    width: this.width,
                    height: this.height - this.heightAppBar - this.cameraHeight,
                    // color: Colors.yellowAccent,
                    child: (data != null && data.length > 0)
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                SizedBox(height: 10),
                                Text(
                                  'Có ' +
                                      data.length.toString() +
                                      ' khuôn mặt được lưu',
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 15),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var name = data.keys.elementAt(index);
                                      return new Column(
                                        children: <Widget>[
                                          Row(
                                            children: [
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(12),
                                                width: this.width - 80,
                                                child: Text(
                                                  detectNameFromKey(name),
                                                  style: new TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(0),
                                                width: 80,
                                                child: Ink(
                                                  decoration: ShapeDecoration(
                                                    // color: Colors.blue,
                                                    shape: CircleBorder(),
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete_forever,
                                                      color: Colors.redAccent,
                                                    ),
                                                    // iconSize: 48,
                                                    color: Colors.redAccent,
                                                    onPressed: () {
                                                      _handleDeleteFaceModel(
                                                          name);
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          new Divider(),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ])
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              this.curentStepAddFace == -1
                                  ? RaisedButton(
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      padding: const EdgeInsets.all(12),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(8)),
                                      child: Text(
                                        'Thêm khuôn mặt',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                      onPressed: () async {
                                        setState(() {
                                          this.curentStepAddFaceIsDone = false;
                                          this.curentStepAddFace = 0;
                                          this.endTimeAddSingleImageFace =
                                              DateTime.now()
                                                      .millisecondsSinceEpoch +
                                                  1000 * 5;
                                        });
                                      },
                                    )
                                  : Container(
                                      width: this.width,
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        children: [
                                          (this.curentStepAddFace <
                                                  this.stepAddFace.length)
                                              ? CountdownTimer(
                                                  endTime: this
                                                      .endTimeAddSingleImageFace,
                                                  onEnd: () {
                                                    this.curentStepAddFaceIsDone =
                                                        true;
                                                  },
                                                  widgetBuilder: (_,
                                                      CurrentRemainingTime
                                                          time) {
                                                    if (time == null) {
                                                      return Text(
                                                        'Đã ghi nhận',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            // color: Colors.green,
                                                            fontSize: 15),
                                                      );
                                                    }
                                                    return Text(
                                                      this.stepAddFace[this
                                                                  .curentStepAddFace]
                                                              [0] +
                                                          ' ${time.sec} ' +
                                                          this.stepAddFace[this
                                                              .curentStepAddFace][1],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          color:
                                                              Colors.redAccent,
                                                          fontSize: 15),
                                                    );
                                                  },
                                                )
                                              : Text(
                                                  'Xử lý khuôn mặt hoàn tất',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      // color: Colors.green,
                                                      fontSize: 15),
                                                ),
                                          SizedBox(
                                            height: 25,
                                          ),
                                          (this.curentStepAddFace <
                                                  this.stepAddFace.length)
                                              ? RaisedButton(
                                                  color:
                                                      this.curentStepAddFaceIsDone ==
                                                              true
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors
                                                              .grey.shade400,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  textColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(8)),
                                                  child: Text(
                                                    'Tiếp theo',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  onPressed: () async {
                                                    if (this.curentStepAddFaceIsDone ==
                                                        true) {
                                                      setState(() {
                                                        this.curentStepAddFace +=
                                                            1;
                                                        if (this.curentStepAddFace >=
                                                            this
                                                                .stepAddFace
                                                                .length) {
                                                          this.curentStepAddFaceIsDone =
                                                              true;
                                                        } else {
                                                          this.curentStepAddFaceIsDone =
                                                              false;
                                                        }
                                                        this.endTimeAddSingleImageFace =
                                                            DateTime.now()
                                                                    .millisecondsSinceEpoch +
                                                                1000 * 5;
                                                      });
                                                    }
                                                  },
                                                )
                                              : RaisedButton(
                                                  color:
                                                      this.curentStepAddFaceIsDone ==
                                                              true
                                                          ? Theme.of(context)
                                                              .primaryColor
                                                          : Colors
                                                              .grey.shade400,
                                                  padding:
                                                      const EdgeInsets.all(12),
                                                  textColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          new BorderRadius
                                                              .circular(8)),
                                                  child: Text(
                                                    'Lưu khuôn mặt',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                  ),
                                                  onPressed: () async {

                                                    if (widget.shift != null) {
                                                      await _handleSaveModel(true);
                                                      setState(() {
                                                        this.curentStepAddFaceIsDone =
                                                        false;
                                                        this.curentStepAddFace =
                                                        -1;
                                                      });
                                                      ExtendedNavigator.of(context).pop(true);
                                                    } else {
                                                      await _handleSaveModel(false);
                                                      setState(() {
                                                        this.curentStepAddFaceIsDone =
                                                        false;
                                                        this.curentStepAddFace =
                                                        -1;
                                                      });
                                                    }
                                                  },
                                                )
                                        ],
                                      )),
                            ],
                          ),
                  ),
                ),
                Positioned(
                  right: 15,
                  top: this.cameraHeight - 85,
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
            ),
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

  @override
  Widget build(BuildContext context) {
    // this.height = MediaQuery.of(context).size.height;
    // this.width = MediaQuery.of(context).size.width;

    return Scaffold(
      // backgroundColor: Colors.deepOrangeAccent,
      // backgroundColor: HexColor('#EF6F6C'),
      body: SafeArea(
        child: new LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            double height = constraints.maxHeight;
            double width = constraints.maxWidth;
            this.width = width;
            this.height = height;
            AppBar appBar = AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: const Text(
                'Quản lý khuôn mặt',
                style: TextStyle(color: Colors.black),
              ),
              iconTheme: IconThemeData(color: Colors.black),
            );
            this.heightAppBar = appBar.preferredSize.height;

            return Scaffold(
              appBar: appBar,
              body: _buildImage(),
            );
          },
        ),
      ),
    );
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
      }
    }
    print(minDist.toString() + " " + predRes);
    return predRes;
  }

  void _resetFile() async {
    data = {};
    // jsonFile.deleteSync();
    await jsonFile.delete();
  }

  void _viewLabels() {
    setState(() {
      _camera = null;
    });
    String name;
    var alert = new AlertDialog(
      title: new Text("Saved Faces"),
      content: new ListView.builder(
          padding: new EdgeInsets.all(2),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            name = data.keys.elementAt(index);
            return new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    name,
                    style: new TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(2),
                ),
                new Divider(),
              ],
            );
          }),
      actions: <Widget>[
        new FlatButton(
          child: Text("OK"),
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void _addLabel() {
    setState(() {
      _camera = null;
    });
    print("Adding new face");
    var alert = new AlertDialog(
      title: new Text("Add Face"),
      content: new Row(
        children: <Widget>[
          new Expanded(
            child: new TextField(
              controller: _name,
              autofocus: true,
              decoration: new InputDecoration(
                  labelText: "Name", icon: new Icon(Icons.face)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        new FlatButton(
            child: Text("Save"),
            onPressed: () {
              _handle(_name.text.toUpperCase());
              _name.clear();
              Navigator.pop(context);
            }),
        new FlatButton(
          child: Text("Cancel"),
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void _handle(String text) {
    data[this.employee.id.toString() + '_' + this.company.id.toString()] = e1;
    jsonFile.writeAsStringSync(json.encode(data));
    _initializeCamera();
  }

  void _handleDeleteFaceModel(String label) {
    data.remove(label);
    jsonFile.writeAsStringSync(json.encode(data));
    _resetFile();
    _initializeCamera();
  }

  void _handleSaveModel(willPop) async{
    if(willPop == true){
      data[this.employee.id.toString() + '_' + this.company.id.toString()] = e1;
      await jsonFile.writeAsStringSync(json.encode(data));
    } else {
      data[this.employee.id.toString() + '_' + this.company.id.toString()] = e1;
      await jsonFile.writeAsStringSync(json.encode(data));
      _initializeCamera();
    }
  }
}
