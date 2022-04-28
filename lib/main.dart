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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.lime,
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
  final List<Kino> kinoshki = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KinoClab'),
      ),
      body: Column(children: <Widget>[
        for (Kino kino in kinoshki)
          FilmCard(
            id: kino.id,
            title: kino.title,
            voteAverage: kino.voteAverage,
            description: kino.description,
            picture: kino.picture,
            language: kino.language,
            releaseDate: kino.releaseDate,
          ),
      ]),
    );
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
      color: Colors.grey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Image.network(
                'https://avatars.mds.yandex.net/get-kinopoisk-image/1704946/e9008e2f-433f-43b0-b9b8-2ea8e3fb6c9b/600x900'),
          ),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
