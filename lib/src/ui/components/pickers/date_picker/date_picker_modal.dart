import 'package:flutter/material.dart';

import 'date_picker.dart';
import '../generic/open_modal_bottom.dart' show openModalBottom;
import '../../../../utils/type_check.dart' show isNotNull;

DateTime _timestampToDateTime(timestamp) {
  if (timestamp is int) {
    DateTime ms = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return ms;
  }

  return null;
}

int _value;

openDatePicker(
  BuildContext context, {
  Function onDateTimeChanged,
  Function onOk,
  int initialDateTime,
  int minimumDate,
  int maximumDate,
  int minimumYear,
  int maximumYear,
}) async {
  initialDateTime = isNotNull(initialDateTime)
      ? initialDateTime
      : isNotNull(minimumDate)
          ? minimumDate
          : isNotNull(maximumDate)
              ? maximumDate
              : DateTime(2000, 1, 1).toLocal().millisecondsSinceEpoch;
  _value = initialDateTime;

  return openModalBottom(
    context: context,
    child: Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              if (onOk is Function) {
                print(
                    'timezone name ${DateTime.fromMillisecondsSinceEpoch(_value).timeZoneName}');
                onOk(_value);
              }
              _value = null;
              Future.delayed(Duration(milliseconds: 100), () {
                Navigator.pop(context);
              });
            },
            child: Text(
              'Done',
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Divider(),
          DatePicker(
            onDateTimeChanged: (int timestamp) {
              _value = timestamp;
              if (onDateTimeChanged is Function) {
                onDateTimeChanged(timestamp);
              }
            },
            initialDateTime: _timestampToDateTime(initialDateTime),
            minimumDate: _timestampToDateTime(minimumDate),
            maximumDate: _timestampToDateTime(maximumDate),
            minimumYear: minimumYear,
            maximumYear: maximumYear,
          ),
        ],
      ),
    ),
  );
}
