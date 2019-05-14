import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header(
      {@required this.id,
      @required this.date,
      this.initialDate,
      this.inputProperty});

  String id;
  String date;
  String initialDate;
  String inputProperty;

  static const List<String> _popUpChoiceList = ['edit', 'remove'];
  static const TextStyle _fontStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      color: Color.fromRGBO(0, 0, 0, 0.87));

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 15.0),
          child: Row(
            children: <Widget>[
              Text(
                id,
                style: _fontStyle,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
              ),
              Text(date, style: _fontStyle)
            ],
          ),
        ),
        Container(
          child: Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(initialDate, style: _fontStyle),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 167, 38, 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(40.0))),
                      ),
                      Padding(padding: EdgeInsets.only(left: 5.0)),
                      Text(inputProperty,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal,
                              color: Color.fromRGBO(0, 0, 0, 0.87)))
                    ],
                  )
                ],
              ),
              Container(
                child: PopupMenuButton<String>(
                    onSelected: _someAction,
                    itemBuilder: (BuildContext context) {
                      return _popUpChoiceList.map((String choice) {
                        return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                              style: _fontStyle,
                            ));
                      }).toList();
                    }),
              )
            ],
          ),
        )
      ],
    );
  }

  void _someAction(String choice) {
    print('Works');
  }
}
