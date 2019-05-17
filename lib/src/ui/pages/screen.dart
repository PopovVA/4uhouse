import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../blocs/screen_bloc.dart';
import '../../constants/layout.dart' show standardPadding;

import '../../models/button_model.dart';
import '../../models/item_model.dart';
import '../../models/note_model.dart';
import '../../models/property_model.dart';
import '../../models/screen_model.dart';

import '../components/common/button.dart';
import '../components/common/circular_progress.dart';
import '../components/common/page_template.dart';
import '../components/item/item.dart';
import '../components/note.dart';
import '../components/property/property.dart';

// ignore: must_be_immutable
class Screen extends StatefulWidget {
  Screen(this.route, {Map<String, dynamic> arguments}) {
    if (arguments != null) {
      scrollToId = arguments['scrollToId'];
    }
  }

  final String route;
  String scrollToId;
  final ScrollController scrollController = ScrollController();

  @override
  State<StatefulWidget> createState() {
    return _ScreenState();
  }
}

class _ScreenState extends State<Screen> {
  GlobalKey scrollItemKey;

  @override
  void initState() {
    bloc.fetchScreen(widget.route);
    super.initState();
  }

  void scrollToItem(GlobalKey key) {
    if (key != null) {
      Scrollable.ensureVisible(key.currentContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('---> route: ${widget.route}');
    return StreamBuilder<ScreenModel>(
      stream: bloc.screen,
      builder: (BuildContext context, AsyncSnapshot<ScreenModel> snapshot) {
        if (snapshot.hasData) {
          return PageTemplate(
            body: buildComponents(snapshot),
            goBack: snapshot.data.path != null
                ? () {
                    final String path = snapshot.data.path;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      path.substring(0, path.lastIndexOf('/')),
                      (Route<dynamic> route) => false,
                      // ignore: always_specify_types
                      arguments: {
                        'scrollToId': widget.route
                            .substring(widget.route.lastIndexOf('/') + 1),
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
          child: const CircularProgress(),
        );
      },
    );
  }

  Widget buildComponents(AsyncSnapshot<ScreenModel> snapshot) {
    final dynamic data = snapshot.data;
    if (data is ScreenModel) {
      final List<Widget> items = <Widget>[];
      final List<Button> buttons = <Button>[];
      // ignore: avoid_function_literals_in_foreach_calls
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

      if (widget.scrollToId is String) {
        final dynamic scrollItemList = items
            .where((dynamic item) => item.id == widget.scrollToId)
            .toList();
        scrollItemKey = scrollItemList.isEmpty ? null : scrollItemList[0].key;
        SchedulerBinding.instance
            .addPostFrameCallback((_) => scrollToItem(scrollItemKey));
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                controller: widget.scrollController,
                child: Column(
                  children: items,
                ),
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

  void makeTransition(BuildContext context, String id) {
    Navigator.of(context).pushNamedAndRemoveUntil(
      '${widget.route}${id is String ? '/$id' : ''}',
      (Route<dynamic> route) => false,
    );
  }

  Screen handleSendItemValue(String id, dynamic value, {dynamic body}) {
    return bloc.sendItemValue('${widget.route}/$id', value, body: body);
  }
}
