import 'package:cine_app/movies/data/datasource/movies_remote_data_source.dart';
import 'package:cine_app/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:cine_app/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:cine_app/movies/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:cine_app/movies/presentation/controllers/movie_details_controller/movie_details_bloc.dart';

import 'package:get_it/get_it.dart';

import '../../movies/data/datasource/base_movies_remote_data_source.dart';
import '../../movies/data/repository/movies_repo_impl.dart';
import '../../movies/domain/repository/movies_repo.dart';
import '../../movies/domain/usecases/get_now_playing_usecase.dart';
import '../../movies/presentation/controllers/movie_controller/movies_bloc.dart';

// registerLazySingleton: create this when it's used.

// registerSingleton: create this when the function is called, even if this isn't used.

// registerFactory: create new instance of this, it helps in reloading data.

final GetIt servicesLocator = GetIt.instance;

class ServicesLocator {
  void setupServiceLocator() {
    // BLOCs
    servicesLocator.registerFactory<MoviesBloc>(
      () => MoviesBloc(
        getNowPlayingMoviesUseCase:
            servicesLocator.get<GetNowPlayingMoviesUseCase>(),
        getPopularMoviesUseCase: servicesLocator.get<GetPopularMoviesUseCase>(),
        getTopRatedMoviesUseCase:
            servicesLocator.get<GetTopRatedMoviesUseCase>(),
      ),
    );

    servicesLocator.registerFactory<MovieDetailsBloc>(
      () => MovieDetailsBloc(
        servicesLocator.get<GetMovieDetailsUseCase>(),
      ),
    );

    // USECASES
    servicesLocator.registerLazySingleton<GetNowPlayingMoviesUseCase>(() {
      return GetNowPlayingMoviesUseCase(servicesLocator.get<MoviesRepo>());
    });

    servicesLocator.registerLazySingleton<GetPopularMoviesUseCase>(() {
      return GetPopularMoviesUseCase(servicesLocator.get<MoviesRepo>());
    });

    servicesLocator.registerLazySingleton<GetTopRatedMoviesUseCase>(() {
      return GetTopRatedMoviesUseCase(servicesLocator.get<MoviesRepo>());
    });

    servicesLocator.registerLazySingleton<GetMovieDetailsUseCase>(() {
      return GetMovieDetailsUseCase(servicesLocator.get<MoviesRepo>());
    });

    // REPOSITORY
    servicesLocator.registerLazySingleton<MoviesRepo>(() {
      return MoviesRepoImpl(servicesLocator.get<BaseMoviesRemoteDataSource>());
    });

    // DATA SOURCE
    servicesLocator.registerLazySingleton<BaseMoviesRemoteDataSource>(() {
      return MoviesRemoteDataSource();
    });
  }
}
