import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/modules/admin_sign_up/cubit/admin_sign_up_cubit.dart';
import 'package:gym_system/modules/admin_sign_up/cubit/admin_sign_up_states.dart';
import 'package:gym_system/shared/components/components.dart';
import 'package:gym_system/shared/components/constants.dart';

class AdminRegistrationScreen extends StatelessWidget {
  const AdminRegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var adminRegFormKey = GlobalKey<FormState>();
    var userNameController = TextEditingController();
    var nameController = TextEditingController();
    var passwordController = TextEditingController();
    var userHeightController = TextEditingController();
    var userWeightController = TextEditingController();

    return BlocProvider(
      create: (BuildContext context) => AdminSignUpCubit(),
      child: BlocConsumer<AdminSignUpCubit, AdminSignUpStates>(
        listener: (context, state) {

          if (state is AdminSignUpStatesError) {
            showToast(
              text: state.error,
              success: false,
            );
          }
          if (state is AdminSignUpStatesSuccess) {
            showToast(
              text: "Registrated successfully",
              success: true,
            );
            //AdminLoginCubit.get(context).cacheAndNavigate("uid",state.uid,context);

          }



        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: adminRegFormKey,
                    child: Column(
                      children: [
                        const Text('Admin Panel',
                            style:
                                TextStyle(color: Colors.black, fontSize: 50.0)),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: userNameController,
                            textType: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter user name correctly';
                              }
                            },
                            label: 'User Name',
                            prefix: Icons.email_outlined),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: nameController,
                            textType: TextInputType.name,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter name correctly';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.account_box),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: passwordController,
                            textType: TextInputType.visiblePassword,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter a valid password';
                              }
                            },
                            label: 'Password',
                            prefix: Icons.lock),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: userHeightController,
                            textType: TextInputType.number,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter height in CM';
                              }
                            },
                            label: 'Height in CM',
                            prefix: Icons.accessibility_new_sharp),
                        const SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                            controller: userWeightController,
                            textType: TextInputType.number,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter weight in KG';
                              }
                            },
                            label: 'weight in KG',
                            prefix: Icons.accessibility_rounded),
                        const SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                            condition: state is! AdminSignUpStatesLoading,
                            builder: (context) => defaultButton(
                                  submitFunction: () {
                                    if (adminRegFormKey.currentState!.validate()) {

                                      AdminSignUpCubit.get(context).signUpUser(
                                          userNameController.text+domain,
                                          nameController.text,
                                          passwordController.text,
                                          userWeightController.text,
                                          userHeightController.text
                                      );

                                    }
                                  },
                                  text: 'Registration',
                                  background: primarySwatch,
                                ),
                            fallback: (context) =>
                                const CircularProgressIndicator(
                                  color: primarySwatch,
                                )),
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
