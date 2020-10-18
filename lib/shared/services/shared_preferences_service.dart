import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/movie_model.dart';
import 'interfaces/local_storage_interface.dart';

class SharedPreferencesService implements ILocalStorage {
  final Future<SharedPreferences> sharedPreferencesInstance =
      SharedPreferences.getInstance();

  @override
  Future<List<MovieModel>> getFavoriteMovies() async {
    final SharedPreferences prefs = await this.sharedPreferencesInstance;
    final String favoriteMoviesString = prefs.getString("favorites");
    if (favoriteMoviesString != null) {
      final List<Map<String, dynamic>> decodedFavoriteMoviesList =
          List<Map<String, dynamic>>.from(
              json.decode(favoriteMoviesString) as List);
      return decodedFavoriteMoviesList
          .map((movieMap) => MovieModel.fromMap(movieMap))
          .toList();
    } else {
      return null;
    }
  }

  @override
  Future<void> setFavoriteMovies(List<MovieModel> favoriteMoviesList) async {
    final SharedPreferences prefs = await this.sharedPreferencesInstance;
    final List<Map> favoriteMoviesMapList =
        favoriteMoviesList.map((movieModel) => movieModel.toMap()).toList();
    final String favoriteMoviesString = json.encode(favoriteMoviesMapList);
    await prefs.setString("favorites", favoriteMoviesString);
  }
}
