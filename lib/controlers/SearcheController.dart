import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController {
  final isDark = false.obs;
  final searchQuery = ''.obs;
  final searchController = TextEditingController();

  void toggleTheme() {
    isDark.value = !isDark.value;
  }

  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
  }
}
