import 'package:flutter/material.dart';
import 'package:pockettracker/view/hompage/homepage.dart';

class PocketTrackerBottomNavigation extends StatelessWidget {
  const PocketTrackerBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return   ValueListenableBuilder(
      valueListenable: Home.selectedIndexNotifier,
      builder:(BuildContext ctx ,int updatedIndex ,Widget){
        return BottomNavigationBar(
          unselectedFontSize: 15,
          selectedFontSize: 15,
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.purple,
          currentIndex: updatedIndex,
            onTap: (newIndex){
            Home.selectedIndexNotifier.value=newIndex;
            },
            items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Transactions",),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: "Category"),
        ]);
      } ,
    );
  }
}
