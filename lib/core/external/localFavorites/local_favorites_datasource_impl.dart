import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_rent/core/infra/datasources/favorites_datasource.dart';

class LocalFavoritesDatasourceImpl implements FavoritesDatasource {

  @override
  Future<List<String>> getFavorites() async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final result = preferences.getStringList("favoritesList");
      if(result == null) return [] as List<String>;
      return result;
    } catch (e){
      throw Exception();
    }
  }

  @override
  Future<List<String>> saveFavorites(List<String> list) async {
    try {
      final SharedPreferences preferences = await SharedPreferences.getInstance();
      final result = await preferences.setStringList("favoritesList", list);
      if(!result) throw Exception();
      return list;
    } catch (e){
      throw Exception();
    }
  }
}
