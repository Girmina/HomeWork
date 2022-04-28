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
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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
