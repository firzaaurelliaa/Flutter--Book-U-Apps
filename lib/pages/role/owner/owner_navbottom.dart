// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:beautips/pages/role/owner/owner_log.dart';
import 'package:beautips/pages/role/owner/owner_profile.dart';
import 'package:beautips/pages/role/owner/tabbar_keuangan/tabbar.dart';
import 'package:beautips/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:water_drop_nav_bar/water_drop_nav_bar.dart';

class NavBottomOwner extends StatefulWidget {
  const NavBottomOwner({Key? key}) : super(key: key);

  @override
  _NavBottomOwnerState createState() => _NavBottomOwnerState();
}

class _NavBottomOwnerState extends State<NavBottomOwner> {
  final Color navigationBarColor = Colors.white;
  int selectedIndex = 0;
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    /// [AnnotatedRegion<SystemUiOverlayStyle>] only for android black navigation bar. 3 button navigation control (legacy)

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // backgroundColor: Colors.grey,
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          // ignore: prefer_const_literals_to_create_immutables
          children: <Widget>[
            OwnerTabbarLaporanKeuangan(),
            LogActivity(),
            OwnerProfile(),
          ],
        ),
        bottomNavigationBar: WaterDropNavBar(
          backgroundColor: navigationBarColor,
          waterDropColor: apphijau,
          onItemSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
            pageController.animateToPage(selectedIndex,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuad);
          },
          selectedIndex: selectedIndex,
          barItems: <BarItem>[
            BarItem(
              filledIcon: Icons.attach_money_rounded,
              outlinedIcon: Icons.attach_money_outlined,
            ),
            BarItem(
              filledIcon: Icons.work_history_rounded,
              outlinedIcon: Icons.work_history_outlined,
            ),
            BarItem(
              filledIcon: Icons.person_rounded,
              outlinedIcon: Icons.person_outline,
            ),
          ],
        ),
      ),
    );
  }
}
