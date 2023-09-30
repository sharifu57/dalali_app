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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primaryColor,
        title: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                "Welcome,",
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "$phone",
                style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
                size: 20,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: fullHeight,
          width: fullWidth,
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: fullHeight / 6.5,
                  width: fullWidth,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories?.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 70,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 70,
                                  child: Card(
                                    color: AppColors.primaryColor,
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Center(
                                        child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: const Icon(
                                        Icons.ballot,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    )),
                                  ),
                                ),
                                Text(
                                  "${categories?[index]['title'] ?? ""}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Recent Added",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                        // IconButton(
                        //     onPressed: () {},
                        //     icon: const Text(
                        //       "More",
                        //       style: TextStyle(color: AppColors.primaryColor),
                        //     ))
                      ],
                    )),
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  height: fullHeight / 5,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: properties?.length,
                      itemBuilder: (BuildContext, index) {
                        final property = properties?[index];
                        final photos = property?['photos'] ?? "";

                        return Container(
                          width: fullWidth - 50,
                          child: GestureDetector(
                            onTap: () {},
                            child: Card(
                              elevation: 5,
                              child: ClipRRect(
                                // borderRadius: const BorderRadius.only(
                                //   topLeft: Radius.circular(20),
                                //   topRight: Radius.circular(20),
                                // ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                  color: AppColors.primaryColor,
                                  child: Column(
                                    children: [
                                      Container(
                                        child:
                                            photos != null && photos.isNotEmpty
                                                ? Image.network(
                                                    '${photos[0]['url']}',
                                                    fit: BoxFit.cover,
                                                    height: 270,
                                                    width: double.infinity,
                                                  )
                                                : Container(
                                                    height: 270,
                                                    color: Colors.grey,
                                                    child: Center(
                                                      child: Icon(
                                                          Icons
                                                              .hourglass_empty_rounded,
                                                          color: Colors.white,
                                                          size: 60),
                                                    ),
                                                  ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 10, top: 10),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "${property?['location']?['name']}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              "${property?['title']}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Text(
                                              "Tzs ${property?['price']}",
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )),
                SizedBox(
                  height: fullHeight / 3,
                  child: const Card(),
                )
              ],
            ),
          ),
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
