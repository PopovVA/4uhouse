import 'package:flutter/material.dart';
import '../../../components/common/page_template.dart';
import 'header.dart';
import 'property_info.dart';

class AddProperty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
        title: 'Add a property',
        body: Container(
            margin: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Header(
                      id: '01123',
                      date: '12.12.19',
                      initialDate: '#inital property data',
                      inputProperty: 'input initial property'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 22.0),
                  child: PropertyInfo(
                      renta: r'Renta: $_____/month', sale: r'Sale: $_____'),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text('property process', style: TextStyle(fontWeight: FontWeight.normal, fontStyle: FontStyle.normal, fontSize: 12),),
                      Padding(padding: EdgeInsets.only(left: 3.0)),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: 14.0, left: 8.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromRGBO(66, 65, 65, 0.38),
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
            )));
  }
}
