import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/location/properties_by_location.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../service/config.dart';

class Navigate extends StatefulWidget {
  const Navigate({super.key});

  @override
  State<Navigate> createState() => _NavigateState();
}

class _NavigateState extends State<Navigate> {
  List? locations = [];

  @override
  void initState() {
    getLocations();
    super.initState();
  }

  Future getLocations() async {
    final response = await Dio().get("$apiBaseUrl/locations/");

    setState(() {
      locations = response.data;
    });
  }

  List<Widget> buildListTiles() {
    if (locations == null) {
      return []; // Return an empty list if locations is null
    }

    return locations!.map<Widget>((location) {
      return SingleChildScrollView(
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: AppColors.primaryColor,
            child: Text("0"),
          ),
          title: Text(
            location['name'],
            style: const TextStyle(fontWeight: FontWeight.w500),
          ), // Use the appropriate field from your API response
          // Add other properties and functionalities to the ListTile as needed
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Center(
          child: Text(
            "Locations",
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            width: fullWidth,
            child: Container(
                padding: const EdgeInsets.only(
                    top: 0, bottom: 20, left: 20, right: 20),
                child: const SizedBox(
                  child: TextField(
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: Color(0xffffffff),
                      ),
                      hintText: 'Search...',
                    ),
                  ),
                )),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.only(top: 10),
            height: fullHeight,
            width: fullWidth,
            child: locations!.length == 0
                ? const SpinKitWave(
                    color: AppColors.secondaryColor,
                    size: 20.0,
                  )
                : ListView.separated(
                    itemCount: locations?.length ?? 0,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(), // Add divider between tiles
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          print("${index}");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LocationProperties(
                                      id: locations![index]['id'].toString(),
                                      name: locations![index]['name'])));
                        },
                        child: buildListTiles()[index],
                      );
                    },
                  ),
          ))
        ],
      ),
    );
  }
}
