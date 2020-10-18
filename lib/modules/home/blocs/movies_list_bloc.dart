import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/exceptions/rest_exception.dart';
import '../../../shared/models/movie_model.dart';
import '../../../shared/repositories/interfaces/api_repository_interface.dart';

class MoviesListBloc extends Cubit<List<MovieModel>> {
  MoviesListBloc(this._client) : super(null) {
    this.getAllMoviesFromApi();
  }

  final IApiRepository _client;
  String _error;

  String get error => this._error;

  Future<void> getAllMoviesFromApi() async {
    try {
      final List<MovieModel> allMoviesList = await this._client.getAllMovies();
      this._error = null;
      emit(allMoviesList);
    } on RestException catch (e) {
      this._error = e.message;
      emit(<MovieModel>[]);
    }
  }

  void resetState() {
    this._error = null;
    emit(null);
  }
}
