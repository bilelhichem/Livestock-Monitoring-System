import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';


class ChangePage extends GetxController{
  RxInt currentIndex = 0.obs;

  void Increment(int index){
    currentIndex.value = index;
  }
}