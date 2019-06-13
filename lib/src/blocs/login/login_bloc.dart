import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:user_mobile/src/blocs/auth/auth_bloc.dart';
import 'package:user_mobile/src/resources/auth_repository.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({@required  this.bloc,@required this.repository});
  AuthBloc bloc;
  AuthRepository repository;


  @override
  LoginState get initialState => PhoneEntering();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (initialState == PhoneEntering()) {
      if (event is OtpRequested) {
        try {
          yield IsFetchingOtp();
          final String codeChallenge = await repository.generatePkce();
          repository.getOtp(event.phone, codeChallenge);
          yield OtpSent();
        } catch (error) {
          yield PhoneError(message:error.toString());
        }
      } else if (event is SubmitCodeTapped) {
        try {
          yield IsFetchingCode();
        } catch (error) {
          yield CodeError(message:error.toString());
        }
      }
    } else {
      if (event is CodeEnteringCanceled) {
        yield PhoneEntering();
      }
    }
  }
}