import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:user_mobile/src/models/screen/screen_model.dart';
import '../../../temp/screen_repository_test.dart';
import '../../blocs/screen/screen_bloc.dart' show ScreenBloc;
import '../../blocs/screen/screen_event.dart';
import '../../blocs/screen/screen_state.dart';
import '../../constants/layout.dart' show standardPadding;
import '../../models/screen/components/button_model.dart' show ButtonModel;
import '../../models/screen/components/item_model.dart' show ItemModel;
import '../../models/screen/components/note_model.dart' show NoteModel;
import '../../models/screen/components/property_model.dart' show PropertyModel;
//import '../../models/screen/screen_model.dart' show ScreenModel;

//import '../../resources/screen_repository.dart' show ScreenRepository;
import '../components/button.dart' show Button;
import '../components/item/item.dart' show Item;
import '../components/note.dart' show Note;
import '../components/page_template.dart' show PageTemplate;
import '../components/styled/styled_circular_progress.dart'
    show StyledCircularProgress;
import 'property/components/property_card_body.dart';

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
    super.initState();
    screenBloc = ScreenBloc(TestScreenRepository());
    screenBloc.dispatch(ScreenInitialized(query: widget.route));
  }

  @override
  void dispose() {
    super.dispose();
    screenBloc.dispose();
  }

  void scrollToItem(GlobalKey key) {
    if (key != null) {
      Scrollable.ensureVisible(key.currentContext);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScreenEvent, ScreenState>(
        bloc: screenBloc,
        builder: (BuildContext context, ScreenState state) {
          if (state is ScreenDataLoaded) {
            return PageTemplate(
              body: buildComponents(state.data),
              goBack: state.data.first.path != null
                  ? () {
                final String path = state.data.first.path;
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
              title: state.data.first.value,
            );
          } else if (state is ScreenDataLoadingError) {
            return Text(state.error.toString());
          }

          return Container(
            color: Colors.white,
            child: const StyledCircularProgress(),
          );
        });
  }

  Widget buildComponents(List<ScreenModel> data) {
//    final dynamic data = snapshot.data;
    if (data.isNotEmpty) {
      final List<Widget> items = <Widget>[];
      final List<Button> buttons = <Button>[];
      // ignore: avoid_function_literals_in_foreach_calls
      data.first.components.forEach((dynamic component) {
        if (component is ItemModel) {
          items.add(Item(
            component,
            data.first.path,
            handleSendItemValue,
            makeTransition,
          ));
        } else if (component is NoteModel) {
          items.add(Note(component));
        } else if (component is PropertyModel) {
          items.add(PropertyCard(component,
              makeTransition: component.isTransition ? makeTransition : null));
        } else if (component is ButtonModel) {
          buttons.add(Button(
            component,
            data.first.path,
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

      return Ink(
        color: const Color(0xFFEBECED),
        height: double.infinity,
        padding: const EdgeInsets.only(right: 8.0, left: 8.0),
        child: Column(
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
        ),
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
    screenBloc.dispatch(
        SendItem(route: '${widget.route}/$id', value: value, body: body));
  }
}
