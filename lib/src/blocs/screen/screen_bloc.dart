import '../../resources/screen_repository.dart' show ScreenRepository;
import 'screen_event.dart';
import 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  ScreenRepository screenRepository;

  @override
  ScreenState get initialState => ScreenEntering();

  @override
  Stream<ScreenState> mapEventToState(LoginEvent event) async* {
    if (event is ScreenRequested) {
      try {
        yield IsLoadingScreen();
        screenRepository.fetchScreen(event.route);
        yield ScreenLoaded();
      } catch (error) {
        yield Error(message:error.toString());
      }
    }else if(event is ....){
    ...
  }
  }
}