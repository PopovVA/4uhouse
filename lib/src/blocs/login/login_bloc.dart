import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:user_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:user_mobile/src/resources/auth_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AuthBloc authBloc;
  AuthRepository authRepository;

  @override
  LoginState get initialState => PhoneEntering();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    LoginState state;
    try {
      if (event is SubmitPhoneTapped) {
        yield state = isLoading();
        authRepository.generatePkce();
        authRepository.getOtp(
            event.phone, await authRepository.readCodeVerifier());
        yield state = OtpSent();
      } else if (event is SubmitCodeTapped) {}
    } catch (error) {
      yield* _mapErrorLoginTap(error);
    }
  }

  Stream<LoginState> _mapErrorLoginTap(String error) async* {
    bool internet = await checkInternet();
    print(internet);
    LoginError currentState;
    if (internet) {
      yield currentState = CodeError();
    } else {
      yield currentState = PhoneError();
    }
  }

  Future<bool> checkInternet() async {
    final ConnectivityResult connectivityResult =
        await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
