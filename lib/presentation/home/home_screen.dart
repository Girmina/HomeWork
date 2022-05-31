import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homework_5/components/constants.dart';
import 'package:homework_5/components/delayed_action.dart';
import 'package:homework_5/domain/models/home_model.dart';
import 'package:homework_5/presentation/home/bloc/home_bloc.dart';
import 'package:homework_5/presentation/home/bloc/home_event.dart';
import 'package:homework_5/presentation/home/bloc/home_state.dart';
import 'package:homework_5/presentation/home/movie_card.dart';

/// Наш главный экран
class HomeScreen extends StatefulWidget {
  static final GlobalKey<State<StatefulWidget>> globalKey = GlobalKey();

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// Контроллер для работы с полем поиска
  final TextEditingController textController = TextEditingController();

  /// Загрузим наши фильмы сразу при запуске
  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(LoadDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      key: HomeScreen.globalKey,
      child: Scaffold(
        // Используем чтобы не закрывать список с фильмами клавиатурой
        resizeToAvoidBottomInset: true,
        backgroundColor: MovieColors.backgroundBlackColor,
        body: Column(
          children: [
            // Поле поиска
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: TextField(
                controller: textController,
                maxLines: 1,
                decoration: const InputDecoration(
                  labelText: MovieLocal.search,
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: _onSearchFieldTextChanged,
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              buildWhen: (oldState, newState) => oldState.data != newState.data,
              builder: (context, state) {
                return FutureBuilder<HomeModel?>(
                  future: state.data,
                  builder:
                      (BuildContext context, AsyncSnapshot<HomeModel?> data) {
                    return data.connectionState != ConnectionState.done
                        ? const Center(child: CircularProgressIndicator())
                        : data.hasData
                            ? data.data?.results?.isNotEmpty == true
                                ? Expanded(
                                    child: ListView.builder(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return MovieCard(
                                          movieCardModel:
                                              data.data?.results?[index],
                                          key: ValueKey<int>(
                                              data.data?.results?[index].id ??
                                                  -1),
                                        );
                                      },
                                      itemCount:
                                          data.data?.results?.length ?? 0,
                                    ),
                                  )
                                : const _Empty()
                            : const _Error();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Данный метод вызывается каждый раз при изменениях в поле поиска
  void _onSearchFieldTextChanged(String text) {
    DelayedAction.run(() {
      context.read<HomeBloc>().add(SearchChangedEvent(search: text));
    });
  }
}

class _Error extends StatelessWidget {
  const _Error({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(MovieQuery.pisecImageUrl, fit: BoxFit.cover);
  }
}

class _Empty extends StatelessWidget {
  const _Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(MovieQuery.nothingImageUrl, fit: BoxFit.cover);
  }
}
