import 'package:shared_preferences/shared_preferences.dart';

abstract class SearchLocalDataSource {
  Future<List<String>> getRecentSearches();
  Future<void> saveRecentSearch(String query);
  Future<void> removeRecentSearch(String query);
}

class SearchLocalDataSourceImpl implements SearchLocalDataSource {
  final SharedPreferences sharedPreferences;
  static const String recentSearchesKey = 'recent_searches';

  SearchLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<String>> getRecentSearches() async {
    final searches = sharedPreferences.getStringList(recentSearchesKey);
    return searches ?? [];
  }

  @override
  Future<void> removeRecentSearch(String query) async {
    List<String> searches = await getRecentSearches();
    searches.remove(query);
    await sharedPreferences.setStringList(recentSearchesKey, searches);
  }

  @override
  Future<void> saveRecentSearch(String query) async {
    List<String> searches = await getRecentSearches();
    searches.remove(query); // Remove if it already exists to put it at the top
    searches.insert(0, query);

    if (searches.length > 5) {
      searches = searches.sublist(0, 5); // Keep max 5
    }

    await sharedPreferences.setStringList(recentSearchesKey, searches);
  }
}
