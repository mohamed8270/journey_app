// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_app/components/detail_section_element.dart';
import 'package:journey_app/components/feature_detail.dart';
import 'package:journey_app/constants/theme.dart';
import 'package:journey_app/modals/tour_modal.dart';
import 'package:journey_app/service/fetchTourData.dart';

class TourDetailPage extends StatefulWidget {
  final int tourID;
  final String tourSearch;
  const TourDetailPage(
      {super.key, required this.tourID, required this.tourSearch});

  @override
  State<TourDetailPage> createState() => _TourDetailPageState();
}

class _TourDetailPageState extends State<TourDetailPage> {
  FetchTourData grabData = Get.put(FetchTourData());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: tWhite,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       Get.back();
      //     },
      //     icon: const Icon(
      //       Icons.arrow_back_rounded,
      //       color: tBlack,
      //       size: 22,
      //     ),
      //   ),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: screenSize.width,
        decoration: const BoxDecoration(
          color: tBlue,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          isExtended: true,
          elevation: 0,
          backgroundColor: tBlue,
          tooltip: 'Track Now',
          child: Text(
            "Track Now",
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: tWhite,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<List<TourModal>>(
              future: grabData.FetchDataApi(widget.tourSearch),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TourModal>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    heightFactor: 30,
                    child: SizedBox(
                      height: 18,
                      width: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        strokeAlign: 3,
                        strokeCap: StrokeCap.round,
                        color: tBlue,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        height: screenSize.height * 0.4,
                        decoration: const BoxDecoration(
                          color: tWhite,
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: screenSize.height * 0.2,
                              width: screenSize.width * 0.4,
                              child: SvgPicture.network(
                                'https://www.svgrepo.com/show/474375/cloud-server2.svg',
                              ),
                            ),
                            const Gap(20),
                            Text(
                              "Oh Snap!\nCorrect your location name and try again!",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: tBlue,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: screenSize.width * 0.7,
                              child: Text(
                                snapshot.error.toString(),
                                overflow: TextOverflow.fade,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 8,
                                  fontWeight: FontWeight.w600,
                                  color: tBlack.withOpacity(0.2),
                                ),
                              ),
                            ),
                            const Gap(5),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    grabData.FetchDataApi(widget.tourSearch);
                                  },
                                  child: FittedBox(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: tBlue,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(
                                          "Reload",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: tWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Gap(20),
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: FittedBox(
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: tBlue,
                                        shape: BoxShape.circle,
                                      ),
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Text(
                                          "Back",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: tWhite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasData) {
                  List<TourModal>? tourDB = snapshot.data;
                  final tourData = tourDB![widget.tourID];
                  return Column(
                    children: [
                      Container(
                        height: screenSize.height * 0.4,
                        width: screenSize.width,
                        decoration: BoxDecoration(
                          color: tGrey.withOpacity(0.1),
                          image: DecorationImage(
                            image: NetworkImage(
                              tourData
                                  .resultObject!.image.images.original.imgsize
                                  .toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, top: 60),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: tBlue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: tWhite,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: screenSize.width * 0.5,
                                  child: Text(
                                    tourData.resultObject!.name.toString(),
                                    overflow: TextOverflow.fade,
                                    maxLines: 2,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: tBlack,
                                    ),
                                  ),
                                ),
                                const Gap(5),
                                Text(
                                  tourData.resultObject!.location.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                    color: tBlack.withOpacity(0.2),
                                  ),
                                )
                              ],
                            ),
                            FittedBox(
                              fit: BoxFit.fitHeight,
                              child: Container(
                                width: screenSize.width * 0.2,
                                decoration: BoxDecoration(
                                  color: tBlue,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    tourData.resultObject!.openNow.toString(),
                                    style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: tWhite,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 20),
                        child: Row(
                          children: [
                            ContainerForAll(
                              txt: tourData.resultObject!.review.toString(),
                              icn:
                                  'https://www.svgrepo.com/show/522917/like.svg',
                              txtcolor: tBlack,
                              boxcolor: tBlack.withOpacity(0.04),
                              icncolor: tBlue,
                            ),
                            const Gap(20),
                            ContainerForAll(
                              txt: tourData.resultObject!.rating.toString(),
                              icn:
                                  'https://www.svgrepo.com/show/533052/star.svg',
                              txtcolor: tWhite,
                              boxcolor: Colors.green,
                              icncolor: tWhite,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: tBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          top: 10,
                        ),
                        child: Text(
                          tourData.resultObject!.geodescription == null ||
                                  tourData.resultObject!.description == ""
                              ? "Unfortunately there is no description data present for the current place, Soon data sets will be updated! Thanks for using our service!"
                              : tourData.resultObject!.geodescription
                                  .toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: tBlack.withOpacity(0.3),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Availabilities",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: tBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                            top: 10,
                            bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FeaturesSection(
                                txt2: 'Activities',
                                txt: tourData.resultObject!.category
                                    .attrationmodal.activities
                                    .toString(),
                                icncolor: tBlack.withOpacity(0.5),
                                txtcolor: tBlack.withOpacity(0.5),
                                boxcolor: tBlack.withOpacity(0.03),
                              ),
                              const Gap(20),
                              FeaturesSection(
                                txt2: 'Attracttions',
                                txt: tourDB[0]
                                    .resultObject!
                                    .category
                                    .attrationmodal
                                    .attractions
                                    .toString(),
                                icncolor: tBlack.withOpacity(0.5),
                                txtcolor: tBlack.withOpacity(0.5),
                                boxcolor: tBlack.withOpacity(0.03),
                              ),
                              const Gap(20),
                              FeaturesSection(
                                txt2: 'Night Life',
                                txt: tourDB[0]
                                    .resultObject!
                                    .category
                                    .attrationmodal
                                    .nightlife
                                    .toString(),
                                icncolor: tBlack.withOpacity(0.5),
                                txtcolor: tBlack.withOpacity(0.5),
                                boxcolor: tBlack.withOpacity(0.03),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 10,
                            bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FeaturesSection(
                                txt2: 'Shopping',
                                txt: tourDB[0]
                                    .resultObject!
                                    .category
                                    .attrationmodal
                                    .shopping
                                    .toString(),
                                icncolor: tBlack.withOpacity(0.5),
                                txtcolor: tBlack.withOpacity(0.5),
                                boxcolor: tBlack.withOpacity(0.03),
                              ),
                              const Gap(20),
                              FeaturesSection(
                                txt2: 'Restraurant',
                                txt: tourDB[0]
                                    .resultObject!
                                    .category
                                    .restraurant
                                    .restraurant
                                    .toString(),
                                icncolor: tBlack.withOpacity(0.5),
                                txtcolor: tBlack.withOpacity(0.5),
                                boxcolor: tBlack.withOpacity(0.03),
                              ),
                              const Gap(20),
                              FeaturesSection(
                                txt2: 'Neighborhoods',
                                txt: tourDB[0]
                                    .resultObject!
                                    .category
                                    .neighborhoods
                                    .toString(),
                                icncolor: tBlack.withOpacity(0.5),
                                txtcolor: tBlack.withOpacity(0.5),
                                boxcolor: tBlack.withOpacity(0.03),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FeaturesSection(
                        txt2: 'Airports',
                        txt: tourDB[0]
                            .resultObject!
                            .category
                            .airports
                            .toString(),
                        icncolor: tBlack.withOpacity(0.5),
                        txtcolor: tBlack.withOpacity(0.5),
                        boxcolor: tBlack.withOpacity(0.03),
                      ),
                    ],
                  );
                }
                return Text(
                  "The Server is currently busy, Please try again later",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: tBlue,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
