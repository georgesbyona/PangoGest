import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/controllers.dart';
import '../widgets/auth_bottom_view.dart';
import '../../../shared/shared.dart';
import 'widgets/blur_container.dart';
import 'widgets/dialog_body.dart';

class Welcome extends StatelessWidget {
  static const route = "/";

  const Welcome({super.key, required this.user, required this.controller});
  final UserDataController user;
  final MainController controller;
  @override
  Widget build(BuildContext context) {
    lightCustomSystemChrome();
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > constraints.maxHeight) {
          return WelcomeScreen2(user: user, controller: controller);
        } else {
          return WelcomeScreen(user: user, controller: controller);
        }
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  final UserDataController user;
  final MainController controller;
  const WelcomeScreen({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(AppImages.bckground),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            blurContainer(width, height),
            Container(
              width: width,
              height: height * 0.4,
              padding: EdgeInsets.all(width * 0.03),
              child: DefaultTextStyle(
                style: GoogleFonts.raleway(
                  color: AppColors.white,
                  fontSize: width * 0.0325,
                  letterSpacing: 1.2,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BIENVENU.E DANS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.05,
                            height: 3,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "PangoGest  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: width * 0.05,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image.asset(AppImages.logo),
                            ),
                          ],
                        ),
                        const Text(
                          "Louez malin, gérez zen !",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                        const Text(
                          "Simplifiez votre quotidien de propriétaire -\nTrouvez votre bonheur locatif !",
                          style: TextStyle(height: 1.5),
                        ),
                      ],
                    ),
                    CustomMainButton(
                      onTap: () {
                        const bckgroundColor = AppColors.blackOver;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              alignment: Alignment.center,
                              backgroundColor: bckgroundColor.withOpacity(0.7),
                              child: dialogBody(context, width, user),
                            );
                          },
                        );
                      },
                      text: "Commencer",
                    ),
                    const AuthBottomView(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WelcomeScreen2 extends StatelessWidget {
  final UserDataController user;
  final MainController controller;
  const WelcomeScreen2({
    super.key,
    required this.user,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(AppImages.bckground),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            blurContainer(width, height),
            Container(
              width: width,
              height: height * 0.5,
              padding: EdgeInsets.all(width * 0.03),
              child: DefaultTextStyle(
                style: GoogleFonts.raleway(
                  color: AppColors.white,
                  fontSize: height * 0.0325,
                  letterSpacing: 1.2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "BIENVENU.E DANS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: height * 0.05,
                            height: 3,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "PangoGest  ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                                fontSize: height * 0.05,
                              ),
                            ),
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image.asset(AppImages.logo),
                            ),
                          ],
                        ),
                        const Text(
                          "Louez malin, gérez zen !",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                        const Text(
                          "Simplifiez votre quotidien de propriétaire -\nTrouvez votre bonheur locatif !",
                          style: TextStyle(height: 1.5),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomMainButton2(
                          onTap: () {
                            const bckgroundColor = AppColors.blackOver;
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  alignment: Alignment.center,
                                  backgroundColor:
                                      bckgroundColor.withOpacity(0.7),
                                  child: dialogBody(context, height, user),
                                );
                              },
                            );
                          },
                          text: "Commencer",
                        ),
                        const AuthBottomView(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
