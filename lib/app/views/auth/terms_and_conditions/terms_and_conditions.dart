import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../shared/shared.dart';

class TermsAndConditions extends StatefulWidget {
  static const route = "/termsAndConditions";
  const TermsAndConditions({super.key});

  @override
  State<TermsAndConditions> createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    lightCustomSystemChrome();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 160.0,
              backgroundColor: AppColors.black,
              iconTheme: const IconThemeData(color: AppColors.primary),
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 2,
                title: Text(
                  'PangoGest',
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                    fontSize: width * 0.035,
                  ),
                ),
                background: Container(
                  padding: EdgeInsets.only(left: width * 0.6),
                  child: Image.asset(AppImages.logo),
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 20,
                child: Center(
                  child: Text('Scroll to see the SliverAppBar in effect.'),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 20,
                (BuildContext context, int index) {
                  return Container(
                    color: index.isOdd ? Colors.white : Colors.black12,
                    height: 100.0,
                    child: Center(
                      child: Text(
                        '$index',
                        textScaler: const TextScaler.linear(5),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
