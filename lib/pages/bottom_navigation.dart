import 'package:ebooknew/pages/home.dart';
import 'package:ebooknew/pages/media.dart';
import 'package:ebooknew/pages/pray.dart';
import 'package:ebooknew/pages/tool.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,

        onPageChanged: (value){
          setState(() {
            currentIndex = value;
          });
        },
        children: const [
          HomePages(),
          MediaScreen(),
          ToolScreen(),
          PrayScreen()
        ],
      ),

      bottomNavigationBar: SalomonBottomBar(
          items: [
        SalomonBottomBarItem(icon: const Icon(Icons.menu_book), title: const Text('Books')),
        SalomonBottomBarItem(icon: const Icon(Icons.video_collection_outlined), title: const Text('Media')),
        SalomonBottomBarItem(icon: const Icon(Icons.handyman_rounded), title: const Text('Tools')),
        SalomonBottomBarItem(icon: const Icon(Icons.real_estate_agent_outlined), title: const Text('Pray')),
        SalomonBottomBarItem(icon: const Icon(Icons.perm_identity), title: const Text('Profile'))
      ],
          currentIndex: currentIndex,
          onTap: (value){
            setState(() {
              pageController.animateToPage(value, duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
            });
          },
      ),

    );
  }
}
