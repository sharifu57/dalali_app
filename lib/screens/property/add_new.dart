import 'dart:convert';
import 'dart:io';

import 'package:dalali_app/service/api.dart';
import 'package:dalali_app/service/logo.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../partials/colors.dart';
import '../../service/config.dart';

class AddNewProperty extends StatefulWidget {
  const AddNewProperty({super.key});

  @override
  State<AddNewProperty> createState() => _AddNewPropertyState();
}

class _AddNewPropertyState extends State<AddNewProperty> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};

  // File? imageFile;
  // XFile? photos;
  List categories = [];
  List locations = [];
  bool _isLoading = false;
  String? dropdownValue;
  int? selectedCategory;
  int? selectedLocation;

  // final ImagePicker _picker = ImagePicker();
  final SingleValueDropDownController _categoryController =
      SingleValueDropDownController();
  final SingleValueDropDownController _locationController =
      SingleValueDropDownController();

  File? imageFile;
  XFile? image;
  String? imagePath;

  final ImagePicker _picker = ImagePicker();

  selectImage(imageSource) async {
    image = await _picker.pickImage(source: imageSource);
    setState(() {
      imageFile = File(image!.path);
      imagePath = image!.path;
      print("_____my image path");
      print(imagePath);
    });
  }

  // selectImage(imageSource) async {
  //   photos = await _picker.pickImage(source: imageSource);
  //   setState(() {
  //     try {
  //       if (photos != null) {
  //         imageFile = File(photos!.path);

  //         print("_____imageFiel");
  //         print(imageFile);
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //   });
  // }

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

  Future getLocations() async {
    final response = await Dio().get("$apiBaseUrl/locations/");

    setState(() {
      locations = response.data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // getCategories().then((data) {
    //   setState(() {
    //     categoriesData = data;
    //   });
    // });
    getLocations();
    getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(20),
                child: Container(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text("Image:"),
                              ),
                              imageFile == null
                                  ? ElevatedButton(
                                      onPressed: () {
                                        selectImage(ImageSource.camera);
                                      },
                                      child: Text("Gallery"))
                                  : Container(
                                      child: Image.file(
                                        imageFile!,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                              Container(
                                padding: EdgeInsets.only(top: 30),
                                child: Column(
                                  children: [
                                    TextFormField(
                                      enabled: true,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              width: 3,
                                              color: AppColors.primaryColor),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        label: Text(
                                          "Name",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        hintText: "Add Name",
                                        hintStyle: const TextStyle(
                                            color: Color(0xFF11101E),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w400),
                                        prefixIcon: const Icon(
                                          Icons.money,
                                          color: Color(0xFF11101E),
                                          size: 14,
                                        ),
                                      ),
                                      keyboardType: TextInputType.text,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Enter Name";
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {
                                        _formData['title'] = value.toString();
                                      },
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 30),
                                      child: TextFormField(
                                        maxLines: 4,
                                        enabled: true,
                                        decoration: InputDecoration(
                                          prefix: const Icon(
                                            Icons.text_rotation_none,
                                            size: 14,
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 3,
                                                color: AppColors.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          hintText: "Enter your text here",
                                        ),
                                        keyboardType: TextInputType.text,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Describe";
                                          }
                                        },
                                        onSaved: (value) {
                                          _formData['description'] =
                                              value.toString();
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 30),
                                      child: TextFormField(
                                        enabled: true,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                width: 3,
                                                color: AppColors.primaryColor),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          label: Text(
                                            "Price",
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          hintText: "price",
                                          hintStyle: const TextStyle(
                                              color: Color(0xFF11101E),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400),
                                          prefixIcon: const Icon(
                                            Icons.money,
                                            color: Color(0xFF11101E),
                                            size: 14,
                                          ),
                                        ),
                                        keyboardType: TextInputType.text,
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Enter Price";
                                          }
                                          return null;
                                        },
                                        onSaved: (value) {
                                          _formData['price'] = value.toString();
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .black, // Change the color as desired
                                          width:
                                              1.0, // Adjust the width as desired
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Adjust the border radius as desired
                                      ),
                                      child: DropDownTextField(
                                        textFieldDecoration:
                                            const InputDecoration(
                                          label: Text("Select Category"),
                                          hintText: "Select Category",
                                          hintStyle: TextStyle(fontSize: 13),
                                          prefixIcon: Icon(
                                            Icons.place,
                                            color: Color(0xFF11101E),
                                            size: 14,
                                          ),
                                        ),
                                        controller: _categoryController,
                                        clearOption: false,
                                        enableSearch: true,
                                        dropDownItemCount: categories.length,
                                        clearIconProperty:
                                            IconProperty(color: Colors.green),
                                        searchDecoration: const InputDecoration(
                                            hintText: "Search Category",
                                            hintStyle: TextStyle(fontSize: 13)),
                                        dropDownList: [
                                          for (var category in categories)
                                            DropDownValueModel(
                                                name: "${category['title']}",
                                                value: category['id'])
                                        ],
                                        onChanged: (val) {
                                          setState(() {
                                            selectedCategory = val?.value;
                                            _formData['category'] =
                                                selectedCategory;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Required field";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors
                                              .black, // Change the color as desired
                                          width:
                                              1.0, // Adjust the width as desired
                                        ),
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Adjust the border radius as desired
                                      ),
                                      child: DropDownTextField(
                                        textFieldDecoration:
                                            const InputDecoration(
                                          label: Text("Select Location"),
                                          hintText: "Select Location",
                                          hintStyle: TextStyle(fontSize: 13),
                                          prefixIcon: Icon(
                                            Icons.place,
                                            color: Color(0xFF11101E),
                                            size: 14,
                                          ),
                                        ),
                                        controller: _locationController,
                                        clearOption: false,
                                        enableSearch: true,
                                        dropDownItemCount: locations.length,
                                        clearIconProperty:
                                            IconProperty(color: Colors.green),
                                        searchDecoration: const InputDecoration(
                                            hintText: "Search Location",
                                            hintStyle: TextStyle(fontSize: 13)),
                                        dropDownList: [
                                          for (var location in locations)
                                            DropDownValueModel(
                                                name: "${location['name']}",
                                                value: location['id'])
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            selectedLocation = value?.value;
                                            _formData['location'] =
                                                selectedLocation;
                                          });
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return "Required field";
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: GestureDetector(
                                        onTap: () {
                                          createNewProperty();
                                        },
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: _isLoading
                                              ? const SpinKitWave(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  size: 20.0,
                                                )
                                              : Card(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(),
                                                        const Center(
                                                          child: Text(
                                                            "Upload",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                        const Icon(
                                                          Icons
                                                              .arrow_forward_ios_rounded,
                                                          size: 15,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                ))
          ],
        )),
      ),
    ));
  }

  // createNewProperty() async {
  //   if (!_formKey.currentState!.validate()) {
  //     return;
  //   }

  //   _formKey.currentState!.save();

  //   setState(() {
  //     _isLoading = true;
  //   });

  //   print("___start print");
  //   FormData data = FormData.fromMap({
  //     'title': _formData['title'].toString(),
  //     'description': _formData['description'].toString().toString(),
  //     'price': _formData['price'].toString(),
  //     'category': _formData['category'].toString(),
  //     'location': _formData['location'].toString(),
  //     "photos": imageFile == null
  //         ? null
  //         : await MultipartFile.fromFile(imageFile!.path),
  //   });

  //   Map<String, dynamic> dataMap = Map.from(data);
  //   print("Print FormData as Map:");
  //   print(dataMap);
  //   print("_____mmmh");

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  createNewProperty() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    Map<String, dynamic> payload = {
      'title': _formData['title'].toString(),
      'description': _formData['description'].toString(),
      'price': _formData['price'].toString(),
      'property_type': _formData['category'].toString(),
      'location': _formData['location'].toString(),
    };

    // Add the 'photos' field if an image is selected
    if (imagePath != null) {
      payload["photos"] = imagePath;
    }

    print("___print payload");
    print(payload);
    final endpoint = '${config['apiBaseUrl']}/create_property/';
    final data = json.encode(payload);

    // var response = await sendPostRequest(context, endpoint, data);

    try {
      var response = await Dio()
          .post('${config['apiBaseUrl']}/create_property/', data: payload);

      print("____this is response");
      print(response);
      print("___end print response");

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print("____error on this code ");
      print(e);
    }
  }
}
