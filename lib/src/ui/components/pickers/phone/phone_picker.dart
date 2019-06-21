import 'package:flutter/material.dart';
import '../../../../../temp/styled_text_controler.dart';

import '../../../../models/phone/country_phone_data.dart';

import '../../../components/styled/styled_text_field.dart' show StyledTextField;
import 'phone_search.dart';

class PhonePicker extends StatefulWidget {
  PhonePicker(
      {this.favorites,
        @required this.countryPhoneDataList,
        @required this.onSelected,
        @required this.selectedItem,
        @required this.itemByIp,
        @required this.phoneController});

  final List<CountryPhoneData> favorites;
  final List<CountryPhoneData> countryPhoneDataList;
  final Function onSelected;
  final CountryPhoneData itemByIp;
  final TextEditingController phoneController;
  CountryPhoneData selectedItem;

  @override
  _PhonePickerState createState() => _PhonePickerState();
}

class _PhonePickerState extends State<PhonePicker> {
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    codeController.text = '+ (${_buildDefaultCode()})';
    widget.phoneController.addListener(_phoneListener);
  }

  @override
  void didChangeDependencies() {
    if (widget.selectedItem == null && widget.countryPhoneDataList != null) {
      setState(() {
        print(
            '===> widget.countryPhoneDataList[0]: ${widget.countryPhoneDataList[0].countryId}');
        widget.selectedItem = widget.itemByIp == null
            ? widget.countryPhoneDataList[0]
            : widget.itemByIp;
      });
    }
    super.didChangeDependencies();
  }

  void _phoneListener() {
    if (widget.onSelected is Function) {
      widget.onSelected(
          _isValid(), widget.selectedItem, widget.phoneController.text);
    }
  }

  bool _isValid() {
    return widget.phoneController.text.isNotEmpty &&
        widget.selectedItem != null &&
        _validLength(
            widget.selectedItem.length, widget.phoneController.text.length) &&
        hasMatch(
            widget.phoneController.text, widget.selectedItem.numberPattern);
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

  CountryPhoneData _findItem() {
    final CountryPhoneData foundItem = widget.countryPhoneDataList.firstWhere(
            (CountryPhoneData item) =>
        item.countryId == widget.selectedItem.countryId,
        orElse: () => null);
    if (foundItem != null) {
      return foundItem;
    } else {
      return widget.favorites.firstWhere((CountryPhoneData item) =>
      item.countryId == widget.selectedItem.countryId);
    }
  }

  String _buildDefaultPhone() {
    if (widget.selectedItem == null) {
      if (widget.itemByIp == null) {
        return widget.favorites.isNotEmpty
            ? widget.favorites.first.example.toString()
            : widget.countryPhoneDataList.first.example.toString();
      } else {
        return widget.itemByIp.example.toString();
      }
    } else {
      return _findItem().example.toString();
    }
  }

  String _buildDefaultCode() {
    if (widget.selectedItem == null) {
      if (widget.itemByIp == null) {
        return widget.favorites.isNotEmpty
            ? widget.favorites.first.code.toString()
            : widget.countryPhoneDataList.first.code.toString();
      } else {
        return widget.itemByIp.code.toString();
      }
    } else {
      return _findItem().code.toString();
    }
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
              widget.selectedItem = result;
              codeController.text =
              '+ (${widget.selectedItem.code.toString()})';
              if (widget.onSelected is Function) {
                widget.onSelected(_isValid(), widget.selectedItem,
                    widget.phoneController.text);
              }
            }
          });
        },
      ),
      Expanded(
        child: Container(
          padding: const EdgeInsets.only(left: 12.0),
          child: StyledTextField(
            autofocus: true,
            controller: widget.phoneController,
            hintText: _buildDefaultPhone(),
            borderColor:
            _isValid() ? Theme
                .of(context)
                .primaryColor : Colors.redAccent,
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    ]);
  }
}
