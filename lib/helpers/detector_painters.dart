import 'dart:ui';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(this.imageSize, this.results);
  final Size imageSize;
  double scaleX, scaleY;
  dynamic results;
  Face face;
  @override
  void paint(Canvas canvas, Size size) {
    // print('paint imageSize.width ${imageSize.width} imageSize.height ${imageSize.height} size.width ${size.width} size.height ${size.height} ');
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.green;
    for (String label in results.keys) {
      for (Face face in results[label]) {
        // face = results[label];
        scaleX = size.width / imageSize.width;
        scaleY = size.height / imageSize.height;

        // Right side top
        canvas.drawLine(
          Offset(size.width - (face.boundingBox.left * scaleX) , face.boundingBox.top * scaleY),
          Offset(size.width - (face.boundingBox.left * scaleX ) , (face.boundingBox.top + (face.boundingBox.bottom - face.boundingBox.top) / 8) * scaleY),
          paint,
        );
        // Right top top
        canvas.drawLine(
          Offset(size.width - (face.boundingBox.left * scaleX) , face.boundingBox.top * scaleY ),
          Offset(size.width - (face.boundingBox.left - (face.boundingBox.left - face.boundingBox.right) / 8) * scaleX, face.boundingBox.top * scaleY ),
          paint,
        );
        // Right side bottom
        canvas.drawLine(
          Offset(size.width - (face.boundingBox.left * scaleX) , face.boundingBox.bottom * scaleY),
          Offset(size.width - (face.boundingBox.left * scaleX ) , (face.boundingBox.bottom - (face.boundingBox.bottom - face.boundingBox.top) / 8) * scaleY),
          paint,
        );
        // Right bottom bottom
        canvas.drawLine(
          Offset(size.width - (face.boundingBox.left * scaleX) , face.boundingBox.bottom * scaleY ),
          Offset(size.width - (face.boundingBox.left - (face.boundingBox.left - face.boundingBox.right) / 8) * scaleX, face.boundingBox.bottom * scaleY ),
          paint,
        );

        // Left side top
        canvas.drawLine(
          Offset(size.width - (face.boundingBox.right * scaleX) , face.boundingBox.top * scaleY),
          Offset(size.width - (face.boundingBox.right * scaleX ) , (face.boundingBox.top + (face.boundingBox.bottom - face.boundingBox.top) / 8) * scaleY),
          paint,
        );
        // Left top top
        canvas.drawLine(
          Offset(size.width - (face.boundingBox.right * scaleX) , face.boundingBox.top * scaleY ),
          Offset(size.width - (face.boundingBox.right - (face.boundingBox.right - face.boundingBox.left) / 8) * scaleX, face.boundingBox.top * scaleY ),
          paint,
        );
        // Left side bottom
        canvas.drawLine(
          Offset(size.width - (face.boundingBox.right * scaleX) , face.boundingBox.bottom * scaleY),
          Offset(size.width - (face.boundingBox.right * scaleX ) , (face.boundingBox.bottom - (face.boundingBox.bottom - face.boundingBox.top) / 8) * scaleY),
          paint,
        );
        // Left bottom bottom
        canvas.drawLine(
          Offset(size.width - (face.boundingBox.right * scaleX), face.boundingBox.bottom * scaleY ),
          Offset(size.width - (face.boundingBox.right - (face.boundingBox.right - face.boundingBox.left) / 8) * scaleX, face.boundingBox.bottom * scaleY ),
          paint,
        );

        String name = '';
        String company = '';
        List<String> labelSplit = label.split(' - ');
        if(labelSplit.length > 1) {
          // print('labelSplit ${labelSplit}');
          name = labelSplit[0];
          company = labelSplit[1];
          TextSpan span = new TextSpan(
              children: [
                TextSpan(
                    style: new TextStyle(color: Colors.redAccent, fontSize: ((face.boundingBox.right - face.boundingBox.left) / 12) * scaleY),
                    text: name),
                TextSpan(
                    style: new TextStyle(color: Colors.redAccent, fontSize: ((face.boundingBox.right - face.boundingBox.left) / 12) * scaleY),
                    text: '\n' + company),
              ]);
          TextPainter textPainter = new TextPainter(
              text: span,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr);
          textPainter.layout();
          textPainter.paint(
              canvas,
              new Offset(size.width - (face.boundingBox.right) * scaleX, (face.boundingBox.top - (face.boundingBox.right - face.boundingBox.left) / 4) * scaleY ));
        } else {
          name = label;
          TextSpan span = new TextSpan(
              style: new TextStyle(color: Colors.redAccent, fontSize: ((face.boundingBox.right - face.boundingBox.left) / 12) * scaleY),
              text: name);
          TextPainter textPainter = new TextPainter(
              text: span,
              textAlign: TextAlign.left,
              textDirection: TextDirection.ltr);
          textPainter.layout();
          textPainter.paint(
              canvas,
              new Offset(size.width - (face.boundingBox.right) * scaleX, (face.boundingBox.top - (face.boundingBox.right - face.boundingBox.left) / 8) * scaleY ));
        }

      }
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.results != results;
  }
}

RRect _scaleRect(
    {@required Rect rect,
    @required Size imageSize,
    @required Size widgetSize,
    double scaleX,
    double scaleY}) {
  return RRect.fromLTRBR(
      (widgetSize.width - rect.left.toDouble() * scaleX),
      rect.top.toDouble() * scaleY,
      widgetSize.width - rect.right.toDouble() * scaleX,
      rect.bottom.toDouble() * scaleY,
      Radius.circular(10));
}
