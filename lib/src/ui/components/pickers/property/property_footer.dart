import 'package:flutter/material.dart';
import '../../../../utils/type_check.dart' show isNotNull;

class PropertyFooter extends StatelessWidget {
  static const Color fontColor = Color(0xFF212121);
  static const TextStyle addInfoStyle = TextStyle(fontSize: 14.0, color: fontColor);
  static const TextStyle mainValueStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: fontColor);

  PropertyFooter(
      {this.mainValue1, this.mainValue2, this.addInfo1, this.addInfo2});

  final String mainValue1;
  final String mainValue2;
  final String addInfo1;
  final String addInfo2;

  buildMainValue(String value, double padding) {
    if (value != null) {
      return Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: Text(value, style: mainValueStyle),
      );
    }

    return null;
  }

  buildAddInfo(String value, {bool addSeparator = false}) {
    if (value != null) {
      return Row(
        children: <Widget>[
          Text(value, style: addInfoStyle),
          addSeparator
              ? Padding(
                  padding: EdgeInsets.only(left: 23.0, right: 17.0),
                  child: Text('|', style: addInfoStyle),
                )
              : null,
        ].where(isNotNull).toList(),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildMainValue(mainValue1, 5.0),
          buildMainValue(mainValue2, 16.0),
          Row(
            children: <Widget>[
              buildAddInfo(addInfo1, addSeparator: true),
              buildAddInfo(addInfo2),
            ].where(isNotNull).toList(),
          ),
        ].where(isNotNull).toList(),
      ),
    );
  }
}
