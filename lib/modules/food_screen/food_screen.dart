import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';


class FoodScreen extends StatelessWidget {

  const FoodScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {
          if(state is GetFoodErrorState){
            showToast(text: state.error, success: false);
          }

        },
        builder: (context, state) {

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: (80/100),  //itemWidth / itemHeight
            children: List.generate(foodObjects.length, (index) {
              //AppCubit.get(context).foodObjects.length
              return Center(
                  child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: imageCreator(index),
              ));
            }),
          );
        });
  }





}
