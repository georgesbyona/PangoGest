import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../../controllers/controllers.dart';

class BottomAppBarView extends StatefulWidget {
  const BottomAppBarView({
    super.key,
    required this.userData,
    required this.controller,
  });

  final MainController controller;
  final UserDataController userData;

  @override
  State<BottomAppBarView> createState() => _BottomAppBarViewState();
}

class _BottomAppBarViewState extends State<BottomAppBarView> {
  bool showAnimationText = true;
  bool showGreetText = false;
  void greetingActions() {
    setState(() {
      showGreetText = true;
      showAnimationText = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final List<String> contents = ["Home", "Calendrier", "Chat"];
    return Container(
      padding: EdgeInsets.only(left: width * 0.04, bottom: height * 0.02),
      width: width,
      child: widget.controller.index == 0
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(fontSize: height * 0.02),
                  textAlign: TextAlign.start,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showAnimationText)
                        AnimatedTextKit(
                          isRepeatingAnimation: false,
                          onFinished: greetingActions,
                          animatedTexts: [
                            TyperAnimatedText(
                              "Bienvenu.e encore",
                              speed: const Duration(milliseconds: 80),
                            ),
                          ],
                        ),
                      if (showGreetText) const Text("Salut,"),
                      Text(
                        "${widget.userData.names!.split(' ')[0]} !",
                        style: GoogleFonts.raleway(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.normal,
                          fontSize: height * 0.03,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Text(
              contents[widget.controller.index],
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: height * 0.02),
              textAlign: TextAlign.start,
            ),
    );
  }
}
