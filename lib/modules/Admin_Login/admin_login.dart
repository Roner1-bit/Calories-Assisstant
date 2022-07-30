import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/shared/components/components.dart';
import '../admin_sign_up/admin_registeration.dart';
import 'cubit/AdminLoginStates.dart';
import 'cubit/Admin_LoginCubit.dart';


class AdminLogin extends StatelessWidget {
  const AdminLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var adminFormKey = GlobalKey<FormState>();
    var userNameController = TextEditingController();
    var passwordController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => AdminLoginCubit(),
      child: BlocConsumer<AdminLoginCubit, AdminLoginStates>(
        listener: (context, state) {
          if (state is AdminLoginErrorState) {
            showToast(
              text: state.error,
              success: false,
            );
          //   var len=AppCubit.get(context).foodObjects;
          //   for(int i=0;i<len.length;i++){
          //     print("food from admin panel ${len[i].foodName}");
          //     print(AppCubit.get(context).foodNames[i]);
          // }
          }
          if (state is AdminLoginSuccessState) {
            showToast(
              text: "Login successfully",
              success: true,
            );
            //AdminLoginCubit.get(context).cacheAndNavigate("uid",state.uid,context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AdminRegistrationScreen()),
              );


          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              elevation: 0.0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: adminFormKey,
                    child: Column(
                      children: [
                        const Text('Admin Login',
                            style: TextStyle(
                                color: Colors.black, fontSize: 50.0)),
                        const SizedBox(
                          height: 80,
                        ),
                        defaultFormField(
                            controller: userNameController,
                            textType: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter user name correctly';
                              }
                            },
                            label: 'Admin User Name',
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            textType: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter user password correctly';
                              }
                            },
                            label: 'Admin Password',
                            prefix: Icons.lock),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                            condition: state is! AdminLoginLoadingState,
                            builder: (context) =>
                                defaultButton(
                                  submitFunction: () {
                                    if (adminFormKey.currentState!.validate()) {
                                      AdminLoginCubit.get(context).adminLogin(
                                          userNameController.text,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }


}
