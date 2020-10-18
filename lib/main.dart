import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/favorites/views/favorites_screen.dart';
import 'modules/home/blocs/movies_list_bloc.dart';
import 'modules/home/views/home_screen.dart';
import 'modules/movie_details/views/movie_details_screen.dart';
import 'shared/blocs/favorite_movie_list_bloc.dart';
import 'shared/repositories/api_repository.dart';
import 'shared/repositories/interfaces/api_repository_interface.dart';
import 'shared/services/interfaces/local_storage_interface.dart';
import 'shared/services/shared_preferences_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ILocalStorage>(
          create: (_) => SharedPreferencesService(),
        ),
        RepositoryProvider<Dio>(
          create: (_) => Dio(
              BaseOptions(baseUrl: "https://filmespy.herokuapp.com/api/v1")),
        ),
        RepositoryProvider<IApiRepository>(
          create: (context) => ApiRepository(context.repository<Dio>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MoviesListBloc>(
            create: (context) =>
                MoviesListBloc(context.repository<IApiRepository>()),
          ),
          BlocProvider<FavoriteMovieListBloc>(
            create: (context) =>
                FavoriteMovieListBloc(context.repository<ILocalStorage>()),
            lazy: false,
          ),
        ],
        child: MaterialApp(
          title: 'Catálogo de Filmes Favoritos',
          theme: ThemeData(
            primaryColor: Colors.deepPurple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              textTheme: TextTheme(
                headline6: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          initialRoute: HomeScreen.route,
          routes: {
            HomeScreen.route: (context) => HomeScreen(),
            MovieDetailsScreen.route: (context) => MovieDetailsScreen(),
            FavoritesScreen.route: (context) => FavoritesScreen(),
          },
        ),
      ),
    );
  }
}
