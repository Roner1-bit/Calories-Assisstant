import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/modules/Admin_Login/cubit/AdminLoginStates.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym_system/shared/components/constants.dart';



class AdminLoginCubit extends Cubit<AdminLoginStates> {

  adminLogin(String userName, String passwordN){

    emit(AdminLoginLoadingState());

    // FirebaseAuth.instance.
    // signInWithEmailAndPassword(
    //     email: userName,
    //     password: password).then((value){
    //   emit(AdminLoginSuccessState(value.user?.uid));
    // })
    //     .catchError((error){
    //   emit(AdminLoginErrorState(error.toString()));
    // });


    if(userName==adminUserName&&password==password){
      emit(AdminLoginSuccessState());
    }else{
      emit(AdminLoginErrorState("Something went wrong please try again"));
    }



  }


  AdminLoginCubit() : super(AdminInitialState());

  static AdminLoginCubit get(context) => BlocProvider.of(context);


// cacheAndNavigate(String? key,dynamic value,context){
//   CacheHelper.saveData(key: "uid", value: value).
//   then((value) => {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => const AdminRegistrationScreen()),
//     )
//   }
//   );
//
// }


}