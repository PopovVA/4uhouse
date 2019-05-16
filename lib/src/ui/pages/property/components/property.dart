import 'package:flutter/material.dart';

import '../../../../models/property_model.dart' show PropertyModel;

import 'property_footer.dart' show PropertyFooter;
import 'property_image.dart' show PropertyImage;

class Property extends StatelessWidget {
  Property._(PropertyModel property, {this.makeTransition, GlobalKey key})
      : this.property = property,
        this.id = property.id,
        this._key = key,
        super(key: key);

  factory Property(PropertyModel property, {Function makeTransition}) {
    return Property._(property,
        makeTransition: makeTransition, key: GlobalKey());
  }

  final PropertyModel property;
  final Function makeTransition;
  final String id;
  final GlobalKey _key;

  get key => _key;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (makeTransition is Function) {
            makeTransition(context, property.id);
          }
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PropertyImage(
                  id: property.id,
                  picture: property.picture,
                  statusColor: property.statusColor,
                  statusValue: property.statusValue),
              PropertyFooter(
                currency: property.currency,
                costSale: property.costSale,
                costRent: property.costRent,
                paymentPeriod: property.paymentPeriod,
                mainInfo: property.mainInfo,
                address: property.address,
              ),
              Container( height: 4.0),
            ],
          ),
        ));
  }
}
