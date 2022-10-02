import 'package:flutter/material.dart';

import '../../widgets/maintitle/title.dart';
import 'card_list_items.dart';

class HorizonalMainList extends StatelessWidget {
  final String title;
  final List<String> posterList;
  const HorizonalMainList(
      {Key? key, required this.title, required this.posterList})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(titlePage: title),
        LimitedBox(
            maxHeight: 200,
            child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(
                    posterList.length,
                    (index) => CardListItems(
                          posterPath: posterList[index],
                        ))))
      ],
    );
  }
}
