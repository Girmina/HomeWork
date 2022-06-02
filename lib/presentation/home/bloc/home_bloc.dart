import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homework_6/components/constants.dart';
import 'package:homework_6/data/repositories/movies_repository.dart';
import 'package:homework_6/domain/models/movie_card_model.dart';
import 'package:homework_6/presentation/home/bloc/home_event.dart';
import 'package:homework_6/presentation/home/bloc/home_state.dart';
import 'package:collection/collection.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MoviesRepository repository;

  HomeBloc(this.repository) : super(const HomeState()) {
    on<LoadDataEvent>(_onLoadData);
    on<SearchChangedEvent>(_onSearchChanged);

    // Добавим обработчики события
    on<ChangedFavourites>(_onClickFavourites);
    on<ChangedMoviesDB>(_onChangedDB);

    // Подписываемя на Stream об изменении данных в БД
    repository
        .onChangedMoviesDB()
        .listen((List<MovieCardModel> changedMovieDB) {
      add(ChangedMoviesDB(models: changedMovieDB));
    });
  }

  String get search {
    final stateSearch = state.search;
    return (stateSearch != null && stateSearch.isNotEmpty)
        ? stateSearch
        : MovieQuery.initialQ;
  }

  void _onSearchChanged(SearchChangedEvent event, Emitter<HomeState> emit) {
    // search must be emitted before loading data
    emit(state.copyWith(search: event.search));
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onLoadData(LoadDataEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(data: repository.loadData(q: search)));
  }

  void _onClickFavourites(
      ChangedFavourites event, Emitter<HomeState> emit) async {
    final MovieCardModel? targetMovie = event.model;

    MovieCardModel? movie;
    // Проверяем что список избранных не пуст
    if (state.favouritesMovies?.isNotEmpty == true) {
      // проверяем есть ли в избранном фильм
      movie = state.favouritesMovies
          ?.firstWhereOrNull((element) => element.id == targetMovie?.id);
    }
    // если есть удаляем из базы, если нет то добавляем в базу
    if (movie != null) {
      await repository.deleteMovieDB(movie.id);
    } else if (targetMovie != null) {
      await repository.insertMovieDB(targetMovie);
    }
  }

  void _onChangedDB(ChangedMoviesDB event, Emitter<HomeState> emit) {
    emit(state.copyWith(favouritesMovies: event.models));
  }
}
