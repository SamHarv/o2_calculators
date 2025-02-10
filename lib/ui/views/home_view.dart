import 'package:calculators/config/constants.dart';
import 'package:flutter/material.dart';

import '../../logic/services/url_launcher.dart';
import 'compound_interest_view.dart';
import 'mortgage_view.dart';
import '../widgets/home_tile_widget.dart';

class HomeView extends StatelessWidget {
  /// UI for the [HomeView]

  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
            ],
          ),
        ),
      ),
    );
  }
}
