import 'package:flutter/material.dart';
import '../../../../temp/room_bs64.dart';
import '../../../models/property_model.dart' show PropertyModel;
import '../../components/common/page_template.dart';
import 'components/property_card_body.dart' show PropertyCard;
import 'components/property_header.dart';
import 'components/property_info.dart';

class AddProperty extends StatelessWidget {
  final String _roomBs64 = RoomBs64().room_bs64();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: 'Add a property',
        body: Container(
            color: Colors.white,
            child: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(right: 16.0, left: 16.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: const Header(
                            id: '01123',
                            date: '12.12.19',
                            initialDate: '#inital property data',
                            inputProperty: 'input initial property'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 22.0),
                        child: PropertyInfo(
                            renta: r'Renta: $_____/month',
                            sale: r'Sale: $_____'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            const Text(
                              'property process',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 3.0)),
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.only(top: 10.0, left: 8.0),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: const Color.fromRGBO(
                                          66, 65, 65, 0.38),
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: const Color(0xFFEBECED),
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
            ))));
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
