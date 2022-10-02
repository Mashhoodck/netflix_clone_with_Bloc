import 'package:flutter/material.dart';
import 'package:netflix_bloc/core/constant.dart';

const String imgeUrl =
    "https://c8.alamy.com/comp/2DE0GDG/movie-poster-the-haunting-of-hill-house-2018-netflix-2DE0GDG.jpg";

class CardListItems extends StatelessWidget {
  String posterPath;
  CardListItems({required this.posterPath, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        width: 130,
        height: 250,
        decoration: BoxDecoration(
            borderRadius: kRadius10,
            image: DecorationImage(
                image: NetworkImage(posterPath), fit: BoxFit.cover)),
      ),
    );
  }
}
