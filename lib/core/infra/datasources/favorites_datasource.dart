abstract class FavoritesDatasource {
  Future<List<String>> getFavorites();
  Future<List<String>> saveFavorites(List<String> list);
}