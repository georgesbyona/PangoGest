import 'package:flutter/material.dart';

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
    final List<int> indexes = [0, 1, 2];
    final List<String> badgeContents = ["2", "10", "7"];
    final List<double> bottomHeight = [95, 50, 50];
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
              color: Colors.transparent,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: CustomBadge(
                content: badgeContents[controller.index],
                icon: AppIcons.notification,
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.maxFinite, bottomHeight[controller.index]),
          child: BottomAppBarView(userData: userData, controller: controller),
        ),
      ),
      drawer: MiDrawer(userData: userData, controller: controller),
      body: SafeArea(child: screens[controller.index]),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          elevation: 0,
          indicatorColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          labelTextStyle: WidgetStatePropertyAll(
            Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.normal,
                  letterSpacing: 1,
                  fontSize: 10,
                ),
          ),
          iconTheme: WidgetStatePropertyAll(IconThemeData(
            color: Theme.of(context).unselectedWidgetColor,
          )),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        child: NavigationBar(
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(microseconds: 500),
          onDestinationSelected: (i) => controller.navigationController(i),
          selectedIndex: controller.index,
          destinations: indexes.map((index) {
            return NavigationDestination(
              icon: index == 2
                  ? CustomBadge(icon: unselectedIcons[index], content: '7')
                  : Icon(unselectedIcons[index]),
              selectedIcon: Icon(
                selectedIcons[index],
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              label: labels[index],
              tooltip: labels[index],
            );
          }).toList(),
        ),
      ),
    );
  }
}
