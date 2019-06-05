import 'package:flutter/material.dart';
import '../../../models/country_phone_data.dart';
import 'phone_search.dart';

class PhonePicker extends StatefulWidget {
  PhonePicker(
      {this.favorites,
      @required this.countryPhoneDataList,
      @required this.onSelected});

  final List<String> favorites;
  final List<CountryPhoneData> countryPhoneDataList;
  final Function onSelected;

  @override
  _PhonePickerState createState() => _PhonePickerState();
}

class _PhonePickerState extends State<PhonePicker> {
  TextEditingController phone = TextEditingController();
  bool validPhone = false;
  CountryPhoneData selectedItem;

  void _phoneListner() {
    setState(() {
      if (phone.text.isEmpty) {
        validPhone = false;
      } else if (selectedItem != null) {
        if (selectedItem.length[0] == phone.text.length) {
          validPhone = false;
        } else if (hasMatch(phone.text, selectedItem.numberPattern)) {
          validPhone = true;
        } else {
          validPhone = false;
        }
      } else {
        if (widget.countryPhoneDataList.first.length[0] == phone.text.length) {
          validPhone = false;
        } else if (hasMatch(
            phone.text, widget.countryPhoneDataList.first.numberPattern)) {
          validPhone = true;
        } else {
          validPhone = false;
        }
      }
    });
  }

  bool hasMatch(String value, String reg) {
    RegExp regExp = RegExp(reg);
    return regExp.hasMatch(value);
  }

  @override
  void initState() {
    super.initState();
    phone.addListener(_phoneListner);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 14.0),
        width: 70.0,
        child: TextField(
            enableInteractiveSelection: true,
            cursorWidth: 0.0,
            autofocus: false,
            textAlign: TextAlign.left,
            decoration: InputDecoration.collapsed(
                hintText: selectedItem == null
                    ? '+(${widget.countryPhoneDataList[0].code.toString()})'
                    : '+(${selectedItem.code.toString()})',
                hintStyle:
                    const TextStyle(color: Color(0xde000000), fontSize: 16.0),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.0, color: const Color(0x0fffffff)))),
            onTap: () async {
              final result = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    onSelected:
                        (close(BuildContext context, CountryPhoneData item)) {},
                    favorites: widget.favorites,
                    countryPhoneDataList: widget.countryPhoneDataList),
              );
              setState(() {
                selectedItem = result;
                phone.text = '';
              });
            }),
      ),
      Container(
        padding: const EdgeInsets.only(left: 12.0),
        width: 260,
        child: TextField(
          maxLength: selectedItem == null
              ? widget.countryPhoneDataList[0].length[0]
              : selectedItem.length[0],
          autofocus: true,
          controller: phone,
          onChanged: (String val) {
            return widget.onSelected is Function && selectedItem != null
                ? widget.onSelected(validPhone)
                : null;
          },
          style: const TextStyle(fontSize: 16.0, color: Color(0xde000000)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration.collapsed(
              hintText: selectedItem == null
                  ? widget.countryPhoneDataList[0].example.toString()
                  : selectedItem.example.toString(),
              hintStyle:
                  const TextStyle(color: Color(0xde000000), fontSize: 16.0),
              border: UnderlineInputBorder(
                  borderSide:
                      BorderSide(width: 1.0, color: const Color(0x0fffffff)))),
        ),
      )
    ]);
  }
}
