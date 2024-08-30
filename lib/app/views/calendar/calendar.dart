import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import 'widgets/body_calendar_view.dart';
import 'widgets/head_calendar_view.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  bool isEmpty = true;
  ScrollController scrollController = ScrollController();
  bool _isAtTop = true;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == 0) {
        setState(() {
          _isAtTop = true;
        });
      } else {
        setState(() {
          _isAtTop = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const HeadCalendarView(),
            BodyCalendarView(
              isEmpty: isEmpty,
              scrollController: scrollController,
            ),
          ],
        ),
      ),
      floatingActionButton: _isAtTop || isEmpty
          ? CustomFAB(
              onPressed: () {
                setState(() {
                  isEmpty = !isEmpty;
                });
              },
              icon: AppIcons.addEvent,
            )
          : CustomFABMini(
              onPressed: () {
                setState(() {
                  isEmpty = !isEmpty;
                });
              },
              icon: AppIcons.addEvent,
            ),
    );
  }
}
