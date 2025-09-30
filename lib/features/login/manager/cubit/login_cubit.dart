import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/features/login/data/repo/login_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final LoginRepo loginRepo;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    final user = await loginRepo.loginWithEmailAndPassword(
      email: email,
      password: password,
    );
    user.fold(
      (error) {
        log(error.toString());
        emit(LoginError(error: error));
      },
      (user) {
        emit(LoginSuccess(uid: user.uid));
      },
    );
  }

  Future<void> loginWithGoogle() async {
    emit(LoginLoading());
    final user = await loginRepo.loginWithGoogle();
    user.fold(
      (error) {
        log(error.toString());
        emit(LoginError(error: error));
      },
      (user) {
        emit(LoginSuccess(uid: user.uid));
      },
    );
  }
}
