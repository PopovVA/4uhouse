import 'package:flutter/material.dart';
import 'dart:convert' show base64Decode;
import 'dart:typed_data' show Uint8List;

import '../../../../utils/type_check.dart' show isNotNull;

class PropertyImage extends StatelessWidget {
  PropertyImage._(
      {this.id,
      this.statusColor,
      this.statusValue,
      this.picture,
      this.pictureDecodingError});

  static const Radius radius = Radius.circular(3.0);

  factory PropertyImage(
      {String id, String statusColor, String statusValue, String picture}) {
    bool pictureDecodingError = false;
    Uint8List decodedPicture;
    if (picture != null) {
      try {
        decodedPicture = base64Decode(picture);
      } catch (error) {
        print('error');
        pictureDecodingError = true;
      }
    }

    return PropertyImage._(
      id: id,
      statusColor: statusColor,
      statusValue: statusValue,
      picture: decodedPicture,
      pictureDecodingError: pictureDecodingError,
    );
  }

  final String id;
  final String statusColor;
  final String statusValue;

  Uint8List picture;
  bool pictureDecodingError;

  buildImage() {
    Widget greyContainer({Widget child}) => Container(
          color: const Color(0xFFe9e9e9),
          child: child,
        );

    if (pictureDecodingError) {
      return greyContainer(
          child: Center(child: const Text('Error decoding image :(')));
    }

    if (picture != null) {
      return SizedBox.expand(
        child: Image.memory(
          picture,
          fit: BoxFit.fitWidth,
        ),
      );
    }

    return greyContainer();
  }

  buildStatus(double height) {
    if (statusValue != null) {
      return Positioned(
        right: 0.0,
        top: height * 0.085,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(int.parse(statusColor)),
                borderRadius: const BorderRadius.only(
                  topLeft: radius,
                  bottomLeft: radius,
                ),
              ),
              alignment: Alignment.center,
              height: 22.0,
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Text(statusValue,
                  style: const TextStyle(
                      fontSize: 14.0, color: Color(0xFFdeffffff))),
            ),
          ],
        ),
      );
    }

    return null;
  }

  buildPlaceholder(double height) {
    if (picture == null && !pictureDecodingError) {
      return Container(
        margin: EdgeInsets.only(top: height / 2, left: 16.0),
        child: const Text('Here will be your property',
            style: TextStyle(fontSize: 16.0, color: Color(0xFF1e1e1e))),
      );
    }

    return null;
  }

  buildId(double height) {
    if (id != null) {
      return Positioned(
        bottom: height * 0.039,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(3.0, 4.0, 12.0, 3.0),
              decoration: const BoxDecoration(
                color: Color(0xFFcccccc),
                borderRadius: BorderRadius.all(radius),
              ),
              margin: const EdgeInsets.only(left: 16.0),
              child: Text('#$id',
                  style: const TextStyle(fontSize: 10.0, color: Colors.white)),
            ),
          ],
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.width * 0.48;
    return Container(
      width: double.infinity,
      height: height,
      color: Colors.grey,
      margin: const EdgeInsets.only(bottom: 1.0),
      child: Stack(
        children: <Widget>[
          buildImage(),
          buildStatus(height),
          buildPlaceholder(height),
          buildId(height),
        ].where(isNotNull).toList(),
      ),
    );
  }
}
