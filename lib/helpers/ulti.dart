import 'dart:io';

// import 'package:flutter_smart_course/src/models/images.dart';
// import 'package:flutter_smart_course/src/models/posts.dart';
import 'package:intl/intl.dart';

class Ulti {

  static const String BASE_URL_API = 'https://api.mifago.com/p1izitime/P1Controller/C3Mobile/SelectAllByWhat.php';
  Ulti();

  static double getFontSize(double width, double height, double size) {
    final ratio = height / width;
    final delta = (ratio - 1.77777777778).abs();

    if (delta > 0.1) {
      return (width * 1.77777777778) / size;
    } else {
      return height / size;
    }
  }

  // static String getTrueFullURLImage(String url) {
  //   try {
  //     if (url.indexOf('http') == 0) return url;
  //     return BASE_URL_CDN + url;
  //   } on SocketException catch (_) {
  //     throw Exception("Not have internet");
  //   }
  // }

  // static String getFullURLImagePostByNode(Post post) {
  //   try {
  //     print("loghere");
  //     print(post.node);
  //     print(post.image);
  //     return BASE_SCHEMA + post.node + BASE_DOMAIN + '/' + post.image;
  //   } on SocketException catch (_) {
  //     print(post);
  //     throw Exception("Not have internet");
  //   }
  // }

  // static String getFullURLImageByNode(ImageResult imageResult) {
  //   try {
  //     return BASE_SCHEMA + imageResult.node + BASE_DOMAIN + '/' + imageResult.image;
  //   } on SocketException catch (_) {
  //     throw Exception("Not have internet");
  //   }
  // }

  static String getDaysCountDown(DateTime date) {
    final now = DateTime.now();
    final t1 = now.microsecondsSinceEpoch / 1000000;

    final t2 = date.microsecondsSinceEpoch / 1000000;

    return ((t2 - t1) ~/ 86400).toString();
  }

  static String formatTextToast(String text) {
    return toBeginningOfSentenceCase(text);
  }
}
