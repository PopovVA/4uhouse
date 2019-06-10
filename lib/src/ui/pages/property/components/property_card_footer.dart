import 'package:flutter/material.dart';
import '../../../../typography.dart';
import '../../../../utils/type_check.dart' show isNotNull;

class PropertyFooter extends StatelessWidget {
  const PropertyFooter({this.isInput,
    this.currency,
      this.costSale,
      this.costRent,
      this.paymentPeriod,
      this.mainInfo,
      this.address});

  final bool isInput;
  final String currency;
  final int costSale;
  final int costRent;
  final String paymentPeriod;
  final String mainInfo;
  final String address;

  TextStyle getTextStyle(String text) {
    switch (text) {
      case 'addInfoStyle':
        return TextStyle(
            fontSize: 14.0, color: isInput&&isInput!=null ? ACTIVE_COLOR : DISABLED_COLOR);

        break;
      default:
        return TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
            color: isInput&&isInput!=null? ACTIVE_COLOR : DISABLED_COLOR);
    }
  }

  Widget buildMainValue(int value, double padding,
      {bool includePaymentPeriod = false}) {
    Widget renderPaymentPeriod() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text('/', style: getTextStyle('mainValueStyle')),
          Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(paymentPeriod,
                  style: TextStyle(
                      fontSize: 12.0,
                      color:isInput&&isInput!=null? ACTIVE_COLOR : DISABLED_COLOR))),
        ],
      );
    }

    if (value is int) {
      return Padding(
        padding: EdgeInsets.only(bottom: padding),
        child: Row(
          children: <Widget>[
            Text('$currency ${value.toString()}',
                style: getTextStyle('mainValueStyle')),
            includePaymentPeriod ? renderPaymentPeriod() : null,
          ].where(isNotNull).toList(),
        ),
      );
    }

    return null;
  }

  Widget buildAddInfo(String value, {bool addSeparator = false}) {
    if (value is String) {
      return Row(
        children: <Widget>[
          Text(value, style: getTextStyle('addInfoStyle')),
          addSeparator
              ? Padding(
            padding: const EdgeInsets.only(left: 23.0, right: 17.0),
            child: Text('|', style: getTextStyle('addInfoStyle')),
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
          buildMainValue(costRent, 13.0, includePaymentPeriod: true),
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
