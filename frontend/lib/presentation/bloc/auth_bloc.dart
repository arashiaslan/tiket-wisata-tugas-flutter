import 'package:bloc/bloc.dart';

import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async{
      emit(AuthLoading());
      try {
        final result = await loginUseCase(event.email, event.password);
        emit(AuthSuccess(result['user'], result['token']));
      }catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
