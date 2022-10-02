import 'package:flutter/material.dart';
import 'package:netflix_bloc/core/constant.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({Key? key, required this.title})
      : super(
          key: key,
        );

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        kWidth10,
        Text(
          title,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
    );
  }
}
