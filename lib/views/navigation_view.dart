import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'home_view.dart';
import 'add_artwork_view.dart';
import 'profile_view.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  int currentIndex = 0;

  //  Pages List
  final List<Widget> pages = [
    HomeView(),
    AddArtworkView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        //  Translated Labels
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: "home".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_box),
            label: "add".tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: "profile".tr,
          ),
        ],
      ),
    );
  }
}
