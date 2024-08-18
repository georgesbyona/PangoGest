import 'package:go_router/go_router.dart';

import '../../views/views.dart';
import 'routes.dart';

class AppRoutes {
  // AppRoutes({required this.isRegister});
  // bool isRegister ;
  // final initialLocation =
  //     isRegister ? RoutesPaths.welcome : RoutesPaths.welcome;
  GoRouter router = GoRouter(
    initialLocation: RoutesPaths.welcome,
    routes: [
      // GoRoute(
      //   name: RoutesNames.welcome,
      //   path: RoutesPaths.welcome,
      //   builder: (context, state) => const WelcomeScreen(),
      // ),
      GoRoute(
        name: RoutesNames.termsAndConditions,
        path: RoutesPaths.termsAndConditions,
        builder: (context, state) => const TermsAndConditions(),
      ),
      GoRoute(
        name: RoutesNames.proprioInscription,
        path: RoutesPaths.proprioInscription,
        builder: (context, state) => const ProprioInscription(),
      ),
    ],
  );
}
