import 'package:flutter/material.dart';

class StyledAlertDialog extends StatelessWidget {
  const StyledAlertDialog(
      {this.title = const Text(
        'Opps...',
        style: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(0, 0, 0, 0.87),
        ),
      ),
      @required this.content,
      this.actions});

  final Widget title;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          Align(
            alignment: FractionalOffset.center,
            child: Container(
                decoration:
                    BoxDecoration(color: Colors.white, boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 12,
                      offset: const Offset(0.0, 12.0))
                ]),
                width: 280,
                height: 120,
                child: Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: title),
                      content,
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: actions),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
