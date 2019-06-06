import 'package:flutter/material.dart';
import '../../../../models/country_phone_data.dart';
import 'phone_search.dart';

class PhonePicker extends StatefulWidget {
  const PhonePicker(
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
  CountryPhoneData selectedItem;

  void _phoneListner() {
    if (widget.onSelected is Function) {
      widget.onSelected(_isValid(), selectedItem, phone.text);
    }
  }

  bool _isValid() {
    return phone.text.isNotEmpty &&
        selectedItem != null &&
        _validLength(selectedItem.length, phone.text.length) &&
        hasMatch(phone.text, selectedItem.numberPattern);
  }

  bool _validLength(List<int> lengthList, int length) {
    return lengthList.firstWhere((int item) => item == length,
                orElse: () => 0) >
            0
        ? true
        : false;
  }

  bool hasMatch(String value, String reg) {
    final RegExp regExp = RegExp(reg);
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
          child: InkWell(
              child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              width: 2.0,
                              color:
                                  const Color.fromRGBO(175, 173, 173, 0.4)))),
                  child: Text(
                      selectedItem == null
                          ? '+(${widget.countryPhoneDataList[0].code.toString()})'
                          : '+(${selectedItem.code.toString()})',
                      style: const TextStyle(
                          color: Color(0xde000000), fontSize: 16.0))),
              onTap: () async {
                final dynamic result = await showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      onSelected: (close(
                          BuildContext context, CountryPhoneData item)) {},
                      favorites: widget.favorites,
                      countryPhoneDataList: widget.countryPhoneDataList),
                );
                setState(() {
                  if (result != null) {
                    selectedItem = result;
                  }
                });
              })),
      Container(
        padding: const EdgeInsets.only(left: 12.0),
        width: 260,
        child: TextField(
          autofocus: true,
          controller: phone,
          style: const TextStyle(fontSize: 16.0, color: Color(0xde000000)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(0.0),
              hintText: selectedItem == null
                  ? widget.countryPhoneDataList[0].example.toString()
                  : selectedItem.example.toString(),
              hintStyle:
                  const TextStyle(color: Color(0x8a000000), fontSize: 16.0),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: const Color.fromRGBO(175, 173, 173, 0.4))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      width: 2.0,
                      color: _isValid()
                          ? Theme.of(context).primaryColor
                          : Colors.redAccent))),
        ),
      )
    ]);
  }
}
