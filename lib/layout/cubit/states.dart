
abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppChangeBottomNavBarState extends AppStates {
  final int index;
  AppChangeBottomNavBarState(this.index);

}

//food screen
class GetFoodSuccessState extends AppStates{}

class GetFoodLoadingState extends AppStates{}

class GetFoodErrorState extends AppStates{
  final String error;
  GetFoodErrorState(this.error);

}
//search screen
class SearchFoodLoadingState extends AppStates{}
class SearchFoodSuccessState extends AppStates{}

class SearchFoodFailState extends AppStates{}

//Food calculator screen
class FoodRemoveState extends AppStates{}
class FoodRemoveSuccessState extends AppStates{}
class FoodCalculationEmpty extends AppStates{}
class FoodCalculationSuccess extends AppStates{}

//personal info

class GetUserSuccessState extends AppStates{}

class GetUserLoadingState extends AppStates{}

class GetUserErrorState extends AppStates{
  final String error;
  GetUserErrorState(this.error);

}

class SetUserSuccessState extends AppStates{}

class SetUserLoadingState extends AppStates{}

class SetUserErrorState extends AppStates{
  final String error;
  SetUserErrorState(this.error);

}

//class AppLoginLoadingState extends AppStates {}

