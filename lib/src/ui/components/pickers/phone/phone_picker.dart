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
        @required this.isValid,
        @required this.phoneController});

  final List<CountryPhoneData> favorites;
  final List<CountryPhoneData> countryPhoneDataList;
  final Function onSelected;
  final CountryPhoneData itemByIp;
  final TextEditingController phoneController;
  final Function isValid;
  CountryPhoneData selectedItem;

  @override
  _PhonePickerState createState() => _PhonePickerState();
}

class _PhonePickerState extends State<PhonePicker> {
  TextEditingController codeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    codeController.text = '+ (${_buildDataItem().code.toString()})';
    widget.phoneController.addListener(_phoneListener);
  }

  @override
  void didChangeDependencies() {
    if (widget.selectedItem == null && widget.countryPhoneDataList != null) {
      setState(() {
        print(
            '===> widget.countryPhoneDataList[0]: ${widget.countryPhoneDataList[0].countryId}');
        widget.selectedItem = _buildDataItem();
      });
    }
    super.didChangeDependencies();
  }

  void _phoneListener() {
    if (widget.onSelected is Function) {
      widget.onSelected(
          widget.isValid(), widget.selectedItem, widget.phoneController.text);
    }
  }

  CountryPhoneData _findItemById(List<CountryPhoneData> list) {
    return list.firstWhere(
            (CountryPhoneData item) =>
        item.countryId == widget.selectedItem.countryId,
        orElse: () => null);
  }

  CountryPhoneData _buildDataItem() {
    if (widget.selectedItem == null) {
      if (widget.itemByIp == null) {
        return widget.favorites.isNotEmpty
            ? widget.favorites.first
            : widget.countryPhoneDataList.first;
      } else {
        return widget.itemByIp;
      }
    } else {
      final CountryPhoneData favItem = _findItemById(widget.favorites);
      return favItem == null
          ? _findItemById(widget.countryPhoneDataList) == null
          ? widget.selectedItem
          : _findItemById(widget.countryPhoneDataList)
          : favItem;
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
                widget.onSelected(widget.isValid(), result,
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
            hintText: _buildDataItem().example.toString(),
            borderColor: widget.isValid()
                ? Theme
                .of(context)
                .primaryColor
                : Colors.redAccent,
            keyboardType: TextInputType.number,
          ),
        ),
      ),
    ]);
  }
}
