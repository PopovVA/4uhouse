import 'package:flutter/material.dart';

import '../../../models/screen/components/property_model.dart'
    show PropertyModel;

import 'property_footer.dart' show PropertyFooter;
import 'property_image.dart' show PropertyImage;

class Property extends StatelessWidget {
  factory Property(PropertyModel property, {Function makeTransition}) {
    return Property._(property,
        makeTransition: makeTransition, key: GlobalKey());
  }

  Property._(PropertyModel property, {this.makeTransition, GlobalKey key})
      // ignore: prefer_initializing_formals
      : property = property,
        id = property.id,
        _key = key,
        super(key: key);

  final PropertyModel property;
  final Function makeTransition;
  final String id;
  final GlobalKey _key;

  @override
  // ignore: always_declare_return_types
  get key => _key;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: property.isTransition
          ? () {
              if (makeTransition is Function) {
                makeTransition(context, property.id);
              }
            }
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PropertyImage(
              id: property.id,
              picture: property.picture,
              statusColor: property.statusColor,
              statusValue: property.statusValue),
          PropertyFooter(
            isInput: property.isInput,
            currency: property.currency,
            costSale: property.costSale,
            costRent: property.costRent,
            paymentPeriod: property.paymentPeriod,
            mainInfo: property.mainInfo,
            address: property.address,
          ),
          Container(color: const Color(0xFF91cdcdcd), height: 4.0),
        ],
      ),
    );
  }
}
