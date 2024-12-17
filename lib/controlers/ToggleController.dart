import 'package:get/get.dart';
import 'package:flutter/material.dart';


class ToggleController extends GetxController {


  var selectedStates = [true, false].obs;


  void toggle(int index) {
    for (int i = 0; i < selectedStates.length; i++) {
      selectedStates[i] = (i == index);
    }
  }
}