import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Add_Pr.dart';
import 'package:admin_mag_poul/controlers/ChangeEntrePageHome.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final ChangePage controller = Get.put(ChangePage());

  // List of widgets for different tabs
  final List<Widget> _pages = [
    GarageFormView(),
    Center(child: Text('Search Page', style: TextStyle(fontSize: 24))),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return _pages[controller.currentIndex.value];
      }),
      bottomNavigationBar: Obx((){
        return   BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) {
            controller.Increment(index);
          },
          items:const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.manage_accounts_sharp),
              label: 'manage garage',
            ),
          ],
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
        );
      }

      ),
    );
  }
}
