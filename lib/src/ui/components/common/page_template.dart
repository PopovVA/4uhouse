import 'package:flutter/material.dart';
import 'package:user_mobile/src/ui/components/common/drawer/drawer.dart'
    show DrawerOnly;

class PageTemplate extends StatelessWidget {
  const PageTemplate({
    this.title,
    this.note,
    this.body,
    this.goBack,
    this.padding = false,
  });

  static const Color color = Color(0xFF585555);
  static const double height = 68.0;

  final String title;
  final String note;
  final Widget body;
  final Function goBack;
  final bool padding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFe9e7e7),
        iconTheme: const IconThemeData(color: color),
        leading: Navigator.canPop(context)
            ? IconButton(
                color: color,
                tooltip: 'go back',
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  return goBack is Function ? goBack() : Navigator.pop(context);
                })
            : null,
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
