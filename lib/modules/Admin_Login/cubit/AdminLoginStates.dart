abstract class AdminLoginStates {}

class AdminInitialState extends AdminLoginStates {}

class AdminLoginSuccessState extends AdminLoginStates {
  // final String? uid;
  // AdminLoginSuccessState(this.uid);
}

class AdminLoginLoadingState extends AdminLoginStates {}

class AdminLoginErrorState extends AdminLoginStates {
  final String error;
  AdminLoginErrorState(this.error);
}

