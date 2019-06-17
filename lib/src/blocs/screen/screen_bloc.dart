import 'package:bloc/bloc.dart';
//import '../../resources/screen_repository.dart' show ScreenRepository;
import '../../../src/models/screen/screen_model.dart';
import '../../../temp/screen_repository_test.dart';
import 'screen_event.dart';
import 'screen_state.dart';

class ScreenBloc extends Bloc<ScreenEvent, ScreenState> {
  TestScreenRepository screenRepository;

  @override
  ScreenState get initialState => ScreenUninitialized();

  @override
  Stream<ScreenState> mapEventToState(ScreenEvent event) async* {
    if (event is ScreenInitialized) {
      try {
        yield ScreenLoading();
        //загружаю данные
        final List<ScreenModel> data = await Future.wait(
            <Future<ScreenModel>>[screenRepository.fetchScreen()]);
        yield ScreenDataLoaded(data);
      } catch (error) {
        yield ScreenDataLoadingError(error: error);
      }
    } else if (event is TappedOnComponent) {}
  }
}
