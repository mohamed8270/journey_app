// ignore_for_file: deprecated_member_use, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:journey_app/constants/theme.dart';

class searchButton extends StatelessWidget {
  const searchButton({
    super.key,
    required this.screenSize,
    required this.Click,
  });

  final Size screenSize;
  final VoidCallback Click;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Click,
      child: Container(
        height: screenSize.height * 0.06,
        width: screenSize.width * 0.13,
        decoration: BoxDecoration(
          color: tGrey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.network(
            'https://www.svgrepo.com/show/532554/search-alt.svg',
            color: tBlack.withOpacity(0.3),
          ),
        ),
      ),
    );
  }
}
