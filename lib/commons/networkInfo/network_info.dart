import 'package:connectivity/connectivity.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();
}

class NetworkInfoImpl implements NetworkInfo {

  final Connectivity connectivity;
  
  NetworkInfoImpl({
    required this.connectivity,
  });

  @override
  Future<bool> isConnected() async{
    var connect = await connectivity.checkConnectivity();
    if(connect == ConnectivityResult.none){
      return false;
    } 
    return true;
  }
}
