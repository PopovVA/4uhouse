import 'package:flutter/material.dart';
import '../../../models/country_phone_data.dart';
import '../../../utils/route_transition.dart' show SlideRoute;
import 'phone_search.dart';

class PhonePicker extends StatefulWidget {
  PhonePicker({this.favorites, @required this.rest});

  List<String> favorites;
  List<CountryPhoneData> rest;

  bool _validPhone = false;
  final TextEditingController _phone = TextEditingController();

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
        margin: const EdgeInsets.only(left: 12.0),
        width: 100.0,
        child: TextField(
            decoration: InputDecoration.collapsed(
                hintText: '+${widget.rest[0].code.toString()}',
                hintStyle:
                    const TextStyle(color: Color(0xde000000), fontSize: 16.0),
                border: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.0, color: const Color(0x0fffffff)))),
            onTap: () => showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(
                      favorites: widget.favorites, rest: widget.rest),
                )),
      ),
      Container(
        padding: const EdgeInsets.only(left: 12.0),
        width: 240,
        child: TextField(
          controller: widget._phone,
          style: const TextStyle(fontSize: 16.0, color: Color(0xde000000)),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration.collapsed(
              hintText: widget.rest[0].example.toString(),
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
