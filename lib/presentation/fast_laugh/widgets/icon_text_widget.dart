import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';

import 'package:netflix_bloc/core/colors/colors.dart';

class IconTextWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final double? iconSize;
  final double? textSIze;
  final Color? iconColor;
  const IconTextWidget(
      {super.key,
      required this.icon,
      required this.title,
      this.iconSize,
      this.textSIze,
      this.iconColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor,
          ),
          Text(
            title,
            style: TextStyle(fontSize: textSIze, color: kWihiteColor),
          )
        ],
      ),
    );
  }
}
