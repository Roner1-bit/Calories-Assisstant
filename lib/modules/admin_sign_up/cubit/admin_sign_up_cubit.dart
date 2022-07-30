import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/modules/admin_sign_up/cubit/admin_sign_up_states.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../models/user_model/user_model.dart';

class AdminSignUpCubit extends Cubit<AdminSignUpStates>{
  AdminSignUpCubit() : super(AdminSignUpStatesInitial());

  static AdminSignUpCubit get(context) => BlocProvider.of(context);




  void signUpUser(
      String userName,
      String name,
      String password,
      String weight,
      String height
      ){

    emit(AdminSignUpStatesLoading());

    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userName,
        password: password
    ).then((value) => {

      createUser( UserModel(
          value.user?.uid,
          userName,
          name,
          weight,
          height))

    }).catchError((error){
      if (kDebugMode) {
        print(error.toString());
      }
      emit(AdminSignUpStatesError("Something went wrong. Please try again"));
    });


  }

  void createUser(UserModel user){

    FirebaseFirestore.
        instance.collection('Users').
        doc(user.uId).
        set(user.toMap())
        .then((value) => {

          emit(AdminSignUpStatesSuccess())

    }).catchError((error){

      if (kDebugMode) {
          print(error.toString());
      }
      emit(AdminSignUpStatesError("Something went wrong. Please try again"));

    });

  }




}