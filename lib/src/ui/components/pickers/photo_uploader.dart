import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../pallete.dart' show primaryColor;
import 'generic/open_modal_bottom.dart' show openModalBottom;

openPhotoUploader(BuildContext context, {Function onLoad}) async {
  return openModalBottom(
    context: context,
    child: _Uploader(onLoad: onLoad),
  );
}

class _UploaderButton extends StatelessWidget {
  _UploaderButton({@required this.onTap, @required this.title});

  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: <Widget>[
          Container(
            height: 48.0,
            child: Center(
              child: title is String
                  ? Text(title,
                      style:
                          TextStyle(fontSize: 16.0, color: primaryColor[500]))
                  : null,
            ),
          ),
          Divider(height: 2.0),
        ],
      ),
    );
  }
}

class _Uploader extends StatelessWidget {
  _Uploader({@required this.onLoad});

  final Function onLoad;

  Future chooseImage(BuildContext context, String type) async {
    var source;

    switch (type) {
      case 'take':
        source = ImageSource.camera;
        break;
      case 'choose':
        source = ImageSource.gallery;
        break;
    }

    File photo = await ImagePicker.pickImage(source: source, maxWidth: 640);
    if (photo != null) {
      Navigator.of(context).pop();
      onLoad(photo);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _UploaderButton(
              title: 'Take Photo',
              onTap: () {
                chooseImage(context, 'take');
              }),
          _UploaderButton(
              title: 'Choose Photo',
              onTap: () {
                chooseImage(context, 'choose');
              }),
        ],
      ),
      padding: EdgeInsets.only(bottom: 12.0),
    );
  }
}
