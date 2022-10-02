import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bloc/core/constant.dart';
import 'package:netflix_bloc/presentation/fast_laugh/widgets/icon_text_widget.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:bloc/bloc.dart';
import '../../../application/fast_laugh/fast_laugh_bloc.dart';
import '../../../domain/downloads/models/downloads.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widgetChild;
  final Downloads movieData;

  const VideoListItemInheritedWidget(
      {Key? key, required this.widgetChild, required this.movieData})
      : super(key: key, child: widgetChild);
  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItems extends StatelessWidget {
  final int index;
  const VideoListItems({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final poster_Path =
        VideoListItemInheritedWidget.of(context)?.movieData.posterpath;

    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];

    return Stack(
      children: [
        FastLaughVideoPlayer(videoUrl: videoUrl, onStateChange: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.5),
                  radius: 35,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.volume_off,
                        size: 30,
                      )),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: CircleAvatar(
                          radius: 30,
                          backgroundImage: poster_Path == null
                              ? null
                              : NetworkImage('$imageAppendUrl$poster_Path')),
                    ),
                    ValueListenableBuilder(
                      valueListenable: likedVideosIdsNotifier,
                      builder: (BuildContext context, Set<int> newLikedListIds,
                          Widget? _) {
                        final _index = index;
                        if (newLikedListIds.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              likedVideosIdsNotifier.value.remove(_index);
                              likedVideosIdsNotifier.notifyListeners();
                            },
                            child: const IconTextWidget(
                              icon: Icons.favorite,
                              iconColor: Colors.red,
                              title: "Liked",
                              iconSize: 20,
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            likedVideosIdsNotifier.value.add(_index);
                            likedVideosIdsNotifier.notifyListeners();
                          },
                          child: const IconTextWidget(
                            icon: Icons.emoji_emotions,
                            title: "LOL",
                            iconSize: 20,
                          ),
                        );
                      },
                    ),
                    // ADD AND REMOVE MY LIST
                    ValueListenableBuilder(
                      valueListenable: addMylistNotifier,
                      builder: (BuildContext context, Set<int> newLikedListIds,
                          Widget? _) {
                        final _index = index;
                        if (newLikedListIds.contains(_index)) {
                          return GestureDetector(
                            onTap: () {
                              addMylistNotifier.value.remove(_index);
                              addMylistNotifier.notifyListeners();
                            },
                            child: const IconTextWidget(
                              icon: Icons.check,
                              title: "Added",
                              iconSize: 20,
                            ),
                          );
                        }
                        return GestureDetector(
                          onTap: () {
                            addMylistNotifier.value.add(_index);
                            addMylistNotifier.notifyListeners();
                          },
                          child: const IconTextWidget(
                            icon: Icons.add,
                            title: "MyLIst",
                            iconSize: 20,
                          ),
                        );
                      },
                    ),

                    GestureDetector(
                        onTap: () {
                          final movieName =
                              VideoListItemInheritedWidget.of(context)
                                  ?.movieData
                                  .posterpath;

                          if (movieName != null) {
                            Share.share(movieName);
                          }
                        },
                        child: const IconTextWidget(
                            icon: Icons.share, title: "Share")),
                    const IconTextWidget(icon: Icons.play_arrow, title: "Play"),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final void Function(bool isPlaying) onStateChange;
  const FastLaughVideoPlayer(
      {required this.videoUrl, required this.onStateChange, super.key});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _VideoPlayerController;

  @override
  void initState() {
    _VideoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _VideoPlayerController.initialize().then((value) {
      setState(() {
        _VideoPlayerController.play();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _VideoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _VideoPlayerController.value.aspectRatio,
              child: VideoPlayer(_VideoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _VideoPlayerController.dispose();
    super.dispose();
  }
}
