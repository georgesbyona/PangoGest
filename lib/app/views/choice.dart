import 'package:flutter/material.dart';

import '../shared/shared.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(AppImages.bckground2),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 240,
                child: CarouselView(
                  elevation: 5,
                  shrinkExtent: 5.0,
                  itemSnapping: true,
                  itemExtent: width * 0.9,
                  padding: const EdgeInsets.all(10),
                  children: List.generate(
                    10,
                    (index) {
                      return Container(
                        color: Colors.grey,
                        child: Image.network(
                          "https://picsum.photos/400?random=$index",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
