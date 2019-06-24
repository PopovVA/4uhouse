import 'package:bloc/bloc.dart' show Bloc;
import 'package:meta/meta.dart' show required;

import '../../models/screen/screen_model.dart' show ScreenModel;
import '../../resources/auth_repository.dart' show AuthRepository;
import '../../resources/component_repository.dart' show ComponentRepository;
import '../screen/screen_bloc.dart' show ScreenBloc;
import '../screen/screen_event.dart' show ScreenReceived;
import 'component_event.dart'
    show ComponentEvent, SendingComponentValueRequested;
import 'component_state.dart'
    show
        ComponentState,
        ComponentInitState,
        ComponentIsFetching,
        ComponentFetchingSuccess,
        ComponentFetchingError;

class ComponentBloc extends Bloc<ComponentEvent, ComponentState> {
  ComponentBloc(
      {@required this.screenBloc,
      @required this.authRepository,
      @required this.componentRepository});

  final ScreenBloc screenBloc;
  final AuthRepository authRepository;
  final ComponentRepository componentRepository;

  @override
  ComponentState get initialState => ComponentInitState();

  @override
  Stream<ComponentState> mapEventToState(dynamic event) async* {
    if (event is SendingComponentValueRequested) {
      yield ComponentIsFetching();
      try {
        final String token = await authRepository.accessToken;
        final ScreenModel screen = await componentRepository.sendItemValue(
            event.route, event.value,
            body: event.body, token: token);

        yield ComponentFetchingSuccess();
        if (screen != null) {
          screenBloc.dispatch(ScreenReceived(screen));
        }
      } catch (error) {
        print('===> component bloc error: $error');
        yield ComponentFetchingError(error.toString());
      }
    }
  }
}
