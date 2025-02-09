import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'ui/views/home_view.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const O2TechCalculators());
}

class O2TechCalculators extends StatelessWidget {
  const O2TechCalculators({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'O2Tech Calculators',
      theme: ThemeData(
        fontFamily: GoogleFonts.openSans().fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.greenAccent,
          secondary: Colors.black,
        ),
        textTheme: GoogleFonts.openSansTextTheme().apply(
          bodyColor: Colors.black,
          displayColor: Colors.black,
        ),
        scaffoldBackgroundColor: Colors.greenAccent,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
          ),
        ),
      ),
      home: const HomeView(),
    );
  }
}
