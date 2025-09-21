import 'dart:async';

import 'package:dev_jot/features/auth/domain/exceptions/auth_exception.dart';
import 'package:dev_jot/features/auth/domain/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthUnknown()) {
    _userSubscription = _authRepository.authStateChanges.listen(
          (user) => add(_AuthUserChanged(user)),
    );

    on<_AuthUserChanged>(_onAuthUserChanged);
    on<SignInRequested>(_onSignInRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<SignOutRequested>(_onSignOutRequested);
  }

  final AuthRepository _authRepository;
  late StreamSubscription<User?> _userSubscription;

  void _onAuthUserChanged(_AuthUserChanged event, Emitter<AuthState> emit) {
    if (event.user != null) {
      emit(Authenticated(event.user!));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onSignInRequested(
      SignInRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  Future<void> _onSignUpRequested(
      SignUpRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUpWithEmailAndPassword(
        event.email,
        event.password,
      );
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  Future<void> _onSignOutRequested(
      SignOutRequested event,
      Emitter<AuthState> emit,
      ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut();
    } on AuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
