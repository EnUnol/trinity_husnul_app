import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login() async {
    // Implement login logic
    emit(AuthAuthenticated());
  }

  Future<void> signup() async {
    // Implement signup logic
    emit(AuthAuthenticated());
  }

  Future<void> logout() async {
    // Implement logout logic
    emit(AuthUnauthenticated());
  }
}

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthUnauthenticated extends AuthState {}
