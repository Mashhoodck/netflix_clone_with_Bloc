import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bloc/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_bloc/core/colors/colors.dart';
import 'package:netflix_bloc/presentation/fast_laugh/widgets/icon_text_widget.dart';

import '../../core/constant.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Movies & Hot",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            actions: [
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
            bottom: TabBar(
                isScrollable: true,
                unselectedLabelColor: kWihiteColor,
                labelColor: kBlackColor,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                indicator:
                    BoxDecoration(borderRadius: kRadius30, color: kWihiteColor),
                tabs: const [
                  Tab(
                    text: "Coming Soon",
                  ),
                  Tab(
                    text: "EveryOne's Watching",
                  )
                ]),
          ),
          body: const TabBarView(
              children: [ComingSoonWidget(), EveryonesWatchingWidget()])),
    );
  }
}

class EveryonesWatchingWidget extends StatelessWidget {
  const EveryonesWatchingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryonesWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryonesWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.hasError) {
            return const Center(
              child: Text("Error Loading Data"),
            );
          } else if (state.evryonesWatchList.isEmpty) {
            return const Center(
              child: Text("No data Loaded"),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: state.evryonesWatchList.length,
                itemBuilder: (context, index) {
                  final movie = state.evryonesWatchList[index];
                  return EveryOnesWatchingListWidget(
                      title: movie.originalTitle ?? "No title",
                      movieDescription: movie.overview.toString(),
                      poster_path: '$imageAppendUrl${movie.posterPath}');
                });
          }
        },
      ),
    );
  }
}

class ComingSoonWidget extends StatelessWidget {
  const ComingSoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child:
          BlocBuilder<HotAndNewBloc, HotAndNewState>(builder: (context, state) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.hasError) {
          return const Center(
            child: Text("Load Data Failed"),
          );
        } else if (state.comingSoonList.isEmpty) {
          return const Center(
            child: Text("Failed load Data.."),
          );
        } else {
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                final movie = state.comingSoonList[index];

                return ComingsoonListWidget(
                    id: "id",
                    month: "FEB",
                    day: "11",
                    movieName: movie.title ?? "Nodata",
                    movieDescription: movie.overview ?? "No data",
                    poster_path: "$imageAppendUrl${movie.backdropPath}");
              },
              itemCount: state.comingSoonList.length);
        }
      }),
    );
  }
}

class EveryOnesWatchingListWidget extends StatelessWidget {
  final String title;
  final String movieDescription;
  final String poster_path;
  const EveryOnesWatchingListWidget({
    Key? key,
    required this.title,
    required this.movieDescription,
    required this.poster_path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      Text(
        movieDescription,
        style: const TextStyle(color: Colors.grey),
      ),
      kHight10,
      VideoWidget(
        imgeUrl: poster_path,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          IconTextWidget(
              icon: Icons.share, title: "Share", iconSize: 20, textSIze: 12),
          IconTextWidget(
            icon: Icons.add,
            title: "MyList",
            iconSize: 20,
            textSIze: 12,
          ),
          IconTextWidget(
              icon: Icons.play_arrow, title: "Play", iconSize: 20, textSIze: 12)
        ],
      )
    ]);
  }
}

class ComingsoonListWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String poster_path;
  final String movieName;
  final String movieDescription;
  const ComingsoonListWidget({
    Key? key,
    required this.id,
    required this.month,
    required this.day,
    required this.poster_path,
    required this.movieName,
    required this.movieDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          height: 500,
          width: 50,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                month,
                style: const TextStyle(fontSize: 20, color: Colors.grey),
              ),
              Text(day,
                  style: const TextStyle(
                      letterSpacing: 5,
                      fontWeight: FontWeight.bold,
                      fontSize: 30))
            ],
          ),
        ),
        SizedBox(
          height: 500,
          width: size.width - 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  poster_path,
                  fit: BoxFit.cover,
                  loadingBuilder:
                      (BuildContext _, Widget child, ImageChunkEvent? loading) {
                    if (loading == null) {
                      return child;
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                  errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
                    return const Center(
                      child: Icon(
                        Icons.perm_scan_wifi_sharp,
                        color: kWihiteColor,
                      ),
                    );
                  },
                ),
              ),
              kHight10,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const Spacer(),
                  const IconTextWidget(
                      icon: Icons.notifications, title: "Remind Me"),
                  const IconTextWidget(icon: Icons.info, title: "Info"),
                  kWidth10
                ],
              ),
              Text(
                day,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              kHight10,
              Text(
                movieName,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              kHight10,
              Text(
                movieDescription,
                maxLines: 4,
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class VideoWidget extends StatelessWidget {
  final String imgeUrl;
  const VideoWidget({Key? key, required this.imgeUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 200,
          child: Image.network(imgeUrl, fit: BoxFit.cover, loadingBuilder:
              (BuildContext _, Widget child, ImageChunkEvent? loading) {
            if (loading == null) {
              return child;
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }, errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
            return const Center(
              child: Icon(
                Icons.perm_scan_wifi_sharp,
                color: kWihiteColor,
              ),
            );
          }),
        ),
        const Positioned(
          bottom: 5,
          right: 10,
          child: MuteCircleAvatar(),
        )
      ],
    );
  }
}

class MuteCircleAvatar extends StatelessWidget {
  const MuteCircleAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.black.withOpacity(0.5),
      radius: 25,
      child: const Icon(Icons.volume_off),
    );
  }
}
