import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';

import 'ulti.dart';

const httpHeaders = {
  'Accept': 'application/json, text/plain, */*',
  'Content-Type': 'application/json;charset=UTF-8',
};

class DioUtilBaohq {

  static Dio dio = new Dio();

  DioUtilBaohq() {
    checkConnect();
  }

  static checkConnect() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('Not have internet connected');
      }
    } on SocketException catch (_) {
      throw Exception("Not have internet");
    }
  }

  // Request section
  static Future get(url, {queryParameters}) async {
    try {
      Response response;
      dio.options.headers = httpHeaders;

      response =
      await dio.get(Ulti.BASE_URL_API + url, queryParameters: queryParameters);

      if (checkStatusCodeSuccess(response.statusCode)) {
        return response;
      } else {
        throw Exception("Dio Interface exception R");
      }
    } catch (e) {
      print("Dio get error ${e.response}");
      if (e.response != null) {
        Map<String, dynamic> res = jsonDecode(e.response.toString());
        if (res['error'] != null) {
          if (res['error']['errors'] != null) {
            if (res['error']['errors'][0] != null) {
              if (res['error']['errors'][0]['message'] != null) {
                throw Exception(res['error']['errors'][0]['message']);
              } else {
                throw Exception('Unknow error dio exception post');
              }
            } else {
              throw Exception('Unknow error dio exception post');
            }
          } else {
            throw Exception(res['error']['message']);
          }
        }
      } else if (e.message != null) {
        print("Dio get error message ${e.message}");
        throw Exception(e.message.toString());
      } else {
        throw e;
      }
    }
  }

  // Request section
  static Future delete(url, {queryParameters}) async {
    try {
      Response response;
      dio.options.headers = httpHeaders;

      response =
      await dio.delete(Ulti.BASE_URL_API + url, queryParameters: queryParameters);

      if (checkStatusCodeSuccess(response.statusCode)) {
        return response;
      } else {
        throw Exception("Dio Interface exception R");
      }
    } catch (e) {
      print("Dio get error ${e.response}");
      if (e.response != null) {
        Map<String, dynamic> res = jsonDecode(e.response.toString());
        if (res['error'] != null) {
          if (res['error']['errors'] != null) {
            if (res['error']['errors'][0] != null) {
              if (res['error']['errors'][0]['message'] != null) {
                throw Exception(res['error']['errors'][0]['message']);
              } else {
                throw Exception('Unknow error dio exception post');
              }
            } else {
              throw Exception('Unknow error dio exception post');
            }
          } else {
            throw Exception(res['error']['message']);
          }
        }
      } else if (e.message != null) {
        print("Dio get error message ${e.message}");
        throw Exception(e.message.toString());
      } else {
        throw e;
      }
    }
  }

  static Future uploadImageToAvatar(file, mimeType) async {
    try {

      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path,
            filename: fileName,
            contentType: MediaType(mimeType[0], mimeType[1])),
      });

      Response response;
      response = await dio.post(Ulti.BASE_URL_API + 'upload', data: formData);

      if (checkStatusCodeSuccess(response.statusCode)) {
        return response;
      } else {
        throw Exception("Dio Interface exception R");
      }
    } catch (e) {
      print("Dio upload error $e");
      if (e.response != null) {
        Map<String, dynamic> res = jsonDecode(e.response.toString());
        if (res['error'] != null) {
          if (res['error']['errors'] != null) {
            if (res['error']['errors'][0] != null) {
              if (res['error']['errors'][0]['message'] != null) {
                throw Exception(res['error']['errors'][0]['message']);
              } else {
                throw Exception('Unknow error dio exception post');
              }
            } else {
              throw Exception('Unknow error dio exception post');
            }
          } else {
            throw Exception(res['error']['message']);
          }
        }
      } else if (e.message != null) {
        print("Dio upload error message ${e.message}");
        throw Exception(e.message.toString());
      } else {
        throw e;
      }
    }
  }

  static Future uploadImageFaceCheckin(file, mimeType) async {
    try {

      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(file.path,
            filename: fileName,
            contentType: MediaType(mimeType[0], mimeType[1])),
      });

      Response response;
      response = await dio.post('https://api.mifago.com/p1izitime/P5Upload/UploadImage.php', data: formData);

      if (checkStatusCodeSuccess(response.statusCode)) {
        return response;
      } else {
        throw Exception("Dio Interface exception R");
      }
    } catch (e) {
      print("Dio upload error $e");
      if (e.response != null) {
        Map<String, dynamic> res = jsonDecode(e.response.toString());
        if (res['error'] != null) {
          if (res['error']['errors'] != null) {
            if (res['error']['errors'][0] != null) {
              if (res['error']['errors'][0]['message'] != null) {
                throw Exception(res['error']['errors'][0]['message']);
              } else {
                throw Exception('Unknow error dio exception post');
              }
            } else {
              throw Exception('Unknow error dio exception post');
            }
          } else {
            throw Exception(res['error']['message']);
          }
        }
      } else if (e.message != null) {
        print("Dio upload error message ${e.message}");
        throw Exception(e.message.toString());
      } else {
        throw e;
      }
    }
  }

  // Request section
  static Future post(url, formData) async {
    try {
      Response response;
      dio.options.headers = httpHeaders;
      response = await dio.post(Ulti.BASE_URL_API + url, data: formData);

      if (checkStatusCodeSuccess(response.statusCode)) {
        return response;
      } else {
        throw Exception("Dio Interface exception R");
      }
    } catch (e) {
      print("Dio post error $e");
      if (e.response != null) {
        Map<String, dynamic> res = jsonDecode(e.response.toString());
        if (res['error'] != null) {
          if (res['error']['errors'] != null) {
            if (res['error']['errors'][0] != null) {
              if (res['error']['errors'][0]['message'] != null) {
                throw Exception(res['error']['errors'][0]['message']);
              } else {
                throw Exception('Unknow error dio exception post');
              }
            } else {
              throw Exception('Unknow error dio exception post');
            }
          } else {
            throw Exception(res['error']['message']);
          }
        }
      } else if (e.message != null) {
        print("Dio post error message ${e.message}");
        throw Exception(e.message.toString());
      } else {
        throw e;
      }
    }
  }

  // Request section
  static Future put(url, formData) async {
    try {
      Response response;
      dio.options.headers = httpHeaders;
      response = await dio.put(Ulti.BASE_URL_API + url, data: formData);

      if (checkStatusCodeSuccess(response.statusCode)) {
        return response;
      } else {
        throw Exception("Dio Interface exception R");
      }
    } catch (e) {
      print("Dio put error $e");
      if (e.response != null) {
        Map<String, dynamic> res = jsonDecode(e.response.toString());
        if (res['error'] != null) {
          if (res['error']['errors'] != null) {
            if (res['error']['errors'][0] != null) {
              if (res['error']['errors'][0]['message'] != null) {
                throw Exception(res['error']['errors'][0]['message']);
              } else {
                throw Exception('Unknow error dio exception post');
              }
            } else {
              throw Exception('Unknow error dio exception post');
            }
          } else {
            throw Exception(res['error']['message']);
          }
        }
      } else if (e.message != null) {
        print("Dio put error message ${e.message}");
        throw Exception(e.message.toString());
      } else {
        throw e;
      }
    }
  }

  static Future<void> deleteToken() async {
    print("DioUtilBaohq deleteToken");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loginToken', "");
    await prefs.setString('user', "");
    await prefs.setString('company', "");
    return;
  }

  // Request section
  static Future postLogin(url, formData) async {
    try {
      Response response;
      dio.options.headers = httpHeaders;
      response = await dio.post(Ulti.BASE_URL_API + url, data: formData);
      if (response != null && checkStatusCodeSuccess(response.statusCode)) {
        var responseJSON = response.data;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loginToken', responseJSON['token']);
        await prefs.setString('user', jsonEncode(responseJSON['data'][0]).toString());
        return response;
      } else {
        throw Exception("DioUtilBaohq Interface exception R");
      }
    } catch (e) {
      print("Dio post login error $e");
      if (e.response != null) {
        Map<String, dynamic> res = jsonDecode(e.response.toString());
        if (res['error'] != null) {
          if (res['error']['errors'] != null) {
            if (res['error']['errors'][0] != null) {
              if (res['error']['errors'][0]['message'] != null) {
                throw Exception(res['error']['errors'][0]['message']);
              } else {
                throw Exception('Unknow error dio exception post');
              }
            } else {
              throw Exception('Unknow error dio exception post');
            }
          } else {
            throw Exception(res['error']['message']);
          }
        }
      } else if (e.message != null) {
        print("Dio post login error message ${e.message}");
        throw Exception(e.message.toString());
      } else {
        throw e;
      }
    }
  }

  static checkStatusCodeSuccess(int statusCode) {
    if (statusCode == 200 || statusCode == 201) return true;
    return false;
  }

  // Interceptor section
  static tokenInter() {
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      dio.lock();
      Future<dynamic> future = Future(() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.getString("loginToken");
      });
      return future.then((value) {
        if (null != value && value.length > 0) {
          options.headers["Authorization"] = value;
        } else {
          print("Token bearer not found");
        }
        // print(options);
        return options;
      }).whenComplete(() => dio.unlock()); // unlock the dio
    }, onResponse: (Response response) {
      // Do some preprocessing before returning the response data
      return response; // continue
    }, onError: (DioError e) {
      return e; //continue
    }));
  }
}
