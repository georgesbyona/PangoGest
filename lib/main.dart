import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/controllers.dart';
import 'app/shared/shared.dart';
import 'app/views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isDark = sharedPreferences.getBool('isDark') ?? false;
  runApp(PangoGest(isDark: isDark));
}

class PangoGest extends StatelessWidget {
  final bool isDark;
  const PangoGest({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    lightCustomSystemChrome();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserDataController()..loadUserData(),
        ),
        ChangeNotifierProvider(
          create: (context) => MainController()
            ..changeThemeMode(darkMode: isDark)
            ..checkConnection(context),
        ),
      ],
      child: Consumer<MainController>(
        builder: (context, controller, state) {
          return Consumer<UserDataController>(
            builder: (context, userData, child) {
              return MaterialApp(
                themeAnimationDuration: const Duration(milliseconds: 500),
                themeAnimationCurve: Curves.easeInOut,
                debugShowCheckedModeBanner: false,
                title: "PangoGest",
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: controller.isDark ? ThemeMode.dark : ThemeMode.light,
                home: userData.isRegister && userData.isLoggedIn
                    ? Wrapper(controller: controller, userData: userData)
                    : Welcome(
                        controller: controller,
                        userData: userData,
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
