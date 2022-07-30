

abstract class AdminSignUpStates{}

class AdminSignUpStatesInitial extends AdminSignUpStates{}

class AdminSignUpStatesLoading extends AdminSignUpStates{}

class AdminSignUpStatesSuccess extends AdminSignUpStates{}

class AdminSignUpStatesError extends AdminSignUpStates{
  final String error;
  AdminSignUpStatesError(this.error);
}