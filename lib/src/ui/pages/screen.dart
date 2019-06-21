import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding;

import '../../blocs/component/component_bloc.dart' show ComponentBloc;
import '../../blocs/screen/screen_bloc.dart' show ScreenBloc;
import '../../blocs/screen/screen_event.dart' show ScreenEvent, ScreenRequested;
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
import '../../utils/show_alert.dart' show showError;

import '../components/button.dart' show Button;
import '../components/item/item.dart' show Item;
import '../components/note.dart' show Note;
import '../components/page_template.dart' show PageTemplate;
import '../components/property_card/property_card.dart' show PropertyCard;
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
  ComponentBloc componentBloc;
  String scrollToId;

  @override
  void initState() {
    super.initState();
    screenBloc = ScreenBloc(
        screenRepository: ScreenRepository(), authRepository: AuthRepository());
//        screenRepository: TestScreenRepository(),
//        authRepository: AuthRepository());
    scrollToId = widget.scrollToId;
    screenBloc.dispatch(ScreenRequested(query: widget.route));
  }

  @override
  void dispose() {
    screenBloc.dispose();
    super.dispose();
  }

  void _scrollToItem(GlobalKey key) {
    if (key != null) {
      Scrollable.ensureVisible(key.currentContext);
    }
  }

  Future<void> _refresh() async {
    scrollToId = null;
    screenBloc.dispatch(ScreenRequested(query: widget.route));
  }

  void makeTransition(BuildContext context, String id) {
    Navigator.of(context)
        .pushReplacementNamed('${widget.route}${id is String ? '/$id' : ''}');
  }

  Widget buildComponents(ScreenModel data) {
    if (data != null) {
      final List<Widget> items = <Widget>[];
      final List<Button> buttons = <Button>[];
      for (dynamic component in data.components) {
        switch (component.runtimeType) {
          case NoteModel: {
            items.add(Note(component));
            break;
          }

          case ItemModel: {
            items.add(Item(
              component,
              data.path,
              makeTransition,
              screenBloc,
            ));
            break;
          }

          case PropertyModel: {
            items.add(PropertyCard(component,
                makeTransition: component.isTransition ? makeTransition : null));
            break;
          }

          case ButtonModel: {
            buttons.add(Button(
              component,
              data.path,
              screenBloc,
            ));
            break;
          }
        }
      }

      if (scrollToId is String) {
        final dynamic scrollItemList =
            items.where((dynamic item) => item.id == scrollToId).toList();
        scrollItemKey = scrollItemList.isEmpty ? null : scrollItemList[0].key;
        SchedulerBinding.instance
            .addPostFrameCallback((_) => _scrollToItem(scrollItemKey));
      }

      return RefreshIndicator(
        onRefresh: _refresh,
        color: Theme.of(context).primaryColor,
        child: Ink(
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
                padding:
                    EdgeInsets.symmetric(horizontal: standardHorizontalPadding),
                child: Column(
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

  Function getHandleGoBack(ScreenState state) {
    if (widget.drawer == null && state is ScreenDataLoaded) {
      return () {
        final String path = state.data.path;
        Navigator.of(context).pushReplacementNamed(
          path.substring(0, path.lastIndexOf('/')),
          arguments: <String, String>{
            'scrollToId':
                widget.route.substring(widget.route.lastIndexOf('/') + 1),
          },
        );
      };
    }

    return null;
  }

  Widget buildBody(ScreenState state) {
    if (state is ScreenDataLoaded) {
      return buildComponents(state.data);
    }

    return const StyledCircularProgress();
  }

  String buildTitle(ScreenState state) {
    if (state is ScreenDataLoaded) {
      return state.data.value;
    }

    return 'Loading';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScreenEvent, ScreenState>(
        bloc: screenBloc,
        listener: (BuildContext context, ScreenState state) {
          if (state is ScreenDataLoadingError) {
            showError(context, state);
          }
        },
        child: BlocBuilder<ScreenEvent, ScreenState>(
            bloc: screenBloc,
            builder: (BuildContext context, ScreenState state) {
              return PageTemplate(
                drawer: widget.drawer,
                body: buildBody(state),
                goBack: getHandleGoBack(state),
                title: buildTitle(state),
              );
            }));
  }
}
