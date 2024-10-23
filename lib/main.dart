import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/controllers.dart';
import 'app/shared/shared.dart';
import 'firebase_options.dart';
import 'app/views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        ChangeNotifierProvider(create: (context) {
          return MainController()
            ..changeThemeMode(darkMode: isDark)
            ..readHouses();
        }),
        ChangeNotifierProvider(create: (context) => CalendarController()),
      ],
      child: Consumer<MainController>(
        builder: (context, mainController, state) {
          return Consumer<UserDataController>(
            builder: (context, user, child) {
              return Consumer<CalendarController>(
                builder: (context, value, child) {
                  return MaterialApp(
                    themeAnimationDuration: const Duration(milliseconds: 250),
                    themeAnimationCurve: Curves.easeInOut,
                    debugShowCheckedModeBanner: false,
                    title: "PangoGest",
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: mainController.isDark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    home: user.isRegister && user.isLoggedIn
                        ? user.userType == "locataire"
                            ? Wrapper2(controller: mainController, user: user)
                            : Wrapper(controller: mainController, user: user)
                        : Welcome(controller: mainController, user: user),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
