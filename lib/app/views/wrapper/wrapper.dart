import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../controllers/controllers.dart';
import '../../shared/shared.dart';
import '../views.dart';
import 'drawer/mi_drawer.dart';
import 'widgets/bottom_appbar_view.dart';

class Wrapper extends StatelessWidget {
  final UserDataController userData;
  final MainController controller;
  const Wrapper({
    super.key,
    required this.userData,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    customSystemChrome(controller);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final List<IconData> selectedIcons = [
      AppIcons.homeB,
      AppIcons.calendarB,
      AppIcons.chatB,
    ];
    final List<IconData> unselectedIcons = [
      AppIcons.home,
      AppIcons.calendar,
      AppIcons.chat,
    ];
    final List<String> labels = ["Home", "Calendrier", "Chat"];
    final List<String> badgeContents = ["2", "10", "7"];
    final List<double> bottomHeight = [
      height * 0.095,
      height * 0.05,
      height * 0.05,
    ];
    final List<Widget> screens = [
      const HomePage(),
      const CalendarPage(),
      ChatList(
        user: userData,
        controller: controller,
      ),
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NotificationPage(),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              padding: EdgeInsets.all(width * 0.04),
              child: CustomBadge(
                content: badgeContents[controller.index],
                icon: AppIcons.notification,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(width, bottomHeight[controller.index]),
          child: BottomAppBarView(userData: userData, controller: controller),
        ),
      ),
      drawer: MiDrawer(userData: userData, controller: controller),
      body: SafeArea(child: screens[controller.index]),
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Theme.of(context).highlightColor,
        itemPadding: EdgeInsets.symmetric(
          horizontal: width * 0.05,
          vertical: height * 0.015,
        ),
        currentIndex: controller.index,
        margin: EdgeInsets.only(
          top: height * 0.02,
          left: width * 0.1,
          right: width * 0.1,
          bottom: height * 0.04,
        ),
        onTap: (i) => controller.navigationController(i),
        items: List.generate(
          selectedIcons.length,
          (index) => SalomonBottomBarItem(
            icon: index == 2
                ? CustomBadge(icon: unselectedIcons[index], content: '7')
                : Icon(unselectedIcons[index]),
            activeIcon: Icon(selectedIcons[index]),
            title: Text(
              labels[index],
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
            ),
            selectedColor: Theme.of(context).colorScheme.inversePrimary,
            unselectedColor: Theme.of(context).unselectedWidgetColor,
          ),
        ),
      ),
    );
  }
}
