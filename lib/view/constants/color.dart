import 'dart:ui';

import 'package:flutter/material.dart';

class UIColors {
  UIColors._();
  static final Color primary = HexColor.fromHex('#4B3EAE');
  static final Color bg = HexColor.fromHex('#D4D1F0');
  static final Color description = HexColor.fromHex('#DBD9F2');
  static final Color detail = HexColor.fromHex('#F1F0FA');
  static final Color textDes = HexColor.fromHex('#DDDBF3');
  static  Color white = Colors.white;
  static  Color black = Colors.black;
}
extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if(buffer.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
     Color color = Colors.black;
    try{
      color = Color(int.parse(buffer.toString() , radix: 16));
    }catch(e) {

    }
    return color;
  }
}