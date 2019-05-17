import 'package:flutter/material.dart';
import '../../../components/common/page_template.dart';
import 'header.dart';
import 'property_info.dart';
import '../components/property.dart' show Property;
import '../../../../models/property_model.dart' show PropertyModel;
import '../../../../../temp/room_bs64.dart';

class AddProperty extends StatelessWidget {

  final String _roomBs64 = RoomBs64().room_bs64();

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: 'Add a property',
        body: Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                      renta: r'Renta: $_____/month', sale: r'Sale: $_____'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'property process',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontStyle: FontStyle.normal,
                            fontSize: 12),
                      ),
                      const Padding(padding: EdgeInsets.only(left: 3.0)),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10.0, left: 8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: const Color.fromRGBO(66, 65, 65, 0.38),
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 18.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFEBECED),
                        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
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
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30.0))),
                      child: Property(PropertyModel.fromJson(_getMapData(
                          '1',
                          _roomBs64,
                          'To Do',
                          '1',
                          r'$',
                          250000,
                          8000,
                          'month',
                          '3 Bed, Apt',
                          'Paphos, Emba'))),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(
                        color: const Color(0xFFEBECED),
                        borderRadius: const BorderRadius.all(Radius.circular(30.0)),
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
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(30.0))),
                      child: Property(PropertyModel.fromJson(_getMapData(
                          '2',
                          _roomBs64,
                          'To Do',
                          '1',
                          r'$',
                          250000,
                          8000,
                          'month',
                          '3 Bed, Apt',
                          'Paphos, Emba'))),
                    ),
                  )
                ])
              ],
            ))));
  }

  Map<String, dynamic> _getMapData(String id, String picture, String statusValue, String statusColor,
      String currency, int costSale, int costRent, String paymentPeriod, String mainInfo, String address) {
    return {
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
