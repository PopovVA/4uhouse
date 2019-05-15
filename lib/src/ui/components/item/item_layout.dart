import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'item_layout_container.dart';
import '../../../typography.dart' show ACTIVE_COLOR, DISABLED_COLOR;
import '../../../utils/type_check.dart' show isNotNull;

class ItemLayout extends StatelessWidget {
  final String picture;
  final String body;
  final dynamic suffix;
  final bool link;
  final Function onTap;
  final bool disabled;

  ItemLayout({
    this.picture,
    this.body,
    this.suffix,
    this.link = false,
    this.onTap,
    this.disabled = false,
  });

  _buildPicture() {
    if (picture is String) {
      return Container(
        margin: EdgeInsets.only(right: 8.0),
        child: Center(
          child: picture.startsWith('<svg')
              ? SvgPicture.string(picture)
              : Image.memory(
                  base64Decode(picture),
                ),
        ),
      );
    }

    return null;
  }

  _buildTextContent(context) {
    if (body is String) {
      return Expanded(
        flex: 3,
        child: Container(
          child: renderText(body),
        ),
      );
    }
  }

  _buildSuffix() {
    if (isNotNull(suffix)) {
      return Expanded(
        flex: 1,
        child: Center(
          child: renderText(suffix),
        ),
      );
    }
  }

  _buildLink() {
    if (link) {
      return Icon(
        Icons.chevron_right,
        color: disabled ? DISABLED_COLOR : ACTIVE_COLOR,
      );
    }
  }

  renderText(value) {
    if (!(value is StatefulWidget) && !(value is StatelessWidget)) {
      const fontSize = 16.0;
      return Text(
        isNotNull(value) ? value.toString() : '--',
        style: disabled
            ? TextStyle(fontSize: fontSize, color: ACTIVE_COLOR)
            : TextStyle(fontSize: fontSize, color: DISABLED_COLOR),
      );
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    return ItemLayoutContainer(
      Row(
        children: <Widget>[
          _buildPicture(),
          _buildTextContent(context),
          _buildSuffix(),
          _buildLink(),
        ].where(isNotNull).toList(),
      ),
      onTap: onTap,
    );
  }
}
