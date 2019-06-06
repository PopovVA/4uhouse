import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import '../../blocs/screen_bloc.dart' show ScreenBloc;
import '../../constants/layout.dart' show standardPadding;
import '../../models/screen/components/button_model.dart' show ButtonModel;
import '../../models/screen/components/item_model.dart' show ItemModel;
import '../../models/screen/components/note_model.dart' show NoteModel;
import '../../models/screen/components/property_model.dart' show PropertyModel;
import '../../models/screen/screen_model.dart' show ScreenModel;
import '../../resources/auth_repository.dart' show AuthRepository;
import '../../resources/screen_repository.dart' show ScreenRepository;
import '../components/common/button.dart' show Button;
import '../components/common/circular_progress.dart' show CircularProgress;
import '../components/common/page_template.dart' show PageTemplate;
import '../components/item/item.dart' show Item;
import '../components/note.dart' show Note;
import '../components/property/property.dart' show Property;

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
  ScreenBloc screenBloc;

  @override
  void initState() {
    screenBloc = ScreenBloc(
        authRepository: AuthRepository(), screenRepository: ScreenRepository());
    screenBloc.fetchScreen(widget.route);
    super.initState();
  }

  void scrollToItem(GlobalKey key) {
    if (key != null) {
      Scrollable.ensureVisible(key.currentContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScreenModel>(
      stream: screenBloc.screen,
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

  void handleSendItemValue(String id, dynamic value, {dynamic body}) {
//    return screenBloc.sendItemValue('${widget.route}/$id', value, body: body);
  }
}
