import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/blocs/favorite_movie_list_bloc.dart';
import '../../../shared/models/movie_details_model.dart';
import '../../../shared/models/movie_model.dart';
import '../../favorites/views/favorites_screen.dart';

class MovieDetailsScreen extends StatefulWidget {
  static String route = "movie_details";

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel movieData =
        ModalRoute.of(context).settings.arguments as MovieDetailsModel;

    final FavoriteMovieListBloc _favoriteMovieListBloc =
        BlocProvider.of<FavoriteMovieListBloc>(context);
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: _favoriteMovieListBloc.movieDetailsScaffoldKey,
      body: SafeArea(
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          child: Column(
            children: [
              _buildHeader(context, _favoriteMovieListBloc, movieData),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    _buildMoviePoster(movieData, screenSize),
                    const SizedBox(width: 10.0),
                    _buildMovieInfo(movieData),
                  ],
                ),
              ),
              _buildMovieFullSinopse(movieData),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildMovieInfo(MovieDetailsModel movieData) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movieData.movieModel.titulo,
              style: const TextStyle(fontSize: 32.0)),
          const SizedBox(height: 20.0),
          Text("Lançamento: ${movieData.movieModel.data}"),
          Text("Gênero: ${movieData.movieModel.genero}"),
        ],
      ),
    );
  }

  Hero _buildMoviePoster(MovieDetailsModel movieData, Size screenSize) {
    return Hero(
      tag: movieData.heroTag,
      child: CachedNetworkImage(
        imageUrl: movieData.movieModel.poster,
        height: screenSize.height * .3,
      ),
    );
  }

  Expanded _buildMovieFullSinopse(MovieDetailsModel movieData) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: SingleChildScrollView(
          child: Text(
            movieData.movieModel.sinopseFull.replaceFirst("\n", ""),
            textAlign: TextAlign.justify,
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
      BuildContext context,
      FavoriteMovieListBloc _favoriteMovieListBloc,
      MovieDetailsModel movieData) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          BlocBuilder<FavoriteMovieListBloc, List<MovieModel>>(
            builder: (_, favoriteMovieList) {
              return IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                icon: Icon(
                  _favoriteMovieListBloc.isMovieFavorite(movieData.movieModel)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  _favoriteMovieListBloc.setFavoriteMovie(
                    movieData.movieModel,
                    onMaxFavoritesReached: () =>
                        Navigator.of(context).pushNamed(FavoritesScreen.route),
                  );
                  // _favoriteMovieListBloc.getAllFavoriteMovies();
                },
              );
            },
          )
        ],
      ),
    );
  }
}
