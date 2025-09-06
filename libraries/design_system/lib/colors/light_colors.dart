import 'package:design_system/colors/colors.dart';
import 'package:flutter/material.dart';

class LightColors implements MyColors {
  const LightColors();
  @override
  Color get appbarBackground => const Color(0xFFFFFFFF);

  @override
  Color get primary => const Color(0xff2b4fba);

  @override
  Color get screenBackground => const Color(0xFFFaFaFa);

  @override
  Color get secondery => Colors.white;

  @override
  Color get textBlack => const Color(0xFF111111);

  @override
  Color get error => const Color(0xFFff3952);

  @override
  Color get textGrey => const Color(0xFF6b7280); //

  @override
  Color get textHint => const Color(0xFF9da1a9);

  @override
  Color get white => const Color(0xFFFFFFFF);
}
