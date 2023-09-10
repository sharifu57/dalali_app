import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/location/properties_by_location.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../service/config.dart';

class ViewProperty extends StatefulWidget {
  String? title;
  String? price;
  String? locationName;
  String? description;
  String? ownerFirstName;
  String? ownerLastName;
  String? ownerPhone;
  final property_id;
  List photos;
  ViewProperty(
      {super.key,
      required this.property_id,
      required this.price,
      required this.description,
      required this.locationName,
      required this.photos,
      required this.ownerFirstName,
      required this.ownerLastName,
      required this.ownerPhone,
      required this.title});

  @override
  State<ViewProperty> createState() => _ViewPropertyState();
}

class _ViewPropertyState extends State<ViewProperty> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    String formattedPrice = widget.price ??
        '0'; // Provide a default value of '0' if widget.price is null
    formattedPrice = NumberFormat.currency(
      symbol: 'Tzs ',
      decimalDigits: 2,
    ).format(double.parse(formattedPrice));

    return Scaffold(
      // appBar: AppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        // child: Text("${widget.property_id}"),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 2.1,
                    color: Colors.white,
                    child: CarouselSlider.builder(
                      itemCount: widget.photos.length,
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height / 2.1,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 2000),
                        viewportFraction: 1.0,
                      ),
                      itemBuilder: (BuildContext context, int itemIndex,
                              int pageViewIndex) =>
                          ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              // side: BorderSide(color: Colors.white, width: 1),
                              // borderRadius: BorderRadius.circular(30),
                              ),
                          elevation: 4,
                          child: Container(
                            child: widget.photos == null
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                    strokeWidth: 1,
                                  )
                                : Image.network(
                                    '$path${widget.photos[itemIndex]['url']}',
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 25,
                      left: 15,
                      child: Container(
                        padding: const EdgeInsets.only(top: 15),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: Center(
                            child: Card(
                              color: AppColors.primaryColor,
                              child: Center(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      // Navigator.push(context, LocationProperties(id: id, name: name))
                                    },
                                    icon: Icon(
                                      Icons.arrow_back_ios_sharp,
                                      color: Colors.white,
                                      size: 12,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      )),
                  Positioned(
                      top: 25,
                      right: 15,
                      child: Container(
                        padding: const EdgeInsets.only(top: 15),
                        // child: GestureDetector(
                        //   onTap: () {},
                        //   child: Center(
                        //     child: Card(
                        //       color: AppColors.primaryColor,
                        //       child: Center(
                        //         child: IconButton(
                        //             onPressed: () {
                        //               // Navigator.push(context, LocationProperties(id: id, name: name))
                        //             },
                        //             icon: Icon(
                        //               Icons.bookmark_border_outlined,
                        //               color: Colors.white,
                        //               size: 16,
                        //             )),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ))
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.title?.toUpperCase()}",
                            style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(right: 5),
                                child: const Icon(
                                  Icons.pin_drop_rounded,
                                  color: AppColors.primaryColor,
                                  size: 12,
                                ),
                              ),
                              Text(
                                "${widget.locationName}",
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          child: DefaultTextStyle.merge(
                              child: Padding(
                            key: Key('showMore'),
                            padding: EdgeInsets.only(top: 16.0),
                            child: ReadMoreText(
                              '${widget.description}',
                              trimLines: 2,
                              preDataText: "AMANDA",
                              preDataTextStyle:
                                  TextStyle(fontWeight: FontWeight.w600),
                              style: TextStyle(color: Colors.black),
                              colorClickableText: AppColors.primaryColor,
                              trimMode: TrimMode.Line,
                              trimCollapsedText: '...Show more',
                              trimExpandedText: ' show less',
                            ),
                          )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          width: double.infinity,
                          child: Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: SizedBox(
                                          height: 70,
                                          width: 4,
                                          child: Card(
                                            color: const Color(0xff04172B),
                                            shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(100.0),
                                              ),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 0, top: 0),
                                              child: Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100.0),
                                                  child: Container(
                                                    child:
                                                        widget.ownerFirstName ==
                                                                null
                                                            ? Container(
                                                                child: Text(
                                                                  "Name",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            : Container(
                                                                child: Text(
                                                                  "${widget.ownerFirstName?[0]}"
                                                                      .toUpperCase(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 6,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 5),
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5),
                                                    child: Text(
                                                      "${widget.ownerFirstName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "${widget.ownerLastName}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Text("Owner: "),
                                                  ),
                                                  Container(
                                                    child:
                                                        Text("${widget.title}"),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Container(
                                        child: Card(
                                          color: AppColors.primaryColor,
                                          child: IconButton(
                                              onPressed: () {
                                                call(widget.ownerPhone);
                                              },
                                              icon: Icon(
                                                Icons.call_sharp,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Card(
                  elevation: 4,
                  // shape: BorderRadius.circular(20.0),
                  child: Container(
                    color: AppColors.primaryColor, // Set the background color
                    padding: EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${formattedPrice}", // Replace with the actual price
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle the "Book Now" button press
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: AppColors.primaryColor,
                            textStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: Text("Book Now"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  call(phoneNumber) async {
    if (!await launch("tel:$phoneNumber")) throw 'could not call';
  }
}
