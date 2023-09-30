import 'package:dalali_app/partials/colors.dart';
import 'package:dalali_app/screens/authentication/login.dart';
import 'package:dalali_app/screens/navigation/bookmark.dart';
import 'package:dalali_app/screens/navigation/home.dart';
import 'package:dalali_app/screens/navigation/locations.dart';
import 'package:dalali_app/screens/navigation/profile.dart';
import 'package:dalali_app/screens/owner/index.dart';
import 'package:dalali_app/screens/property/add_new.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {});
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future checkUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("user");
    return userId;
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final tabs = [
      const Center(
        child: Home(),
      ),
      const Center(
        child: Navigate(),
      ),
      const Center(
        child: BookMark(),
      ),
      const Center(
        child: Profile(),
      )
    ];

    return Scaffold(
      body: Center(
        child: tabs.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 0, blurRadius: 20),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(0.0)),
            child: Container(
              color: Colors.orange,
              child: BottomNavigationBar(
                type: BottomNavigationBarType.shifting,
                elevation: 10,
                iconSize: 10,

                selectedIconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 43, 4, 4), size: 15),
                selectedItemColor: const Color(0xFF11101E),
                mouseCursor: SystemMouseCursors.grab,
                selectedLabelStyle:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 10),
                unselectedIconTheme: const IconThemeData(
                  color: Colors.black54,
                ),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Discover',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications_none),
                    label: 'Alerts',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_4_outlined),
                    label: 'Profile',
                  ),
                ],
                currentIndex: _selectedIndex, //New
                onTap: _onItemTapped,
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shape: const CircleBorder(),
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          String? user = await checkUser();

          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext) => const AddNewProperty()));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext) => const AddNewProperty()));
          }
        },
        child: isLoading
            // ignore: dead_code
            ? const CircularProgressIndicator(
                color: Colors.white, strokeWidth: 2)
            : const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
      ),
    );
  }
}
