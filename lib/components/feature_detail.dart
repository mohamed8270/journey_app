// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class FeaturesSection extends StatelessWidget {
  const FeaturesSection(
      {super.key,
      required this.txt2,
      required this.txt,
      required this.icncolor,
      required this.txtcolor,
      required this.boxcolor});

  final String txt2;
  final String txt;
  final Color icncolor;
  final Color txtcolor;
  final Color boxcolor;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        height: screenSize.height * 0.04,
        decoration: BoxDecoration(
          color: boxcolor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                txt2,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: txtcolor,
                ),
              ),
              const Gap(10),
              Text(
                txt,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: txtcolor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
