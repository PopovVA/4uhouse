import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, BlocListener, BlocListenerTree;
import 'package:flutter/scheduler.dart' show SchedulerBinding;
import 'package:outline_material_icons/outline_material_icons.dart';

import '../../../temp/resources/screen_repository_test.dart'
    show TestScreenRepository;
import '../../blocs/auth/auth_bloc.dart' show AuthBloc;
import '../../blocs/auth/auth_event.dart' show AuthEvent;
import '../../blocs/auth/auth_state.dart' show AuthState, AuthUnauthorized;
import '../../blocs/component/component_bloc.dart' show ComponentBloc;
import '../../blocs/screen/screen_bloc.dart' show ScreenBloc;
import '../../blocs/screen/screen_event.dart' show ScreenEvent, ScreenRequested;
import '../../blocs/screen/screen_state.dart'
    show
        ScreenDataLoaded,
        ScreenLoading,
        ScreenDataLoadingError,
        ScreenAuthorizationError,
        ScreenState;

import '../../constants/navigation.dart' show ROOT_PAGE, LOGIN_PAGE;
import '../../models/screen/components/button_model.dart' show ButtonModel;
import '../../models/screen/components/item_model.dart' show ItemModel;
import '../../models/screen/components/note_model.dart' show NoteModel;
import '../../models/screen/components/property_model.dart' show PropertyModel;
import '../../models/screen/screen_model.dart' show ScreenModel;
import '../../resources/auth_repository.dart' show AuthRepository;
import '../../resources/screen_repository.dart' show ScreenRepository;
import '../../utils/show_alert.dart' show showError;

import '../components/button.dart' show Button;
import '../components/drawer/drawer.dart' show DrawerOnly;
import '../components/item/item.dart' show Item;
import '../components/note.dart' show Note;
import '../components/page_template.dart' show PageTemplate;
import '../components/property_card/property_card.dart' show PropertyCard;
import '../components/styled/styled_circular_progress.dart'
    show StyledCircularProgress;

class Screen extends StatefulWidget {
  Screen({@required this.authBloc, this.route});

  final AuthBloc authBloc;
  final String route;
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
        authBloc: widget.authBloc,
        screenRepository: ScreenRepository(),
              authRepository: AuthRepository());
//        screenRepository: TestScreenRepository(),
 //       authRepository: AuthRepository());
    screenBloc.dispatch(ScreenRequested(route: widget.route));
  }

  @override
  void dispose() {
    screenBloc.dispose();
    super.dispose();
  }

  bool isHomePage(String path) => path == ROOT_PAGE;

  void _scrollToItem(GlobalKey key) {
    if (key != null) {
      Scrollable.ensureVisible(key.currentContext);
    }
  }

  Future<void> _refresh(ScreenState state) async {
    scrollToId = null;
    String query;

    if (state is ScreenDataLoaded) {
      query = state.data.path;
    } else if (state is ScreenLoading) {
      query = state.query;
    }

    if (query != null) {
      screenBloc.dispatch(ScreenRequested(route: query));
    }
  }

  Function makeTransition(String path) => (BuildContext context, String id) {
        screenBloc.dispatch(
            ScreenRequested(route: '$path${id is String ? '/$id' : ''}'));
      };

  Widget buildComponents(ScreenDataLoaded state) {
    final ScreenModel data = state.data;

    if (data != null) {
      final String path = data.path;
      final List<Widget> items = <Widget>[];
      final List<Button> buttons = <Button>[];

      for (dynamic component in data.components) {
        switch (component.runtimeType) {
          case NoteModel:
            {
              items.add(Note(component));
              break;
            }

          case ItemModel:
            {
              items.add(Item(
                component,
                path,
                makeTransition(path),
                screenBloc,
              ));
              break;
            }

          case PropertyModel:
            {
              items.add(PropertyCard(component,
                  makeTransition:
                      component.isTransition ? makeTransition(path) : null));
              break;
            }

          case ButtonModel:
            {
              buttons.add(Button(
                component,
                path,
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

      return Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                  child: ListView(
                    padding: buttons.isNotEmpty && state is ScreenDataLoaded
                        ? EdgeInsets.only(
                            bottom: 64 * buttons.length.toDouble())
                        : null,
                    controller: widget.scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    children: items,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: buttons,
            ),
          ),
        ],
      );
    }

    return null;
  }

  Function getHandleGoBack(ScreenState state) {
    if (state is ScreenDataLoaded && !isHomePage(state.data.path)) {
      return () {
        final String path = state.data.path;
        scrollToId = path.substring(path.lastIndexOf('/') + 1);
        screenBloc.dispatch(
            ScreenRequested(route: path.substring(0, path.lastIndexOf('/'))));
      };
    }

    return null;
  }

  Widget buildBody(ScreenState state) {
    if (state is ScreenDataLoaded) {
      return buildComponents(state);
    }

    if (state is ScreenAuthorizationError) {
      return Container(width: 0.0, height: 0.0);
    }

    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            child: Column(
              children: <Widget>[
                Expanded(
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: FractionalOffset.center,
            child: const StyledCircularProgress())
      ],
    );
  }

  String buildTitle(ScreenState state) {
    if (state is ScreenDataLoaded) {
      return state.data.value;
    }

    return 'Loading';
  }

  Widget getDrawer(ScreenState state) {
    if (state is ScreenDataLoaded) {
      return isHomePage(state.data.path)
          ? DrawerOnly(authBloc: widget.authBloc)
          : null;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListenerTree(
        blocListeners: <BlocListener<dynamic, dynamic>>[
          BlocListener<AuthEvent, AuthState>(
            bloc: widget.authBloc,
            listener: (BuildContext context, AuthState state) {
              if (state is AuthUnauthorized) {
                Navigator.of(context).pushReplacementNamed(ROOT_PAGE);
              }
            },
          ),
          BlocListener<ScreenEvent, ScreenState>(
            bloc: screenBloc,
            listener: (BuildContext context, ScreenState state) {
              if (state is ScreenAuthorizationError) {
                Navigator.of(context).pushReplacementNamed(LOGIN_PAGE,
                    arguments: <String, String>{'returnTo': state.route});
              }

              if (state is ScreenDataLoadingError) {
                showError(context, state);
              }
            },
          ),
        ],
        child: BlocBuilder<ScreenEvent, ScreenState>(
            bloc: screenBloc,
            builder: (BuildContext context, ScreenState state) {
              return PageTemplate(
                drawer: getDrawer(state),
                loading: state is ScreenLoading,
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(OMIcons.addCircleOutline),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(OMIcons.settingsInputComponent),
                    onPressed: () {},
                  ),
                ],
                body: RefreshIndicator(
                  onRefresh: () => _refresh(state),
                  color: Theme.of(context).primaryColor,
                  child: Ink(color: Colors.white, child: buildBody(state)),
                ),
                goBack: getHandleGoBack(state),
                title: buildTitle(state),
              );
            }));
  }
}
