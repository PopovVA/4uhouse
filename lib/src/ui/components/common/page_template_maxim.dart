import 'package:flutter/material.dart';
import 'package:provider_mobile/temp/drawer_only.dart';
import '../../../constants/layout.dart' show standardPadding;

class PageTemplateMaxim extends StatelessWidget {
  static const Color color = Color(0xFF585555);
  static const double height = 64.0;

  final String title;
  final String note;
  final Widget body;
  final Function goBack;
  final bool padding;

  PageTemplateMaxim({
    this.title,
    this.note,
    this.body,
    this.goBack,
    this.padding = false,
  });

  @override
  Widget build(BuildContext context) {
    double horizontalPadding = padding ? standardPadding : 0.0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFe9e7e7),
        bottom: (note is String)
            ? PreferredSize(
                preferredSize: Size.fromHeight(54.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFb5ffc5c5),
                    border: Border.all(
                      color: Color(0xFFecc3c3),
                      width: 1.0,
                    ),
                  ),
                  width: double.infinity,
                  height: 54.0,
                  padding: EdgeInsets.fromLTRB(16.0, 6.0, 16.0, 30.0),
                  child: Text(
                    'Note',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Color(0xFFdeff0000),
                    ),
                  ),
                ),
              )
            : null,
        iconTheme: IconThemeData(color: color),
        leading: Navigator.canPop(context)
            ? IconButton(
                color: color,
                tooltip: 'go back',
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  return goBack is Function ? goBack() : Navigator.pop(context);
                })
            : null,
        centerTitle: true,
        title: Text(title, style: TextStyle(color: color, fontSize: 20.0)),
      ),
      drawer: DrawerOnly(),
      body: Container(
        padding: EdgeInsets.fromLTRB(
            horizontalPadding, 0.0, horizontalPadding, standardPadding),
        child: body,
      ),
    );
  }
}
