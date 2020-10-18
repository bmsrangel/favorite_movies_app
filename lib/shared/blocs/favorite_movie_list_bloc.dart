import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/movie_model.dart';
import '../services/interfaces/local_storage_interface.dart';
import '../utils/utils.dart';

class FavoriteMovieListBloc extends Cubit<List<MovieModel>> {
  FavoriteMovieListBloc(this._localStorage) : super(null) {
    this.getAllFavoriteMovies();
  }

  final ILocalStorage _localStorage;
  List<MovieModel> favoriteMovies;
  final GlobalKey<ScaffoldState> movieDetailsScaffoldKey =
      GlobalKey<ScaffoldState>();

  Future<void> getAllFavoriteMovies() async {
    final List<MovieModel> auxList =
        await this._localStorage.getFavoriteMovies();
    if (auxList == null) {
      this.favoriteMovies = <MovieModel>[];
    } else {
      this.favoriteMovies = List<MovieModel>.from(auxList);
    }
    emit(this.favoriteMovies);
  }

  Future<void> setFavoriteMovie(MovieModel movieModel,
      {Function onMaxFavoritesReached}) async {
    if (!this.isMovieFavorite(movieModel) && this.favoriteMovies.length < 3) {
      this.favoriteMovies.add(movieModel);
      this.storeAndEmitFavoriteMovieList();
    } else if (this.isMovieFavorite(movieModel)) {
      this.favoriteMovies.remove(movieModel);
      this.storeAndEmitFavoriteMovieList();
    } else {
      Utils.showSnackBar(this.movieDetailsScaffoldKey,
          "Máximo de favoritos atingido (3)", onMaxFavoritesReached);
    }
  }

  Future<void> storeAndEmitFavoriteMovieList() async {
    this.favoriteMovies = List.from(this.favoriteMovies);
    emit(this.favoriteMovies);
    await this._localStorage.setFavoriteMovies(this.favoriteMovies);
  }

  bool isMovieFavorite(MovieModel movieModel) {
    return this.favoriteMovies.contains(movieModel);
  }
}
