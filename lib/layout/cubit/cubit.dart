import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_system/layout/cubit/states.dart';
import 'package:gym_system/modules/food_calculator_screen/food_calculator.dart';
import 'package:gym_system/modules/personal_info/personal_info.dart';
import 'package:gym_system/modules/steps_calculator/steps_calculator.dart';
import 'package:gym_system/shared/network/local/cache_helper.dart';
import 'package:gym_system/shared/network/remote/fire_base.dart';
import '../../models/user_model/food_model.dart';
import '../../models/user_model/user_model.dart';
import '../../modules/food_screen/food_screen.dart';
import '../../shared/components/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int currentScreenIndex = 0;

  List<Widget> screens = [
    const FoodScreen(),
    const FoodCalculator(),
    StepsCalculator(),
    const PersonalInfoScreen(),
  ];

  void changeNavButton(int index) {
    if (index == 0) {
      getFoodData();
    }
    currentScreenIndex = index;
    emit(AppChangeBottomNavBarState(index));
  }

//food calculator screen

  void removeFood(int index) {
    eatenFood.removeAt(index);
    emit(FoodRemoveState());
    sleep(const Duration(milliseconds: 300));
    emit(FoodRemoveSuccessState());
  }

  calculateCalculator() {
    int totalCal = 0;
    if (eatenFood.isEmpty) {
      emit(FoodCalculationEmpty());
    } else {
      for (var element in eatenFood) {
        var values = element.calories.split(" ");

        totalCal += int.parse(values[0]);
      }
      if (totalCal > 0) {
        emit(FoodCalculationSuccess());
      }
      return totalCal;
    }
  }

  //personal info
  getUser() {
    emit(GetUserLoadingState());

    String uId = CacheHelper.getUserId();
    db.collection("Users").doc(uId).get().then(
        (value) => storeFirebaseData(value),
        onError: (error) => emit(
            GetUserErrorState("Make sure you are connected to the internet")));
  }

  storeFirebaseData(var data) {
    userModel = UserModel(data['uId'], data['userName'], data['name'],
        data['weight'], data['height']);
    print(userModel.height);
    emit(GetUserSuccessState());
  }

  updateUser({required String weight, required String height}) {
    emit(SetUserLoadingState());
    db
        .collection("Users")
        .doc(userModel.uId)
        .update({'weight': weight, 'height': height})
        .then((value) => emit(SetUserSuccessState()))
        .catchError((error) {
          emit(SetUserErrorState(
              "Please make sure you have internet connection"));
        });
  }

  calculateBMR(int weight, int height) {
    return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * 30);
  }

//firebase access

  void getFoodData() async {
    emit(GetFoodLoadingState());
    db.collection("Food").get().then(
          (value) => loopAndStoreObjects(value.docs), //value.forEach(k,v){},
          onError: (e) => emit(GetFoodErrorState(
              "Make sure you have internet connection and try again")),
        );
  }

  void loopAndStoreObjects(dynamic data) {
    foodObjects = [];
    foodNames = [];

    for (var element in data) {
      foodObjects.add(FoodModel(
          foodName: element['Food'],
          calories: element['Calories'],
          serving: element['Serving'],
          imageUrl: element['image_url']));
      foodNames.add(element['Food']);
    }

    emit(GetFoodSuccessState());
  }

  List<int> searchFood(String food) {
    emit(SearchFoodLoadingState());
    List<int> indexOfEatenFood = [];

    for (int i = 0; i < foodNames.length; i++) {
      if (equalsIgnoreCase(foodNames[i], food)) {
        indexOfEatenFood.add(i);
      }
    }

    if (indexOfEatenFood.isEmpty) {
      emit(SearchFoodFailState());
    } else {
      emit(SearchFoodSuccessState());
    }
    return indexOfEatenFood;
  }

  bool equalsIgnoreCase(String string1, String string2) {
    return string1.toLowerCase().contains(string2.toLowerCase());
  }
}

//db.collection("cities").get().then(
//       (res) => print("Successfully completed"),
//       onError: (e) => print("Error completing: $e"),
//     );
