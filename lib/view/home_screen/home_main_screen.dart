import 'package:automated_bone_marrow_cell_classification_system/controller/home_main_controller/history_controller/history_controller.dart';
import 'package:automated_bone_marrow_cell_classification_system/controller/home_main_controller/home_screens_controller/home_controller.dart';
import 'package:automated_bone_marrow_cell_classification_system/view/home_screen/history_screen/history_screen.dart';
import 'package:automated_bone_marrow_cell_classification_system/view/home_screen/home_screen.dart';
import 'package:automated_bone_marrow_cell_classification_system/view/home_screen/setting_screen.dart/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:get/get.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  PersistentTabController? _controller;

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: const Color.fromARGB(255, 0, 0, 0),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.history_rounded),
        title: "History",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: const Color.fromARGB(255, 0, 0, 0),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: const Color.fromARGB(255, 0, 0, 0),
      ),
    ];
  }

  @override
  void initState() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<HistoryController>(() => HistoryController());

    super.initState();
  }

  List<Widget> _buildScreens() {
    return [HomeScreen(), HistoryScreen(), SettingScreen()];
  }

  @override
  Widget build(BuildContext context) {
    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      onItemSelected: (index) async {
        print(index);
        if (index == 1) {
          await Get.find<HistoryController>().fetchHistoryItems();
        }
      },
      backgroundColor:
          const Color.fromARGB(255, 82, 141, 230), // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
