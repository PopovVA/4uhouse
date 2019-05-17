import 'package:flutter/material.dart';
import '../../../utils/type_check.dart' show isNotNull;

class PropertyFooter extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  PropertyFooter(
      {this.currency,
        this.costSale,
        this.costRent,
        this.paymentPeriod,
        this.mainInfo,
        this.address});
  static const Color fontColor = Color(0xFF212121);
  static const TextStyle addInfoStyle =
      TextStyle(fontSize: 14.0, color: fontColor);
  static const TextStyle mainValueStyle =
      TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: fontColor);



  final String currency;
  final int costSale;
  final int costRent;
  final String paymentPeriod;
  final String mainInfo;
  final String address;

  // ignore: always_declare_return_types
  buildMainValue(int value, double padding,
      {bool includePaymentPeriod = false}) {
    Widget renderPaymentPeriod() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          const Text('/', style: mainValueStyle),
          Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(paymentPeriod, style:const  TextStyle(fontSize: 12.0))),
        ],
      );
    }

    if (value is int) {
      return Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: Row(
          children: <Widget>[
            Text('$currency ${value.toString()}', style: mainValueStyle),
            includePaymentPeriod ? renderPaymentPeriod() : null,
          ].where(isNotNull).toList(),
        ),
      );
    }

    return null;
  }

  // ignore: always_declare_return_types
  buildAddInfo(String value, {bool addSeparator = false}) {
    if (value is String) {
      return Row(
        children: <Widget>[
          Text(value, style: addInfoStyle),
          addSeparator
              ? const Padding(
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
      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildMainValue(costSale, 5.0),
          buildMainValue(costRent, 16.0, includePaymentPeriod: true),
          Row(
            children: <Widget>[
              buildAddInfo(mainInfo, addSeparator: true),
              buildAddInfo(address),
            ].where(isNotNull).toList(),
          ),
        ].where(isNotNull).toList(),
      ),
    );
  }
}
