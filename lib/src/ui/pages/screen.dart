import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;

import '../../blocs/screen/screen_bloc.dart' show ScreenBloc;
import '../../blocs/screen/screen_event.dart'
    show ScreenEvent, ScreenInitialized, SendItem;
import '../../blocs/screen/screen_state.dart'
    show ScreenDataLoaded, ScreenDataLoadingError, ScreenState;
import '../../constants/layout.dart' show standardHorizontalPadding;
import '../../models/screen/components/button_model.dart' show ButtonModel;
import '../../models/screen/components/item_model.dart' show ItemModel;
import '../../models/screen/components/note_model.dart' show NoteModel;
import '../../models/screen/components/property_model.dart' show PropertyModel;
import '../../models/screen/screen_model.dart' show ScreenModel;

import '../../resources/auth_repository.dart' show AuthRepository;
import '../../resources/screen_repository.dart' show ScreenRepository;
import '../components/button.dart' show Button;
import '../components/item/item.dart' show Item;
import '../components/note.dart' show Note;
import '../components/page_template.dart' show PageTemplate;
import '../components/property_card/property_card.dart' show PropertyCard;
import '../components/styled/styled_alert_dialog.dart' show StyledAlertDialog;
import '../components/styled/styled_circular_progress.dart'
    show StyledCircularProgress;

class Screen extends StatefulWidget {
  factory Screen(String route,
      {Widget drawer, Map<String, dynamic> arguments}) {
    final String scrollToId =
        arguments != null ? arguments['scrollToId'] : null;
    return Screen._(route, drawer: drawer, scrollToId: scrollToId);
  }

  Screen._(this.route, {this.drawer, this.scrollToId});

  final String route;
  final String scrollToId;
  final Widget drawer;
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
    screenBloc = ScreenBloc(
        screenRepository: ScreenRepository(), authRepository: AuthRepository());
//        screenRepository: TestScreenRepository(),
//        authRepository: AuthRepository());
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

  void _showError(BuildContext context, dynamic state) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StyledAlertDialog(
            content: state.toString(),
            onOk: () {
              Navigator.of(context).pop();
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print('===> buildblock drawer: ${widget.drawer}');
    return BlocListenerTree(
        blocListeners: <BlocListener<dynamic, dynamic>>[
          BlocListener<ScreenEvent, ScreenState>(
              bloc: screenBloc,
              listener: (BuildContext context, ScreenState state) {
                if (state is ScreenDataLoadingError) {
                  _showError(context, state);
                }
              })
        ],
        child: BlocBuilder<ScreenEvent, ScreenState>(
            bloc: screenBloc,
            builder: (BuildContext context, ScreenState state) {
              if (state is ScreenDataLoaded) {
                return PageTemplate(
                  drawer: widget.drawer,
                  body: buildComponents(state.data),
                  goBack: widget.drawer == null
                      ? () {
                          final String path = state.data.path;
                          Navigator.of(context).pushReplacementNamed(
                              path.substring(0, path.lastIndexOf('/')));
                        }
                      : null,
                  title: state.data.value,
                );
              } else if (state is ScreenDataLoadingError) {
                return Container(
                  color: Colors.white,
                  child: const StyledCircularProgress(),
                );
              }

              return Container(
                color: Colors.white,
                child: const StyledCircularProgress(),
              );
            }));
  }

  Widget buildComponents(ScreenModel data) {
    if (data != null) {
      final List<Widget> items = <Widget>[];
      final List<Button> buttons = <Button>[];
      for (dynamic component in data.components) {
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
          items.add(PropertyCard(component,
              makeTransition: component.isTransition ? makeTransition : null));
        } else if (component is ButtonModel) {
          buttons.add(Button(
            component,
            data.path,
            handleSendItemValue,
          ));
        }
      }

      if (widget.scrollToId is String) {
        final dynamic scrollItemList = items
            .where((dynamic item) => item.id == widget.scrollToId)
            .toList();
        scrollItemKey = scrollItemList.isEmpty ? null : scrollItemList[0].key;
        SchedulerBinding.instance
            .addPostFrameCallback((_) => scrollToItem(scrollItemKey));
      }

      return RefreshIndicator(
        onRefresh: _refresh,
        child: Ink(
          height: double.infinity,
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: Stack(
            children: <Widget>[
              Column(
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
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: buttons,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return null;
  }

  Future<void> _refresh() async {
    screenBloc.dispatch(ScreenInitialized(query: widget.route));
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
