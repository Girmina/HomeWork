import 'package:flutter/material.dart';
import 'package:homework_2_0/kino_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Films',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Kino> kinoshki = [];
  bool filterWeight = false;

  @override
  void initState() {
    _getKinoshki().then((value) {
      setState(() {
        kinoshki = value;
      });
    });
    super.initState();
  }

  Future<List<Kino>> _getKinoshki() async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const Kino(
          id: '0001',
          title: 'Брат',
          picture:
              'https://avatars.mds.yandex.net/get-zen_doc/225409/pub_61449c51e7c6b95d45dc0a01_614666689ee984048f4b5b5f/scale_1200',
          voteAverage: 8.9,
          releaseDate: '1997',
          description: 'О парне...',
          language: 'ru'),
      const Kino(
          id: '0002',
          title: 'Криминальное чтиво',
          picture:
              'https://sfanytime-images-prod-http2.secure2.footprint.net/COVERM/99a66254-3e74-4698-b9fb-9f81010f5574_COVERM_01.jpg?w=375&ar=0.692&fit=crop&fm=pjpg&s=9b39d41ba54811a9f2ba609ee8d780dd',
          voteAverage: 9.0,
          releaseDate: '1995',
          description: 'Гангстеры...',
          language: 'uk'),
      const Kino(
          id: '0003',
          title: 'Пинокио',
          picture: 'https://media.filmz.ru/photos/full/filmz.ru_f_258413.jpg',
          voteAverage: 5.6,
          releaseDate: '2020',
          description: 'О бревне...',
          language: 'ital'),
      const Kino(
          id: '0004',
          title: 'Жандармы',
          picture: 'https://media.filmz.ru/photos/full/filmz.ru_f_183037.jpg',
          voteAverage: 4.2,
          releaseDate: '1962',
          description: 'Комедия...',
          language: 'fr'),
      const Kino(
          id: '0005',
          title: 'Танцор диско',
          picture:
              'https://avatars.mds.yandex.net/get-zen_doc/1549204/pub_5d1b21e6d7427500ad006b66_5d1b22dc1b553600ad16d067/scale_1200',
          voteAverage: 3.7,
          releaseDate: '1981',
          description: 'Танцы, песни...',
          language: 'ind'),
      const Kino(
          id: '0006',
          title: 'Красавчик',
          picture:
              'https://www.film.ru/sites/default/files/movies/posters/1627614-1639879.jpeg',
          voteAverage: 7.8,
          releaseDate: '2004',
          description: 'О неудачах...',
          language: 'de'),
    ];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent[100],
      appBar: AppBar(
          backgroundColor: Colors.teal,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.movie_filter),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Checkbox(
                  value: filterWeight,
                  onChanged: (bool? changeValue) {
                    setState(() {
                      filterWeight = changeValue ?? false;
                    });
                  },
                ),
                const Text('Высокий рейтинг'),
              ],
            ),
            ElevatedButton(
              onPressed: filterKino,
              child: const Text('Поиск'),
            ),
            ...List.generate(kinoshki.length, (index) {
              return FilmCard(
                id: kinoshki[index].id,
                title: kinoshki[index].title,
                voteAverage: kinoshki[index].voteAverage,
                description: kinoshki[index].description,
                picture: kinoshki[index].picture,
                language: kinoshki[index]
                    .getFilmLanguage(kinoshki[index].language)
                    .toPrettyString(),
                releaseDate: kinoshki[index].releaseDate,
              );
            }),
          ],
        ),
      ),
    );
  }

  Future<void> filterKino() async {
    await _getKinoshki().then((valueKinoshki) {
      setState(() {
        if (filterWeight) {
          kinoshki = valueKinoshki
              .where((element) => element.voteAverage > 8)
              .toList();
        } else {
          kinoshki = valueKinoshki;
        }
      });
    });
  }
}

class FilmCard extends StatelessWidget {
  const FilmCard({
    Key? key,
    required this.id,
    required this.title,
    required this.picture,
    required this.voteAverage,
    required this.releaseDate,
    required this.description,
    required this.language,
  }) : super(key: key);

  final String id;
  final String title;
  final String picture;
  final double voteAverage;
  final String releaseDate;
  final String description;
  final String language;

  @override

  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16.0),
        //  color: Colors.grey,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
               padding: const EdgeInsets.only(),
                child: Container(
                  padding: const EdgeInsets.only(left:16,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        'Оценка $voteAverage',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text('Год  ' + releaseDate,
                          style: Theme.of(context).textTheme.bodyLarge),
                      Text ('Описание: '+description,
                      style: Theme.of(context).textTheme.bodySmall),
                      Text('Язык: ${language},',
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                color: Colors.teal,
                height: 160,
              ),
            ),
            Container(
              color: Colors.teal,
              height: 160,
              width: 20,
            ),
            Expanded(
              child: Container(
                color: Colors.teal,
                child: Image.network('' + picture, width: 300, height: 160),
                height: 160,
              ),
            ),
          ],
          /* child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
              flex: 2,

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox( width: 320, height: 240,
                        child: Image.network('' + picture,)),
                    Column(
                      children: [
                        Text(
                          'Название: ' + title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          'Оценка $voteAverage',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          'Год  ' + releaseDate,
                          style: Theme.of(context).textTheme.bodyLarge,*/
        ));
  }
}
