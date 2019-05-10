import 'package:flutter/material.dart';

import '../../../../models/property_model.dart' show PropertyModel;

import 'property_footer.dart' show PropertyFooter;
import 'property_image.dart' show PropertyImage;

class Property extends StatelessWidget {
  Property(this.property, {this.makeTransition});

  final PropertyModel property;
  final Function makeTransition;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (makeTransition is Function) {
          makeTransition(context, property.id);
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          PropertyImage(
              id: property.id,
              picture: property.picture,
              statusColor: property.statusColor,
              statusValue: property.statusValue),
          PropertyFooter(
            mainValue1: property.mainValue1,
            mainValue2: property.mainValue2,
            addInfo1: property.addInfo1,
            addInfo2: property.addInfo2,
          ),
          Container(color: Color(0xFF91cdcdcd), height: 4.0),
        ],
      ),
    );
  }
}
