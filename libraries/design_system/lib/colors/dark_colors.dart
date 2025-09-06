import 'package:flutter/material.dart';

import 'colors.dart';

class DarkColors implements MyColors {
  const DarkColors();
  @override
  Color get appbarBackground => const Color(0xff1f2b4a);

  @override
  Color get primary => const Color(0xff2b4fba);

  @override
  Color get screenBackground => const Color(0xff1A2340); //

  @override
  Color get secondery => Colors.white;

  @override
  Color get textBlack => const Color(0xFFeeeeee);

  @override
  Color get error => const Color(0xFFff3952);

  @override
  Color get textGrey => const Color(0xFF9ca3af);

  @override
  Color get textHint => const Color(0xFF9da1a9);

  @override
  Color get white => const Color(0xFFFFFFFF);

  @override
  Color get gray => const Color(0xFF1f2b4a);

  @override
  Color get textInputBorderColor => const Color(0xff121212);
}
