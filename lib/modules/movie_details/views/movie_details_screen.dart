import 'package:cached_network_image/cached_network_image.dart';
import '../../../shared/models/movie_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../shared/blocs/favorite_movie_list_bloc.dart';
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
    final MovieDetailsModel args =
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
              Padding(
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
                            _favoriteMovieListBloc
                                    .isMovieFavorite(args.movieModel)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            _favoriteMovieListBloc.setFavoriteMovie(
                              args.movieModel,
                              onMaxFavoritesReached: () => Navigator.of(context)
                                  .pushNamed(FavoritesScreen.route),
                            );
                            // _favoriteMovieListBloc.getAllFavoriteMovies();
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Row(
                  children: [
                    Hero(
                      tag: args.heroTag,
                      child: CachedNetworkImage(
                        imageUrl: args.movieModel.poster,
                        height: screenSize.height * .3,
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(args.movieModel.titulo,
                              style: const TextStyle(fontSize: 32.0)),
                          const SizedBox(height: 20.0),
                          Text("Lançamento: ${args.movieModel.data}"),
                          Text("Gênero: ${args.movieModel.genero}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  child: SingleChildScrollView(
                    child: Text(
                      args.movieModel.sinopseFull.replaceFirst("\n", ""),
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
