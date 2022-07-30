import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/shared/components/constants.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';

class FoodCalculator extends StatelessWidget {
  const FoodCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(listener: (context, state) {
      if (state is FoodRemoveSuccessState) {
        showToast(text: "Removed Successfully", success: true);
      }
      if (state is FoodCalculationEmpty) {
        showToast(text: "Please add food for the calculation", success: false);
      }
    }, builder: (context, state) {
      return Column(
        children: [
          Flexible(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: eatenFood.length,
                itemBuilder: (context, index) =>
                    ConditionalBuilder(
                        condition: state is! FoodRemoveState,
                        builder: (context) =>
                            Card(
                              elevation: 8,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: horizontalCardsCreator(
                                  index, AppCubit.get(context)),
                            ),
                        fallback: (context) =>
                        const CircularProgressIndicator(
                          color: primarySwatch,
                        )
                    )
            ),
          ),


          const SizedBox(
              height: 15.0
          ),
          defaultButton(
              background: primarySwatch,
              submitFunction: () {
                var cal = AppCubit.get(context).calculateCalculator();
                if (state is FoodCalculationSuccess) {
                  showToast(
                      text: "Total calories eaten $cal",
                      success: true);
                }
              },
              text: "Calculate"),
        ],
      );
    });
  }
  Widget horizontalCardsCreator(int index, cubit) {

    return Row(

      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Visibility(
            visible: true,
            child: AnimatedContainer(
              alignment: Alignment.center,
              duration: const Duration(seconds: 1),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  eatenFood[index].imageUrl,
                  height: 100,
                  width: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    eatenFood[index].foodName,
                    style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    eatenFood[index].calories,
                    style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    eatenFood[index].serving,
                    style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  )),
            ),
          ],
        ),

        GestureDetector(
          onTap: () {
            cubit.removeFood(index);
          },
          child: Expanded(
            child: Container(
                alignment: Alignment.centerRight,
                child: const Icon(Icons.highlight_remove_outlined)),
          ),
        )
      ],
    );
  }
}
