import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/shared/network/local/cache_helper.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {

  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

//This block is for the login block
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  changeVisibilityPassword() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(LoginChangePasswordVizState());
  }

  userLogin(String userName, String password) {
    emit(AppLoginLoadingState());

    FirebaseAuth.instance.
    signInWithEmailAndPassword(
        email: userName,
        password: password).then((value) {
        CacheHelper.saveData(key: "uId", value: value.user?.uid);
      emit(AppLoginSuccessState(value.user?.uid));
    })
        .catchError((error) {
      emit(AppLoginErrorState("Something went wrong please try again."));
    });
  }

}