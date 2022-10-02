import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bloc/application/search/search_bloc.dart';
import 'package:netflix_bloc/core/constant.dart';
import 'package:netflix_bloc/domain/core/debouncer/debouncer.dart';
import 'package:netflix_bloc/presentation/search/widgets/search_result.dart';
import 'package:netflix_bloc/presentation/widgets/maintitle/title.dart';

import 'widgets/search_idle.dart';

class ScreenSearch extends StatelessWidget {
  ScreenSearch({Key? key}) : super(key: key);

  final _deBouncer = Debouncer(milliSeconds: 1 * 1000);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<SearchBloc>(context).add(const Initialize());
    });
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          kHight10,
          const TitleWidget(
            titlePage: "Top Search",
          ),
          kHight10,
          CupertinoSearchTextField(
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.grey.withOpacity(0.4),
              ),
              onChanged: ((value) {
                if (value.isEmpty) {
                  return;
                }
                _deBouncer.run(() {
                  BlocProvider.of<SearchBloc>(context)
                      .add(SearchMovie(movieQuery: value));
                });
              }),
              style: const TextStyle(
                color: Colors.white,
              )),
          kHight10,
          Expanded(child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.searchResultList.isEmpty) {
                return const SearchIdleWidgets();
              } else {
                return const SearchResultWidget();
              }
            },
          )),
        ],
      ),
    )));
  }
}
