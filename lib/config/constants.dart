import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../ui/widgets/banner_ad_widget.dart';

// Used colours
const black = Colors.black;
const green = Colors.greenAccent;
const white = Colors.white;

// Style for view headings
const headingStyle = TextStyle(
  fontSize: 28,
  fontWeight: FontWeight.bold,
);

// Style for subheadings
const subHeadingStyle = TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

// Style for input fields
const inputFieldStyle = TextStyle(
  color: Colors.black,
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

// Style for output values for dialog
const outputValueStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);

// Padding for widgets
const kPadding = EdgeInsets.all(32);

// Border radius for widgets
const kBorderRadius = BorderRadius.all(Radius.circular(32));

// Border side for widgets
const kBorderSide = BorderSide(color: Colors.black, width: 3);

// Border for input fields
const inputBorder = OutlineInputBorder(
  borderRadius: kBorderRadius,
  borderSide: kBorderSide,
);

// Shadow for button widgets
const kShadow = BoxShadow(
  color: black,
  blurRadius: 8,
  offset: Offset(4, 4),
  blurStyle: BlurStyle.solid,
);

// App bar for tool views to allow back navigation
final kAppBar = AppBar(
  backgroundColor: Colors.transparent,
  automaticallyImplyLeading: true,
  centerTitle: true,
  title: kIsWeb
      ? SizedBox()
      : Align(alignment: Alignment.bottomCenter, child: BannerAdWidget()),
);
