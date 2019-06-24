import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart' show required;
//import '../../../temp/screen_repository_test.dart';

import '../../../src/models/screen/screen_model.dart' show ScreenModel;
import '../../resources/auth_repository.dart' show AuthRepository;
import '../../resources/screen_repository.dart' show ScreenRepository;
import 'screen_event.dart' show ScreenEvent, ScreenRequested, ScreenReceived;
import 'screen_state.dart'
    show
    ScreenDataLoaded,
    ScreenDataLoadingError,
    ScreenLoading,
    ScreenState,
    ScreenUninitialized;

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenBloc({@required this.authRepository, @required this.screenRepository});

  final ScreenRepository screenRepository;
  final AuthRepository authRepository;

  @override
  ScreenState get initialState => ScreenUninitialized();

  @override
  Stream<ScreenState> mapEventToState(ScreenEvent event) async* {
    final String token = await authRepository.accessToken;
    if (event is ScreenRequested) {
      try {
        yield ScreenLoading();
        final ScreenModel data = await screenRepository.fetchScreen(
            query: event.query, token: token);
        yield ScreenDataLoaded(data);
      } catch (error) {
        print('===> screen bloc error: $error');
        yield ScreenDataLoadingError(error.toString());
      }
    }

    if (event is ScreenReceived) {
      yield ScreenDataLoaded(event.screen);
    }
  }
}
