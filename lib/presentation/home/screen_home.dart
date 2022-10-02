import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bloc/application/home/homebloc_bloc.dart';
import 'package:netflix_bloc/core/colors/colors.dart';
import 'package:netflix_bloc/core/constant.dart';
import 'package:netflix_bloc/presentation/fast_laugh/widgets/icon_text_widget.dart';
import 'package:netflix_bloc/presentation/home/widgets/main_list.dart';
import 'package:netflix_bloc/presentation/home/widgets/number_card.dart';
import 'package:netflix_bloc/presentation/widgets/app_bar/app_bar.dart';
import 'package:netflix_bloc/presentation/widgets/maintitle/title.dart';

import 'widgets/background_image_card.dart';
import 'widgets/card_list_items.dart';

ValueNotifier<bool> scrolNotifier = ValueNotifier(true);

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeblocBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: scrolNotifier,
            builder: (BuildContext context, index, _) {
              return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;

                  if (direction == ScrollDirection.reverse) {
                    scrolNotifier.value = false;
                  } else if (direction == ScrollDirection.forward) {
                    scrolNotifier.value = true;
                  }
                  return true;
                },
                child: Stack(
                  children: [
                    BlocBuilder<HomeblocBloc, HomeblocState>(
                      builder: (context, state) {
                        if (state.isLoading) {
                          const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state.isError) {
                          const Center(
                            child: Text("Load Data is Failed"),
                          );
                        } else if (state.pastYearMovieList.isEmpty) {
                          return Text("NOdata");
                        }

                        //top10

                        var _top10 = state.trendingTvList.map((top10) {
                          return "$imageAppendUrl${top10.posterPath}";
                        }).toList();

                        if (_top10.length > 10) {
                          _top10 = _top10.sublist(0, 10);
                        }

                        //pastyearMovies
                        final _releasedPastYear =
                            state.pastYearMovieList.map((m) {
                          return "$imageAppendUrl${m.posterPath}";
                        }).toList();

                        //trending
                        final _trendingMovies =
                            state.trendingMovieList.map((m) {
                          return "$imageAppendUrl${m.posterPath}";
                        }).toList();

                        _trendingMovies.shuffle();

                        //tendDramas
                        final _tendDramas = state.tensDramaMovieList.map((m) {
                          return "$imageAppendUrl${m.posterPath}";
                        }).toList();
                        _tendDramas.shuffle();

                        //tendDramas
                        final _southIndian = state.southMovieList.map((m) {
                          return "$imageAppendUrl${m.posterPath}";
                        }).toList();

                        _southIndian.shuffle();

                        return ListView(
                          children: [
                            const BackgroundImageWidget(),
                            HorizonalMainList(
                              title: "Released In the Past Year",
                              posterList: _releasedPastYear,
                            ),
                            HorizonalMainList(
                              title: "Trending Now",
                              posterList: _trendingMovies,
                            ),
                            kHight10,
                            NumberTitleCard(top10: _top10),
                            HorizonalMainList(
                              title: "Tends Dramas",
                              posterList: _tendDramas,
                            ),
                            HorizonalMainList(
                              title: "South Indian Cinema",
                              posterList: _southIndian,
                            )
                          ],
                        );
                      },
                    ),
                    scrolNotifier.value == true
                        ? AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            width: double.infinity,
                            color: Colors.black.withOpacity(0.3),
                            height: 90,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Image.network(
                                      "https://cdn.dribbble.com/users/9378043/screenshots/16832559/netflix__1__4x.png",
                                      width: 50,
                                      height: 50,
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.cast,
                                      color: Colors.white,
                                    ),
                                    kWidth10,
                                    Container(
                                      color: Colors.blue,
                                      width: 30,
                                      height: 30,
                                    ),
                                    kWidth10
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      "Tvshows",
                                      style: kHomeText,
                                    ),
                                    Text(
                                      "Movies",
                                      style: kHomeText,
                                    ),
                                    Text(
                                      "Categories",
                                      style: kHomeText,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        : kHight10
                  ],
                ),
              );
            }));
  }
}

class NumberTitleCard extends StatelessWidget {
  final List<String> top10;
  const NumberTitleCard({
    required this.top10,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(titlePage: "Top 10 TV Shows India Today"),
        kHight10,
        LimitedBox(
            maxHeight: 200,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    top10.length,
                    (index) => NumberCard(
                          index: index,
                          posterPath: top10[index],
                        ))))
      ],
    );
  }
}
