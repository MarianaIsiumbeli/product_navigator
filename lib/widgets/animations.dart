import 'package:flutter/material.dart';

class Animations {
  static AnimationController createAnimationController(TickerProvider vsync) {
    return AnimationController(
      duration: const Duration(seconds: 10), 
      vsync: vsync,
     )..repeat(reverse: true);
  }

  static Animation<double> createScaleAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 0.2,
      end: 1,  
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }  

  static Animation<double> createFadeAnimation(AnimationController controller) {
    return Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
  }
}