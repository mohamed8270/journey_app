// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_app/constants/theme.dart';

class SearchBarField extends StatelessWidget {
  const SearchBarField({
    super.key,
    required this.Controller,
    required this.onSearch,
  });

  final TextEditingController Controller;
  final Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * 0.06,
      width: screenSize.width * 0.75,
      decoration: BoxDecoration(
        color: tGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: Controller,
        onSubmitted: onSearch,
        cursorColor: tBlue,
        cursorWidth: 3,
        cursorHeight: 15,
        textAlignVertical: TextAlignVertical.center,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: tBlack.withOpacity(0.7),
        ),
        decoration: InputDecoration(
          labelText: 'Enter Location',
          labelStyle: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: tBlack.withOpacity(0.2),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.network(
              'https://www.svgrepo.com/show/452052/location-marker.svg',
              height: 12,
              width: 12,
            ),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
