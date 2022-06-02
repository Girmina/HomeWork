import 'package:equatable/equatable.dart';
import 'package:homework_6/domain/models/movie_card_model.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class SearchChangedEvent extends HomeEvent {
  final String search;

  const SearchChangedEvent({required this.search});

  @override
  List<Object> get props => [search];
}

class LoadDataEvent extends HomeEvent {}

/// Добавление / удаление избарнно по клику на кнопку
class ChangedFavourites extends HomeEvent {
  final MovieCardModel? model;

  const ChangedFavourites({required this.model});
}

/// Событие о изменении данных в БД
class ChangedMoviesDB extends HomeEvent {
  final List<MovieCardModel> models;

  const ChangedMoviesDB({required this.models});
}
