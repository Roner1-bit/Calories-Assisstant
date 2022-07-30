import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_system/shared/components/constants.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppCubit.get(context).getUser();

    var heightController = TextEditingController();
    var weightController = TextEditingController();

    heightController.text = userModel.height;
    weightController.text = userModel.weight;
    var bmr = AppCubit.get(context)
        .calculateBMR(int.parse(userModel.weight), int.parse(userModel.height));
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is SetUserSuccessState) {
        showToast(text: "Updated Successfully", success: true);
        AppCubit.get(context).getUser();
        heightController.text = userModel.height;
        weightController.text = userModel.weight;
        var bmr = AppCubit.get(context).calculateBMR(
            int.parse(userModel.weight), int.parse(userModel.height));
      }
    }, builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Hi ${userModel.name}',
                  style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline1,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  )),
            ),
            const SizedBox(height: 40.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "This your Weight in KG",
                prefixIcon: Icon(Icons.accessibility_new),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              controller: weightController,
            ),
            const SizedBox(height: 40.0),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "This is your Height in CM",
                prefixIcon: Icon(Icons.height),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              controller: heightController,
            ),
            const SizedBox(height: 40.0),
            ConditionalBuilder(
              condition: state is SetUserLoadingState,
              builder: (context) => const CircularProgressIndicator(
                color: primarySwatch,
              ),
              fallback: (context) => defaultButton(
                submitFunction: () {
                  if (weightController.text.isEmpty ||
                      heightController.text.isEmpty) {
                    showToast(text: "Please enter valid data", success: false);
                  } else {
                    AppCubit.get(context).updateUser(
                        weight: weightController.text,
                        height: heightController.text);
                  }
                },
                text: 'Update info',
                background: primarySwatch,
              ),
            ),
            const SizedBox(height: 40.0),
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // if you need this
                side: const BorderSide(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: Container(
                color: Colors.white,
                width: 400,
                height: 200,
                child:Text('your bmr based on your height and weight is ${bmr.toInt()} calories per day.',
                    style: GoogleFonts.lato(
                      textStyle: Theme.of(context).textTheme.headline1,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                    )) ,
              ),
            ),

          ],
        ),
      );
    });
  }
}
