import 'package:flutter/material.dart';

import 'widgets/bottom_boxes_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            margin: const EdgeInsets.only(bottom: 30),
            width: 400,
            height: 400,
            child: const Card(
              child: Center(child: Text('Chart')),
            ),
          ),
          const BottomBoxesView(),
        ],
      ),
    );
  }
}
