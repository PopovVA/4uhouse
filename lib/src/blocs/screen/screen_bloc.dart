import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart' show required;
//import '../../../temp/screen_repository_test.dart';

import '../../../src/models/screen/screen_model.dart' show ScreenModel;
import '../../resources/auth_repository.dart' show AuthRepository;
import '../../resources/screen_repository.dart' show ScreenRepository;
import 'screen_event.dart'
    show ScreenEvent, ScreenInitialized, SendItem, TappedOnComponent;
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
    if (event is ScreenInitialized) {
      try {
        yield ScreenLoading();
        //загружаю данные
        final ScreenModel data =
        await screenRepository.fetchScreen(query: event.query);
        yield ScreenDataLoaded(data);
      } catch (error) {
        yield ScreenDataLoadingError(error: error.toString());
      }
    } else if (event is SendItem) {
      //Отправляю данные
      await screenRepository.sendItemValue(event.route, event.value,
          body: event.body);
    } else if (event is TappedOnComponent) {}
  }
}
