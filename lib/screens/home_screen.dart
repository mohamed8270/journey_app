// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_app/Inner%20screens/detail_screen.dart';
import 'package:journey_app/Inner%20screens/location_screen.dart';
import 'package:journey_app/components/button_widget.dart';
import 'package:journey_app/components/search_bar.dart';
import 'package:journey_app/components/searchbutton.dart';
import 'package:journey_app/constants/theme.dart';
import 'package:journey_app/controller/geo_coding.dart';
import 'package:journey_app/controller/service.dart';
import 'package:journey_app/modals/tour_modal.dart';
import 'package:journey_app/service/fetchTourData.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();
  FetchTourData grabData = Get.put(FetchTourData());
  Service service = Get.put(Service());
  GeocodingLocation geocodingLocation = Get.put(GeocodingLocation());
  MapController myController = MapController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: tWhite,
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverAppBar(
            elevation: 0,
            backgroundColor: tWhite,
            toolbarHeight: screenSize.height * 0.1,
            automaticallyImplyLeading: false,
            excludeHeaderSemantics: false,
            floating: true,
            pinned: true,
            centerTitle: false,
            snap: false,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Journey Guide",
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: tBlue,
                  ),
                ),
                const Gap(8),
                Text(
                  "Explore the joy!",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: tBlack.withOpacity(0.4),
                  ),
                ),
              ],
            ),
            bottom: AppBar(
              elevation: 0,
              backgroundColor: tWhite,
              automaticallyImplyLeading: false,
              centerTitle: true,
              toolbarHeight: screenSize.height * 0.1,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SearchBarField(
                    Controller: searchController,
                    onSearch: (search) async {
                      setState(() {
                        searchController.text = search;
                      });
                      await grabData.searchTourLocation();
                    },
                  ),
                  searchButton(
                    screenSize: screenSize,
                    Click: () async {
                      setState(() {
                        grabData.searchTourLocation();
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                FutureBuilder<List<TourModal>>(
                  future: grabData.FetchDataApi(searchController.text),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<TourModal>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        heightFactor: 20,
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
                      return Padding(
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
                            ],
                          ),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      List<TourModal>? tourData = snapshot.data;
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: tourData!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                bottom: 15, left: 10, right: 10),
                            child: InkWell(
                              onTap: () async {
                                await Get.to(
                                  TourDetailPage(
                                    tourID: index,
                                    tourSearch: searchController.text,
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                height: screenSize.height * 0.15,
                                width: screenSize.width * 0.7,
                                decoration: BoxDecoration(
                                  color: tWhite,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                alignment: Alignment.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: screenSize.height * 0.15,
                                      width: screenSize.width * 0.4,
                                      decoration: BoxDecoration(
                                        color: tGrey.withOpacity(0.06),
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            tourData[index]
                                                .resultObject!
                                                .image
                                                .images
                                                .original
                                                .imgsize
                                                .toString(),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const Gap(20),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: screenSize.width * 0.45,
                                          child: Text(
                                            tourData[index]
                                                .resultObject!
                                                .name
                                                .toString(),
                                            overflow: TextOverflow.fade,
                                            textAlign: TextAlign.left,
                                            maxLines: 2,
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: tBlack,
                                            ),
                                          ),
                                        ),
                                        const Gap(10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FittedBox(
                                              fit: BoxFit.fitHeight,
                                              child: Container(
                                                width: screenSize.width * 0.13,
                                                decoration: BoxDecoration(
                                                  color: Colors.green,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SvgPicture.network(
                                                        'https://www.svgrepo.com/show/407521/star.svg',
                                                        height: 12,
                                                        width: 12,
                                                        color: tWhite,
                                                      ),
                                                      const Gap(5),
                                                      Text(
                                                        tourData[index]
                                                            .resultObject!
                                                            .rating
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: tWhite,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Gap(20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  tourData[index]
                                                      .resultObject!
                                                      .review
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w500,
                                                    color: tBlack,
                                                  ),
                                                ),
                                                Text(
                                                  "(Reviews)",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        tBlack.withOpacity(0.4),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Gap(10),
                                        ButtonWidget(
                                          screenSize: screenSize,
                                          txt: "Get Spot",
                                          Height: screenSize.height * 0.03,
                                          Width: screenSize.width * 0.15,
                                          clr: tBlue,
                                          Click: () async {
                                            Get.to(
                                              LocationScreen(
                                                mapController: myController,
                                              ),
                                            );
                                            double latitude = double.parse(
                                                tourData[index]
                                                    .resultObject!
                                                    .lat
                                                    .toString());
                                            print(latitude);
                                            double longitude = double.parse(
                                                tourData[index]
                                                    .resultObject!
                                                    .long
                                                    .toString());
                                            print(longitude);
                                            await service.getLocation();
                                            myController.move(
                                                LatLng(
                                                  latitude,
                                                  longitude,
                                                ),
                                                18.0);
                                            geocodingLocation.getPlacemark(
                                              latitude,
                                              longitude,
                                            );
                                            myController.latLngToScreenPoint(
                                              LatLng(
                                                latitude,
                                                longitude,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Text(
                      "The Server is currently busy, Try again later",
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
        ],
      ),
    );
  }
}
