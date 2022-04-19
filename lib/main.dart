import 'package:flutter/material.dart';

abstract class Film {
  const Film(this.id, this.title, this.picture, this.voteAverage,
      this.releaseDate, this.description, this.language);

  final String id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;

  void aboutFilm();
}

class Kino extends Film with FilmLanguageConvert {
  const Kino({
    required String id,
    required String title,
    required String picture,
    required double voteAverage,
    required String releaseDate,
    required String description,
    required String language,
  }) : super(id, title, picture, voteAverage, releaseDate, description,
            language);

  @override
  void aboutFilm() {
    var langType = getFilmLanguage(language);
    print(
        '$id Название: $title $picture Оценка: $voteAverage Дата выхода: $releaseDate Описание: $description Язык: ${langType.toPrettyString()}');
    // if (getFilmLanguage(language) == FilmLanguage.ru) {
    //  print('Русский язык');
  }
}

enum FilmLanguage { ru, uk, de, ital, fr, ind, unknown }

extension FilmLanguageExtension on FilmLanguage {
  String toPrettyString() {
    switch (this) {
      case FilmLanguage.ru:
        return 'Русский';
      case FilmLanguage.uk:
        return 'Английский';
      case FilmLanguage.de:
        return 'Немецкий';
      case FilmLanguage.ital:
        return 'Итальянский';
      case FilmLanguage.ind:
        return 'Хинди';
      case FilmLanguage.fr:
        return 'Французский';
      case FilmLanguage.unknown:
        return 'не установлен';
    }
  }
}

mixin FilmLanguageConvert {
  FilmLanguage getFilmLanguage(String language) {
    switch (language) {
      case 'ru':
        return FilmLanguage.ru;
      case 'uk':
        return FilmLanguage.uk;
      case 'de':
        return FilmLanguage.de;
      case 'ital':
        return FilmLanguage.ital;
      case 'ind':
        return FilmLanguage.ind;
      case 'fr':
        return FilmLanguage.fr;
      default:
        return FilmLanguage.unknown;
    }
  } //Миксин
}

void main() {
  /* Kino kino = Kino(
      id: '00001',
      title: 'Брат',
      picture: 'тут',
      voteAverage: 8.9,
      releaseDate: '12.5.2000',
      description: 'О парне',
      language: 'русский');
  kino.aboutFilm();*/
  List<Kino> kinoshki = _getKinoshki();
  for (final kino in kinoshki) {
    kino.aboutFilm();
  }
}

List<Kino> _getKinoshki() {
  return [
    const Kino(
        id: '0001',
        title: 'Брат',
        picture: '',
        voteAverage: 8.9,
        releaseDate: 'дд.мм.гггг',
        description: 'О парне...',
        language: 'ru'),
    const Kino(
        id: '0002',
        title: 'Криминальное чтиво',
        picture: '',
        voteAverage: 9.0,
        releaseDate: 'дд.мм.гггг',
        description: 'Гангстеры...',
        language: 'uk'),
    const Kino(
        id: '0003',
        title: 'Пинокио',
        picture: '',
        voteAverage: 5.6,
        releaseDate: 'дд.мм.гггг',
        description: 'О бревне...',
        language: 'ital'),
    const Kino(
        id: '0004',
        title: 'Жандармы',
        picture: '',
        voteAverage: 4.2,
        releaseDate: 'дд.мм.гггг',
        description: 'Комедия...',
        language: 'fr'),
    const Kino(
        id: '0005',
        title: 'Диско',
        picture: '',
        voteAverage: 3.7,
        releaseDate: 'дд.мм.гггг',
        description: 'Танцы, песни...',
        language: 'ind'),
    const Kino(
        id: '0006',
        title: 'Красавчик',
        picture: '',
        voteAverage: 7.8,
        releaseDate: 'дд.мм.гггг',
        description: 'О неудачах...',
        language: 'de'),
  ];
}
