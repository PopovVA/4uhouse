import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../pallete.dart' show primaryColor;
import 'generic/open_modal_bottom.dart' show openModalBottom;

Future<Widget> openPhotoUploader(BuildContext context,
    {Function onLoad}) async {
  return openModalBottom(
    context: context,
    child: _Uploader(onLoad: onLoad),
  );
}

class _UploaderButton extends StatelessWidget {
  const _UploaderButton({@required this.onTap, @required this.title});

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
          const Divider(height: 2.0),
        ],
      ),
    );
  }
}

class _Uploader extends StatelessWidget {
  const _Uploader({@required this.onLoad});

  final Function onLoad;

  // ignore: always_specify_types
  Future chooseImage(BuildContext context, String type) async {
    // ignore: prefer_typing_uninitialized_variables, always_specify_types
    var source;

    switch (type) {
      case 'take':
        source = ImageSource.camera;
        break;
      case 'choose':
        source = ImageSource.gallery;
        break;
    }

    final Future<File> cb =
        ImagePicker.pickImage(source: source, maxWidth: 640);
    Navigator.of(context).pop();
    onLoad(cb);
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
      padding: const EdgeInsets.only(bottom: 12.0),
    );
  }
}
