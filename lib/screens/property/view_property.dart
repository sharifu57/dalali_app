import 'package:carousel_slider/carousel_slider.dart';
import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/location/properties_by_location.dart';
import 'package:flutter/material.dart';

import '../../service/config.dart';

class ViewProperty extends StatefulWidget {
  String? title;
  String? locationName;
  String? description;
  final property_id;
  List photos;
  ViewProperty(
      {super.key,
      required this.property_id,
      required this.description,
      required this.locationName,
      required this.photos,
      required this.title});

  @override
  State<ViewProperty> createState() => _ViewPropertyState();
}

class _ViewPropertyState extends State<ViewProperty> {
  @override
  Widget build(BuildContext context) {
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
                      Container(
                        padding: EdgeInsets.only(top: 20),
                        alignment: Alignment.centerLeft,
                        child: Text("${widget.description}"),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
