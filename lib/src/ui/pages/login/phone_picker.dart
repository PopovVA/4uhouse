import 'package:flutter/material.dart';
import '../../../../src/utils/route_transition.dart' show SlideRout;
import '../../../models/country_phone_data.dart';
import 'phone_search.dart';

class PhonePicker extends StatefulWidget {
  PhonePicker({this.favorites, @required this.rest, @required this.onSelected});

  List<String> favorites;
  List<CountryPhoneData> rest;
  final Function onSelected;
  final TextEditingController _phone = TextEditingController();
  CountryPhoneData _selectedItem;
  bool _validPhone;
  bool _defaultPhoneValue = true;

  @override
  _PhonePickerState createState() => _PhonePickerState();
}

class _PhonePickerState extends State<PhonePicker> {
  void _phoneListner() {
    setState(() {
      widget._phone.text.isNotEmpty
          ? widget._validPhone = true
          : widget._validPhone = false;
    });
  }

  @override
  void initState() {
    super.initState();
    widget._phone.addListener(_phoneListner);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Container(
        margin: const EdgeInsets.only(left: 14.0),
        width: 70.0,
        child: TextField(
            textAlign: TextAlign.left,
            decoration: InputDecoration.collapsed(
                hintText: widget._defaultPhoneValue
                    ? '+${widget.rest[0].code.toString()}'
                    : widget._selectedItem.code.toString(),
                hintStyle:
                    const TextStyle(color: Color(0xde000000), fontSize: 16.0),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.0, color: const Color(0x0fffffff)))),
//            Прежний вариант
//            onTap: () => showSearch(
//                  context: context,
//                  delegate: CustomSearchDelegate(
//                      onSelected: (CountryPhoneData item) {
//                        setState(() {
//                          widget._selectedItem = item;
//                          widget._defaultPhoneValue = false;
//                        });
//                      },
//                      favorites: widget.favorites,
//                      rest: widget.rest),
//                )
            onTap: () async {
              final result = await showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    onSelected:
                        (close(BuildContext context, CountryPhoneData item)) {},
                    favorites: widget.favorites,
                    rest: widget.rest),
              );
              setState(() {
                widget._selectedItem = result;
                widget._defaultPhoneValue = false;
              });
            }),
      ),
      Container(
        padding: const EdgeInsets.only(left: 12.0),
        width: 260,
        child: TextField(
          controller: widget._phone,
          style: const TextStyle(fontSize: 16.0, color: Color(0xde000000)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration.collapsed(
              hintText: widget._defaultPhoneValue
                  ? widget.rest[0].example.toString()
                  : widget._selectedItem.example.toString(),
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
