import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText {
  static Widget withPoppinsFont(String value) {
    return Text(
      value,
      style: GoogleFonts.poppins(),
    );
  }

  static Widget withCustomPoppinsFont(String value, { double fontSize = 16, Color color = Colors.black }) {
    return Text(
      value,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color
      ),
    );
  }
}