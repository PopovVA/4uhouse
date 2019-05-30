import 'package:bloc/bloc.dart';
import '../../src/resources/auth_repository.dart';
import 'auth/auth_bloc.dart';
import 'auth/auth_state.dart';

class LoginBloc extends Bloc<AuthRepository, AuthBloc> {
  @override
  AuthBloc get initialState => AuthBloc(authRepository: AuthRepository());

  @override
  Stream<AuthBloc> mapEventToState(AuthRepository event) async* {
    yield* SubmitPhoneTapped('phone');
  }

  @override
  Stream<AuthBloc> SubmitPhoneTapped(String phone) async* {


  }



  @override
  Stream<AuthBloc> SubmitCodeTapped(int code) async* {}
}
