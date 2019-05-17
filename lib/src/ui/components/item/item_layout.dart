import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../typography.dart' show ACTIVE_COLOR, DISABLED_COLOR;
import '../../../utils/type_check.dart' show isNotNull;
import 'item_layout_container.dart';

class ItemLayout extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ItemLayout({
    this.picture,
    this.body,
    this.suffix,
    this.link = false,
    this.onTap,
    this.disabled = false,
  });
  final String picture;
  final String body;
  final dynamic suffix;
  final bool link;
  final Function onTap;
  final bool disabled;



  Widget _buildPicture() {
    if (picture is String) {
      return Container(
        margin: const EdgeInsets.only(right: 8.0),
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

 // ignore: always_declare_return_types
 _buildTextContent(BuildContext context) {
    if (body is String) {
      return Expanded(
        flex: 3,
        child: Container(
          child: renderText(body),
        ),
      );
    }
  }

  // ignore: always_declare_return_types
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

  // ignore: always_declare_return_types
  _buildLink() {
    if (link) {
      return Icon(
        Icons.chevron_right,
        color: disabled ? DISABLED_COLOR : ACTIVE_COLOR,
      );
    }
  }

  // ignore: always_declare_return_types, always_specify_types
  renderText(value) {
    if (!(value is StatefulWidget) && !(value is StatelessWidget)) {
      const double fontSize = 16.0;
      return Text(
        isNotNull(value) ? value.toString() : '--',
        style: disabled
            ? const TextStyle(fontSize: fontSize, color: ACTIVE_COLOR)
            : const TextStyle(fontSize: fontSize, color: DISABLED_COLOR),
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
