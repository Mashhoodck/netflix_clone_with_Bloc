import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constant.dart';
import '../../fast_laugh/widgets/icon_text_widget.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 500,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(kMainImage), fit: BoxFit.cover),
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const IconTextWidget(icon: Icons.add, title: "My List"),
              _playButton(),
              const IconTextWidget(icon: Icons.info, title: "Info"),
            ],
          ),
        )
      ],
    );
  }
}

TextButton _playButton() {
  return TextButton.icon(
      style:
          ButtonStyle(backgroundColor: MaterialStateProperty.all(kWihiteColor)),
      onPressed: () {},
      icon: const Icon(
        Icons.play_arrow,
        color: Colors.black,
        size: 20,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          "Play",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ));
}
