import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:netflix_bloc/core/colors/colors.dart';
import 'package:netflix_bloc/presentation/downloads/screen_downloads.dart';
import 'package:netflix_bloc/presentation/fast_laugh/fast_laugh.dart';
import 'package:netflix_bloc/presentation/home/screen_home.dart';
import 'package:netflix_bloc/presentation/mainpage/widgets/bottom_nav.dart';
import 'package:netflix_bloc/presentation/new&hot/new_and_hot.dart';
import 'package:netflix_bloc/presentation/search/search.dart';

class ScreenMainPage extends StatelessWidget {
  ScreenMainPage({Key? key}) : super(key: key);

  final _pages = [
    HomePage(),
    ScreenNewAndHot(),
    ScreenFastLaugh(),
    ScreenSearch(),
    SCreenDownloads()
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ValueListenableBuilder(
            valueListenable: indexChangeNotifier,
            builder: (context, int index, _) {
              return _pages[index];
            }),
        bottomNavigationBar: BottomnavigationBarWidget(),
      ),
    );
  }
}
