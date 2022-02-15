import 'package:flutter_rent/core/presentation/commons/call_snackbar.dart';
import 'package:get/get.dart';

import 'package:flutter_rent/core/domain/usecases/get_favorites.dart';
import 'package:flutter_rent/core/domain/usecases/save_favorites.dart';

class GetxFavoritesPresenter extends GetxController {
  
  final GetFavorites getFavoritesUsecase;
  final SaveFavorites saveFavoritesUsecase;
  GetxFavoritesPresenter({
    required this.getFavoritesUsecase,
    required this.saveFavoritesUsecase,
  });

  RxList<String> favoritesList = <String>[].obs;

  Future callGetFavorites() async {
    final result = await getFavoritesUsecase.call();

    result.fold(
      (l){
        
      }, 
      (r){
        favoritesList.value = r;
      }
    );
  }

  Future callSaveFavorites() async {

    final result = await saveFavoritesUsecase.call(favoritesList.value);

    result.fold(
      (l){
        callSnackBar("Error", "Failed on add item to favorites");
      }, 
      (r){
        
      }
    );
  }

  bool isFavorite (String ref) {
    return favoritesList.contains(ref);
  }
  
  Future toggleFavorite(String ref) async{
    if(isFavorite(ref)){
      _removeFavorite(ref);
    } else {
      _addFavorite(ref);
    }
  }

  Future _addFavorite(String ref) async{
    favoritesList.add(ref);
    final result = await saveFavoritesUsecase.call(favoritesList);

    result.fold(
      (l) {
        callSnackBar("Error", "Failed on add car to favorites");
      }, 
      (r) {

      }
    );
  }

  Future _removeFavorite(String ref) async {
    favoritesList.removeWhere((item) => item == ref);
    final result = await saveFavoritesUsecase.call(favoritesList);

    result.fold(
      (l) {
        callSnackBar("Error", "Failed on remove car to favorites");
      }, 
      (r) {
        
      }
    );
  }

}
