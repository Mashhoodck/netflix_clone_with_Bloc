import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:netflix_bloc/core/colors/colors.dart';

import '../../../core/constant.dart';

class NumberCard extends StatelessWidget {
  final int index;
  final String posterPath;
  NumberCard({super.key, required this.index, required this.posterPath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 40,
            ),
            Container(
              width: 130,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: kRadius10,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(posterPath))),
            ),
          ],
        ),
        Positioned(
            bottom: -30,
            left: 20,
            child: BorderedText(
                strokeWidth: 8,
                strokeColor: kWihiteColor,
                child: Text(
                  "${index + 1}",
                  style: const TextStyle(
                      color: kBlackColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 150,
                      decoration: TextDecoration.none,
                      decorationColor: Colors.red),
                ))),
      ],
    );
  }
}
