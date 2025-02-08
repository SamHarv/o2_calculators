import 'package:calculators/logic/services/url_launcher.dart';
import 'package:calculators/ui/widgets/home_tile.dart';
import 'package:flutter/material.dart';

import 'mortgage_view.dart';
// import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 32,
            children: [
              Text(
                "O2Tech Calculators",
                textAlign: TextAlign.center,
                // style: GoogleFonts.rampartOne(
                //   // color: Colors.white,
                //   fontSize: 28,
                //   fontWeight: FontWeight.bold,
                // ),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              HomeTile(
                  toolName: "Mortgage Calculator",
                  nav: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => const MortgageView()),
                    );
                  }),
              HomeTile(
                toolName: "Compound Interest Calculator",
                nav: () {},
                // () => Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const CompoundInterestView()),
                // ),
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
