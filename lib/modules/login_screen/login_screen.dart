import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/layout/home_layout.dart';
import 'package:gym_system/modules/login_screen/cubit/login_cubit.dart';
import 'package:gym_system/modules/login_screen/cubit/login_states.dart';
import 'package:gym_system/shared/components/components.dart';
import 'package:gym_system/shared/components/constants.dart';
import '../Admin_Login/admin_login.dart';

class LoginScreen extends StatelessWidget {

  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context)
    =>
        LoginCubit()
    ,
    child: BlocConsumer<LoginCubit,LoginStates>( //BlocConsumer<SocialLoginCubit, SocialLoginStates>
    listener: (context,state){

      if (state is AppLoginErrorState) {
        showToast(
          text: state.error,
          success: false,
        );
      }
      if (state is AppLoginSuccessState) {
        showToast(
          text: "Login successfully",
          success: true,
        );
        //AdminLoginCubit.get(context).cacheAndNavigate("uid",state.uid,context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeLayout()),
              (Route<dynamic> route) => false,

        );


      }


    },
    builder: (context,state){
      return Scaffold(
        body: Center(
         child: SingleChildScrollView(
           child: Padding(
             padding: const EdgeInsets.all(20.0),
             child: Column(
                 children:[
                   Image.asset('assets/images/logo1-1.png',
                     width: 200,
                     height: 200,


                   ),
                 const SizedBox(
                   height: 35,
                 ),
                 defaultFormField(
                     controller: emailController,
                     textType: TextInputType.emailAddress,
                     validate: (String value){
                       if(value.isEmpty){
                         return 'Please enter your user name correctly.';
                       }
                     },
                     label: 'User Name',
                     prefix: Icons.email
                 ),
                const SizedBox(
                  height: 25.0,
                ),
                   defaultFormField(
                       controller: passwordController,
                       textType: TextInputType.visiblePassword,
                       validate: (String value){
                         if(value.isEmpty){
                           return 'Please enter your password correctly.';
                         }
                       },
                       label: 'Password',
                       prefix: Icons.lock,
                       suffix: LoginCubit.get(context).suffix,
                       isPassword: LoginCubit.get(context).isPassword,
                       suffixPressed: (){
                         LoginCubit.get(context).changeVisibilityPassword();
                       }
                   ),
                   const SizedBox(
                     height: 25.0,
                   ),
             ConditionalBuilder(
                 condition: state is! AppLoginLoadingState,
                 builder: (context) =>
                     defaultButton(
                       submitFunction: () {
                         if (true) { // formKey.currentState!.validate()
                           LoginCubit.get(context).userLogin(
                               emailController.text+domain,
                               passwordController.text);
                         }
                       },
                       text: 'Sign in',
                       background: primarySwatch,
                     ),
                 fallback: (context) =>
                 const CircularProgressIndicator(
                   color: primarySwatch,
                 )
             ),
                   const SizedBox(
                     height: 25.0,
                   ),
                   RichText(
                       text: TextSpan(
                           text: 'Admin Panel',
                           style: const TextStyle(
                             color: primarySwatch,
                           ),
                           recognizer: TapGestureRecognizer()
                             ..onTap = () {
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(builder: (context) => const AdminLogin()),
                               );
                             }) )
                 ]
              ),
           ),
         )
        ),
      );

    }


    ),





  );
}}


