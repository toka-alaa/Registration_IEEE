import 'package:flutter/material.dart';
import 'package:registration_ieee/const/color.dart';
import 'package:registration_ieee/views/qr_scan.dart';
import 'absetees.dart';
import 'history.dart';

class Layout extends StatefulWidget {
  Layout({super.key});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  List<Widget> screens = [Absentees(), QRScanPage(), History()];
  int _selectedIndex = 0;
  bool tap = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        height: 70,
        color: AppColors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.person_off,
                color: tap ? AppColors.primary2 : AppColors.secondary,
              ),
              onPressed: () {
                tap = true;
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),
            const SizedBox(width: 48), // space for FAB
            IconButton(
              icon: Icon(Icons.history,
                  color: tap ? AppColors.secondary : AppColors.primary2),
              onPressed: () {
                tap = false;
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.secondary,
        onPressed: () {
          tap = false;
          setState(() {
            _selectedIndex = 1;
          });
        },
        child: const Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}