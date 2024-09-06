import 'package:flutter/material.dart';

import 'widgets/system_view.dart';
import 'widgets/other_view.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          children: const [
            SystemView(),
            OtherView(),
          ],
        ),
      ),
    );
  }
}
