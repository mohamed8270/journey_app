import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class ContainerForAll extends StatelessWidget {
  const ContainerForAll({
    super.key,
    required this.txt,
    required this.icn,
    required this.txtcolor,
    required this.boxcolor,
    required this.icncolor,
  });

  final String txt;
  final String icn;
  final Color txtcolor;
  final Color boxcolor;
  final Color icncolor;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Container(
        height: screenSize.height * 0.04,
        decoration: BoxDecoration(
          color: boxcolor,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              SvgPicture.network(
                icn,
                height: 16,
                width: 16,
                color: icncolor,
              ),
              const Gap(5),
              Text(
                txt,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
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
