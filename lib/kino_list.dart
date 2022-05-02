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
          picture: 'https://avatars.mds.yandex.net/get-zen_doc/225409/pub_61449c51e7c6b95d45dc0a01_614666689ee984048f4b5b5f/scale_1200',
          voteAverage: 8.9,
          releaseDate: '17.05.1997',
          description: 'О парне...',
          language: 'ru'),
      const Kino(
          id: '0002',
          title: 'Криминальное чтиво',
          picture: 'https://sfanytime-images-prod-http2.secure2.footprint.net/COVERM/99a66254-3e74-4698-b9fb-9f81010f5574_COVERM_01.jpg?w=375&ar=0.692&fit=crop&fm=pjpg&s=9b39d41ba54811a9f2ba609ee8d780dd',
          voteAverage: 9.0,
          releaseDate: '29.09.1995',
          description: 'Гангстеры...',
          language: 'uk'),
      const Kino(
          id: '0003',
          title: 'Пинокио',
          picture: 'https://media.filmz.ru/photos/full/filmz.ru_f_258413.jpg',
          voteAverage: 5.6,
          releaseDate: '12.03.2020',
          description: 'О бревне...',
          language: 'ital'),
      const Kino(
          id: '0004',
          title: 'Жандармы',
          picture: 'https://media.filmz.ru/photos/full/filmz.ru_f_183037.jpg',
          voteAverage: 4.2,
          releaseDate: 'дд.мм.гггг',
          description: 'Комедия...',
          language: 'fr'),
      const Kino(
          id: '0005',
          title: 'Танцор диско',
          picture: 'https://avatars.mds.yandex.net/get-zen_doc/1549204/pub_5d1b21e6d7427500ad006b66_5d1b22dc1b553600ad16d067/scale_1200',
          voteAverage: 3.7,
          releaseDate: 'дд.мм.гггг',
          description: 'Танцы, песни...',
          language: 'ind'),
      const Kino(
          id: '0006',
          title: 'Красавчик',
          picture: 'https://www.film.ru/sites/default/files/movies/posters/1627614-1639879.jpeg',
          voteAverage: 7.8,
          releaseDate: 'дд.мм.гггг',
          description: 'О неудачах...',
          language: 'de'),
    ];
  }
}
