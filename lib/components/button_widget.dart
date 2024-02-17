// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_app/constants/theme.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.screenSize,
    required this.txt,
    required this.Height,
    required this.Width,
    required this.clr,
    required this.Click,
  });

  final Size screenSize;
  final String txt;
  final double Height;
  final double Width;
  final Color clr;
  final VoidCallback Click;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Click,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: Height,
        width: Width,
        decoration: BoxDecoration(
          color: clr,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          txt,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: tWhite,
          ),
        ),
      ),
    );
  }
}
