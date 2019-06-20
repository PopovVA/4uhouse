import 'package:flutter/material.dart';
import '../../../../../temp/styled_text_controler.dart';

import '../../../../models/phone/country_phone_data.dart';

import '../../../components/styled/styled_text_field.dart' show StyledTextField;
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
  TextEditingController phoneController =
      NumberOnlyTextEditingController();
  TextEditingController codeController = TextEditingController();
  CountryPhoneData selectedItem;

  @override
  void initState() {
    super.initState();
    codeController.text =
        '+ (${widget.countryPhoneDataList[0].code.toString()})';
    phoneController.addListener(_phoneListener);
  }

  @override
  void didChangeDependencies() {
    if (selectedItem == null && widget.countryPhoneDataList != null) {
      setState(() {
        print(
            '===> widget.countryPhoneDataList[0]: ${widget.countryPhoneDataList[0].countryId}');
        selectedItem = widget.countryPhoneDataList[0];
      });
    }
    super.didChangeDependencies();
  }

  void _phoneListener() {
    if (widget.onSelected is Function) {
      widget.onSelected(_isValid(), selectedItem, phoneController.text);
    }
  }

  bool _isValid() {
    return phoneController.text.isNotEmpty &&
        selectedItem != null &&
        _validLength(selectedItem.length, phoneController.text.length) &&
        hasMatch(phoneController.text, selectedItem.numberPattern);
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
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      InkWell(
        child: Container(
            width: 70.0,
            child: IgnorePointer(
                child: StyledTextField(
              controller: codeController,
            ))),
        onTap: () async {
          final CountryPhoneData result = await showSearch(
            context: context,
            delegate: CustomSearchDelegate(
                onSelected:
                    (close(BuildContext context, CountryPhoneData item)) {},
                favorites: widget.favorites,
                countryPhoneDataList: widget.countryPhoneDataList),
          );
          setState(() {
            if (result != null) {
              selectedItem = result;
              codeController.text = '+ (${selectedItem.code.toString()})';
            }
          });
        },
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(left: 12.0),
          child: StyledTextField(
            autofocus: true,
            controller: phoneController,
            hintText: selectedItem == null
                ? widget.countryPhoneDataList[0].example.toString()
                : selectedItem.example.toString(),
            borderColor:
                _isValid() ? Theme.of(context).primaryColor : Colors.redAccent,
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    ]);
  }
}
