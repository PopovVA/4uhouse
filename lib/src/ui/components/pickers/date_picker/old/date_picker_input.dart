import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../date_picker.dart';

class DatePickerInput extends StatefulWidget {
  DatePickerInput({
    @required String this.initialValue,
    @required Function this.onDateTimeChanged,
    String this.minimumDate,
    String this.maximumDate,
    String this.minimumYear,
    String this.maximumYear,
  });

  final String initialValue;
  final Function onDateTimeChanged;
  final String minimumDate;
  final String maximumDate;
  final String minimumYear;
  final String maximumYear;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerInputState();
  }
}

class _DatePickerInputState extends State<DatePickerInput> {
  final formatter = DateFormat('dd.MM.yyyy');
  bool bottomSheetOpen = false;
  String value = 'Choose a date';

  @override
  initState() {
    if (widget.initialValue is String) {
      value = timestampToString(
        DateTime.parse(widget.initialValue).millisecondsSinceEpoch,
      );
    }
    super.initState();
  }

  timestampToString(int timestamp) {
    return formatter.format(
      DateTime.fromMillisecondsSinceEpoch(timestamp),
    );
  }

  handleDateTimeChanged(int timestamp) {
    setState(() {
      value = timestampToString(timestamp);
    });
  }

  openBottomSheet(BuildContext context) async {
    setState(() {
      bottomSheetOpen = true;
    });
    await showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return DatePicker(
          minimumDate: DateTime(2013, 5, 10),
          maximumDate: DateTime.now(),
          onDateTimeChanged: handleDateTimeChanged, initialDateTime: null,
        );
      },
    );
    setState(() {
      bottomSheetOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        openBottomSheet(context);
      },
      child: Container(
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subhead,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: bottomSheetOpen
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).unselectedWidgetColor,
              width: bottomSheetOpen ? 2.0 : 1.0,
            ),
          ),
        ),
        width: double.infinity,
        padding: EdgeInsets.only(top: 8.0, bottom: bottomSheetOpen ? 7.0 : 8.0),
      ),
    );
  }
}
