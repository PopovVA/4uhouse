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
    if (initialState == PhoneEntering()) {
      if (event is SubmitPhoneTapped) {
        try {
          yield IsFetchingOtp();
          final String codeChallenge = await authRepository.generatePkce();
          authRepository.getOtp(event.phone, codeChallenge);
          yield OtpSent();
        } catch (error) {
          yield* _mapErrorLoginTap();
        }
      } else if (event is SubmitCodeTapped) {
        try {
          yield IsFetchingCode();
          authRepository.getOtp(event.phone, event.code.toString());
          yield OtpSent();
        } catch (error) {
          yield* _mapErrorLoginTap();
        }
      } else if (event is ResendOtpTapped) {
        try {
          yield IsFetchingOtp();
          final String codeChallenge = await authRepository.generatePkce();
          authRepository.getOtp(event.phone, codeChallenge);
          yield OtpSent();
        } catch (error) {
          yield* _mapErrorLoginTap();
        }
      }
    } else {
      if (event is CodeEnteringCanceled) {
        yield PhoneEntering();
      }
    }
  }

  Stream<LoginState> _mapErrorLoginTap() async* {
    final bool internet = await checkInternet();
    if (internet) {
      yield CodeError();
    } else {
      yield PhoneError();
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
