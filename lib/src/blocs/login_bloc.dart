import 'package:bloc/bloc.dart';
import '../../src/resources/auth_repository.dart';
import 'auth/auth_bloc.dart';
import 'auth/auth_state.dart';

class LoginBloc extends Bloc<AuthBloc, AuthRepository> {
  @override
  AuthRepository get initialState => AuthRepository();

  @override
  Stream<AuthRepository> mapEventToState(AuthBloc event) async* {
    yield* SubmitPhoneTapped('phone');
  }

  @override
  Stream<AuthRepository> SubmitPhoneTapped(String phone) async* {
    try {
      AuthRepository().getOtp(phone, await AuthRepository().readCodeVerifier());
    } catch (error) {}
  }

  @override
  Stream<AuthRepository> SubmitCodeTapped(int code) async* {}
}
