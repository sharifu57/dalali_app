import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/property/view_property.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../service/config.dart';

class LocationProperties extends StatefulWidget {
  final String? id;
  final String? name;
  const LocationProperties({super.key, required this.id, required this.name});

  @override
  State<LocationProperties> createState() => _LocationPropertiesState();
}

class _LocationPropertiesState extends State<LocationProperties> {
  List? properties;
  @override
  void initState() {
    locationProperties();
    super.initState();
  }

  Future locationProperties() async {
    try {
      final response = await Dio()
          .get("$apiBaseUrl/location_properties/${widget.id}/get_properties");

      if (response.statusCode == 200) {
        setState(() {
          properties = response.data?['data'];
        });
      } else {}
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Center(
            child: Text(
          "${widget.name}",
          style: const TextStyle(
              fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500),
        )),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.notification_add))
        ],
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: const EdgeInsets.all(20),
        height: fullHeight,
        width: fullWidth,
        color: Colors.white,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                hintText: "Search here..",
                prefixIcon: const Icon(
                  Icons.search,
                  size: 14,
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(top: 25),
              child: properties?.length != 0
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 7.0,
                      ),
                      itemCount: properties?.length ?? 0,
                      itemBuilder: (BuildContext, index) {
                        final property = properties?[index];

                        if (property != null) {
                          final photos = property['photos'] as List<dynamic>;

                          return GestureDetector(
                            onTap: () {
                              print(property);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewProperty(
                                          property_id: property['id'],
                                          title: property['title'],
                                          description: property['description'],
                                          locationName: property['location']['name'],
                                          photos: photos)));
                            },
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              child: Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Container(
                                      child: photos.isNotEmpty &&
                                              photos[0]['url'] != null
                                          ? Image.network(
                                              '$path${photos[0]['url']}',
                                              fit: BoxFit.contain,
                                            )
                                          : Text(""),
                                    ),
                                    Container(
                                        padding: const EdgeInsets.only(top: 10),
                                        width: double.infinity,
                                        child: Card(
                                          color: AppColors.primaryColor,
                                          child: Container(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${property['title']}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      )),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      "Tzs ${property['price']}",
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 10),
                                                    ),
                                                  )
                                                ],
                                              )),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return Container(); // or another suitable widget
                        }
                      })
                  : const Center(
                      child: Text("No data"),
                    ),
            ))
          ],
        ),
      )),
    );
  }
}