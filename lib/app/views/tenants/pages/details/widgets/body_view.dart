import 'package:flutter/material.dart';

import '../../../../../../data/data.dart';
import 'details_part_view.dart';
import 'historical_view.dart';
import 'cards_view.dart';

class BodyView extends StatelessWidget {
  const BodyView({super.key, required this.house});

  final Iterable<HouseModel> house;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20),
        children: [
          DetailsPartView(house: house),
          CardsView(house: house),
          const HistoricalView(),
        ],
      ),
    );
  }
}
