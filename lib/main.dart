import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controllers/controllers.dart';
import 'app/shared/shared.dart';
import 'firebase_options.dart';
import 'app/views/views.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  //Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("4bb5c6c7-0a55-4707-8df4-dda55c002904");
  OneSignal.Notifications.requestPermission(true);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  bool isDark = sharedPreferences.getBool('isDark') ?? false;
  initializeDateFormatting();
  runApp(PangoGest(isDark: isDark));
}

class PangoGest extends StatelessWidget {
  final bool isDark;
  const PangoGest({super.key, required this.isDark});

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    lightCustomSystemChrome();
    String screen = "";
    OneSignal.Notifications.addClickListener(
      (event) {
        final data = event.notification.additionalData;
        screen = data!['screen'];
        if (screen.isNotEmpty) {
          navigatorKey.currentState!.pushNamed(screen);
        }
      },
    );
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
                    // initialRoute: '/',
                    // navigatorKey: navigatorKey,
                    // routes: {
                    //   '/': (context) => user.userType == "locataire"
                    //       ? Wrapper2(controller: mainController, user: user)
                    //       : Wrapper(controller: mainController, user: user),
                    //   '/notifications': (context) => const NotificationPage(),
                    // },
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
