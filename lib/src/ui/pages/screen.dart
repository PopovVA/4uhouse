import 'package:flutter/material.dart';

import '../../constants/layout.dart' show standardPadding;

import '../../models/button_model.dart';
import '../../models/item_model.dart';
import '../../models/note_model.dart';
import '../../models/property_model.dart';
import '../../models/screen_model.dart';
import '../../blocs/screen_bloc.dart';

import '../components/common/button.dart';
import '../components/common/circular_progress.dart';
import '../components/item/item.dart';
import '../components/note.dart';
import 'package:provider_mobile/src/ui/components/pickers/property/property.dart';
import 'package:provider_mobile/src/ui/components/common/page_template.dart';

class Screen extends StatefulWidget {
  final String route;
  ScrollController scrollController;
  double prevScrollPosition;
  double initialScrollPosition;

  Screen(this.route, {Map<String, dynamic> arguments}) {
    if (arguments != null) {
      this.prevScrollPosition = arguments['prevScrollPosition'];
      double initialScrollPosition = arguments['initialScrollPosition'];
      this.scrollController = ScrollController(
          initialScrollOffset:
              initialScrollPosition != null ? initialScrollPosition : 0.0);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _ScreenState();
  }
}

class _ScreenState extends State<Screen> {
  @override
  void initState() {
    bloc.fetchScreen(widget.route);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('---> route: ${widget.route}');
    return StreamBuilder(
      stream: bloc.screen,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return PageTemplate(
            body: buildComponents(snapshot),
            goBack: snapshot.data.path != null
                ? () {
                    print(
                        '===> widget.scrollController.position: ${widget.scrollController.position}');
                    String path = snapshot.data.path;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      snapshot.data.path.substring(0, path.lastIndexOf('/')),
                      (Route<dynamic> route) => false,
                      arguments: {
                        'initialScrollPosition': widget.prevScrollPosition,
                      },
                    );
                  }
                : null,
            title: snapshot.data.value,
          );
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        return Container(
          color: Colors.white,
          child: CircularProgress(),
        );
      },
    );
  }

  Widget buildComponents(AsyncSnapshot<ScreenModel> snapshot) {
    dynamic data = snapshot.data;
    if (data is ScreenModel) {
      List<dynamic> items = [];
      List<Button> buttons = [];
      data.components.forEach((dynamic component) {
        if (component is ItemModel) {
          items.add(Item(
            component,
            data.path,
            handleSendItemValue,
            makeTransition,
          ));
        } else if (component is NoteModel) {
          items.add(Note(component));
        } else if (component is PropertyModel) {
          items.add(Property(component, makeTransition: makeTransition));
        } else if (component is ButtonModel) {
          buttons.add(Button(
            component,
            data.path,
            handleSendItemValue,
          ));
        }
      });

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: ListView.builder(
                controller: widget.scrollController,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return items[index];
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: standardPadding),
            child: Column(
              children: buttons,
            ),
          ),
        ],
      );
    }

    return null;
  }

  makeTransition(context, id) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '${widget.route}${id is String ? '/$id' : ''}',
      (Route<dynamic> route) => false,
      arguments: {
        'prevScrollPosition': widget.scrollController.offset,
      },
    );
  }

  handleSendItemValue(String id, dynamic value, {dynamic body}) {
    return bloc.sendItemValue('${widget.route}/$id', value, body: body);
  }
}
