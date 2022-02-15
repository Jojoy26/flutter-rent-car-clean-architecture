abstract class GetBrandsException implements Exception{}

class FailureGetBrands extends GetBrandsException{}

class NoInternetConnectionGetBrands extends GetBrandsException {}