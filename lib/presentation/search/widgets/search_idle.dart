import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_bloc/application/search/search_bloc.dart';
import 'package:netflix_bloc/core/colors/colors.dart';
import 'package:netflix_bloc/core/constant.dart';

class SearchIdleWidgets extends StatelessWidget {
  const SearchIdleWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                const Center(
                  child: Text("Error Occured"),
                );
              } else if (state.idleList.isEmpty) {
                const Center(
                  child: Text("Epmty Data"),
                );
              }
              return ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: ((context, index) {
                    final movie = state.idleList[index];

                    return TopSearchTile(
                        movieName: movie.title ?? "NO Title Provided",
                        imageUrl: '$imageAppendUrl${movie.posterpath}');
                  }),
                  separatorBuilder: ((context, index) => const Divider()),
                  itemCount: state.idleList.length);
            },
          ),
        ),
      ],
    );
  }
}

class TopSearchTile extends StatelessWidget {
  String movieName;
  String imageUrl;
  TopSearchTile({required this.movieName, required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 65,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    imageUrl,
                  ),
                  fit: BoxFit.cover)),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
            child: Text(
          movieName,
          style:
              const TextStyle(color: kWihiteColor, fontWeight: FontWeight.bold),
        )),
        const CircleAvatar(
          backgroundColor: kWihiteColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: kBlackColor,
            radius: 23,
            child: Icon(
              CupertinoIcons.play_fill,
              color: kWihiteColor,
            ),
          ),
        )
      ],
    );
  }
}
