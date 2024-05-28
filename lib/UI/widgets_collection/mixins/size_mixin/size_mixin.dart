import 'package:flutter/material.dart';

mixin SizeMixin{
  late double screenHeight;
  late double screenWidth;
  late double aspectRatio;
  late Size screenSize;
  
  void initializaSize(BuildContext ctxt){
    screenSize = MediaQuery.of(ctxt).size;
    screenHeight = screenSize.height;
    screenWidth = screenSize.width;
    aspectRatio = screenSize.aspectRatio;
  }

}