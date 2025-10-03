import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_store/core/model/user_model/user_model.dart';
import 'package:my_store/features/register/data/repo/register_repo.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.registerRepo) : super(RegisterInitial());
  final RegisterRepo registerRepo;

  Future<void> registerWithEmailAndPassword({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    final user = await registerRepo.egisterWithEmailAndPassword(
      email: email,
      password: password,
    );

    user.fold(
      (error) {
        log(error.toString());
        emit(RegisterError(error));
      },
      (user) async {
        final result = await registerRepo.registerUserInfoInFirebase(
          userModel: UserModel(
            email: email,
            firstName: firstName,
            lastName: lastName,
            uid: user.uid,
          ),
        );
        result.fold((error) {
          log(error.toString());
          emit(RegisterError(error));
        }, (user) {});
        emit(RegisterSuccess(user.uid));
      },
    );
  }
}
