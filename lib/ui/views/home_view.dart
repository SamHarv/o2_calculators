import 'package:calculators/config/constants.dart';
import 'package:flutter/material.dart';

import '../../logic/services/url_launcher.dart';
import '../widgets/banner_ad_widget.dart';
import 'compound_interest_view.dart';
import 'mortgage_view.dart';
import '../widgets/home_tile_widget.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class HomeView extends StatefulWidget {
  /// UI for the [HomeView]

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: kPadding,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 32,
                children: [
                  Text(
                    "O2Tech Calculators",
                    textAlign: TextAlign.center,
                    style: headingStyle,
                  ),
                  HomeTileWidget(
                      toolName: "Mortgage Calculator",
                      nav: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const MortgageView()),
                        );
                      }),
                  HomeTileWidget(
                    toolName: "Compound Interest Calculator",
                    nav: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const CompoundInterestView()),
                      );
                    },
                  ),
                  Column(
                    children: [
                      Tooltip(
                        message: "Launch the O2Tech website",
                        child: InkWell(
                          borderRadius: BorderRadius.circular(128),
                          onTap: () => UrlLauncher.launchO2Tech(),
                          child: Image.asset(
                            'images/logo.png',
                            height: 50,
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ],
              ),
            ),
          ),
          kIsWeb
              ? SizedBox()
              : Align(
                  alignment: Alignment.bottomCenter, child: BannerAdWidget()),
        ],
      ),
    );
  }
}
