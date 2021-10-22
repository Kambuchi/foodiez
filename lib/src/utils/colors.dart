import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' show Color;

const primaryColor = Color(0xff43bbb7);
const grayColor = Color(0xfffdfdfd);

class Palette { 
  static const MaterialColor primaryPalette = MaterialColor( 
    0xff43bbb7, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch. 
    <int, Color>{ 
      50: Color(0xffa1dddb),//10% 
      100: Color(0xff8ed6d4),//20% 
      200: Color(0xff7bcfcd),//30% 
      300: Color(0xff69c9c5),//40% 
      400: Color(0xff56c2be),//50% 
      500: Color(0xff43bbb7),//60% 
      600: Color(0xff3ca8a5),//70% 
      700: Color(0xff369692),//80% 
      800: Color(0xff2f8380),//90% 
      900: Color(0xff28706e),//100% 
    }, 
  ); 
}