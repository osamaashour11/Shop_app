abstract class SearchShopAppStates {}

class InitializeSearchShopAppState extends SearchShopAppStates {}

class LoadingSearchShopAppState extends SearchShopAppStates {}

class SuccessSearchShopAppState extends SearchShopAppStates {}

class ErrorSearchShopAppState extends SearchShopAppStates {
  final String error;

  ErrorSearchShopAppState(this.error);
}
