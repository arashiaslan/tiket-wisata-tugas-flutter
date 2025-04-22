import 'package:bloc/bloc.dart';
import 'package:frontend/data/datasources/auth_local_datasource.dart';

import '../../domain/usecases/login_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final AuthLocalDatasource authLocalDatasource;

  AuthBloc(this.loginUseCase, this.authLocalDatasource) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async{
      emit(AuthLoading());
      try {
        final result = await loginUseCase(event.email, event.password);
        await authLocalDatasource.saveToken(result['token']);
        emit(AuthSuccess(result['user'], result['token']));
      }catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
