import 'package:flutter/material.dart';
import 'drawer/drawer.dart' show DrawerOnly;

class PageTemplateDrawer extends StatelessWidget {
  const PageTemplateDrawer({
    this.title,
    this.note,
    this.body,
    this.padding = false,
  });

  static const Color color = Color(0xFF585555);
  static const double height = 68.0;

  final String title;
  final String note;
  final Widget body;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFe9e7e7),
        iconTheme: const IconThemeData(color: color),
        centerTitle: true,
        title:
            Text(title, style: const TextStyle(color: color, fontSize: 20.0)),
      ),
      drawer: DrawerOnly(),
      body: Container(
        child: body,
      ),
    );
  }
}
