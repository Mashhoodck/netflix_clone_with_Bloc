import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TitleWidget extends StatelessWidget {
  final String titlePage;
  const TitleWidget({super.key, required this.titlePage});

  @override
  Widget build(BuildContext context) {
    return Text(
      titlePage,
      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    );
  }
}
