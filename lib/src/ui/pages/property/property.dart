import 'package:flutter/material.dart';

import '../../../../temp/room_bs64.dart' show RoomBs64;
import '../../../models/screen/components/property_model.dart'
    show PropertyModel;
import 'package:user_mobile/src/ui/components/page_template.dart';
import 'components/property_card_body.dart' show PropertyCard;

class AddProperty extends StatelessWidget {
  final String _roomBs64 = RoomBs64().roomBs64();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: 'Add a property',
        body: Container(
            color: const Color(0xFFEBECED),
            height: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                  child: Column(children: <Widget>[
                    PropertyCard(PropertyModel.fromJson(_getMapData(
                        '1',
                        _roomBs64,
                        'To Do',
                        '0xDEFFA726',
                        r'$',
                        250000,
                        8000,
                        'month',
                        '3 Bed, Apt',
                        'Paphos, Emba'))),
                    PropertyCard(PropertyModel.fromJson(_getMapData(
                        '2',
                        _roomBs64,
                        'To Do',
                        '0xDEFFA726',
                        r'$',
                        250000,
                        8000,
                        'month',
                        '3 Bed, Apt',
                        'Paphos, Emba'))),
                  ]),
                )
              ],
            )));
  }

  Map<String, dynamic> _getMapData(
      String id,
      String picture,
      String statusValue,
      String statusColor,
      String currency,
      int costSale,
      int costRent,
      String paymentPeriod,
      String mainInfo,
      String address) {
    return <String, Object>{
      'id': id,
      'picture': picture,
      'statusValue': statusValue,
      'statusColor': statusColor,
      'currency': currency,
      'costSale': costSale,
      'costRent': costRent,
      'paymentPeriod': paymentPeriod,
      'mainInfo': mainInfo,
      'address': address,
    };
  }
}
