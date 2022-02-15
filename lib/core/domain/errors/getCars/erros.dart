abstract class GetCarsException implements Exception {}

class FailureGetCars extends GetCarsException {}

class NoInternetConnectionGetCars extends GetCarsException {}