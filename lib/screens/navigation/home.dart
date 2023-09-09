import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/service/config.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? phone;
  List? categories;
  List? properties;
  @override
  void initState() {
    // TODO: implement initState
    getLocalUser().then((value) {
      setState(() {
        phone = value;
      });
    });

    getCategories();
    getProperties();

    super.initState();
  }

  Future getCategories() async {
    try {
      final response = await Dio().get("${apiBaseUrl}/property_types/");

      setState(() {
        categories = response.data;
      });
    } catch (e) {
      print(e);
    }
  }

  Future getProperties() async {
    final response = await Dio().get("${apiBaseUrl}/properties/");

    setState(() {
      properties = response.data;
    });

  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: 50, left: 20, right: 0),
        height: fullHeight,
        width: fullWidth,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Welcome,",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "${phone}",
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                      )
                    ],
                  )),
                  Container(
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notification_add_sharp)),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              height: fullHeight / 6.5,
              width: fullWidth,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories?.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print("card, ${index}");
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 70,
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              child: Card(
                                color: AppColors.primaryColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                    child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Icon(
                                    Icons.ballot,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                )),
                              ),
                            ),
                            Container(
                              child: Text(
                                "${categories?[index]['title']}",
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Best Today",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                      onPressed: () {
                        print("_____see for today");
                      },
                      child: Text(
                        "See all",
                        style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w500),
                      ))
                ],
              ),
            ),
            Container(
                child: Container(
              height: fullHeight / 2.8,
              width: fullWidth,
              child: Container(
                child: ListView.builder(
                    itemCount: properties?.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext, index) {
                      return Container(
                        width: fullWidth - 40,
                        child: Card(
                          color: AppColors.primaryColor,
                          child: Column(
                            children: [
                              Expanded(
                                  child: Container(
                                height: fullHeight,
                              )),
                              Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  alignment: Alignment.centerLeft,
                                  height: fullHeight / 3,
                                  child: Column(
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${properties?[index]['title']}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${properties?[index]['location']?['name']}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     const Text(
            //       "Nearby Your Location",
            //       style: TextStyle(
            //           color: AppColors.primaryColor,
            //           fontWeight: FontWeight.w600),
            //     ),
            //     TextButton(
            //         onPressed: () {
            //           print("_____see for today");
            //         },
            //         child: const Text(
            //           "See More",
            //           style: TextStyle(
            //               color: AppColors.primaryColor,
            //               fontWeight: FontWeight.w500),
            //         ))
            //   ],
            // ),
            // Expanded(child: SingleChildScrollView(
            //   child: Container(
            //     child: SafeArea(
            //         child: ListView.builder(itemBuilder: (BuildContext, index) {
            //       return Card();
            //     })),
            //   ),
            // ))
          ],
        ),
      ),
    );
  }

  Future getLocalUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final phoneNumber = prefs.getString("phone_number");
    return phoneNumber;
  }
}
