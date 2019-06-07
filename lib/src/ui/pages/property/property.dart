import 'package:flutter/material.dart';

import '../../../../temp/room_bs64.dart' show RoomBs64;
import '../../../models/screen/components/property_model.dart'
    show PropertyModel;
import '../../components/common/page_template.dart';
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
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0)),
                          border: Border.all(
                              width: 0.1,
                              style: BorderStyle.solid,
                              color: Colors.black.withOpacity(0.3)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 0.5,
                                offset: const Offset(0.0, 2.0))
                          ]),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: PropertyCard(PropertyModel.fromJson(_getMapData(
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
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 6.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30.0)),
                          border: Border.all(
                              width: 0.1,
                              style: BorderStyle.solid,
                              color: Colors.black.withOpacity(0.3)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 0.5,
                                offset: const Offset(0.0, 2.0))
                          ]),
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0))),
                        child: PropertyCard(PropertyModel.fromJson(_getMapData(
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
                      ),
                    )
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
