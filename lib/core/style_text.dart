import 'package:google_fonts/google_fonts.dart';

import '../core_imports.dart';

class StyleText {
  static TextStyle textWhite({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: Colors.white,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle textBlack({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: ConstColor.colorText,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle textPrimary({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: Theme.of(Get.context!).primaryColor,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle textPrimaryDark({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: ConstColor.colorDark,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle textRed({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: Colors.red,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle textGrey({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: ConstColor.colorGrey4A,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle textLightGrey({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: ConstColor.colorLightGrey,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle text55555({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: ConstColor.color555555,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle text2D2D2D({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: ConstColor.color2d2d2d,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle text909090({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: ConstColor.color909090,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }

  static TextStyle textTosca({double? fontSize, FontWeight? fontWeight}) {
    return GoogleFonts.inter(
        color: ConstColor.colorTosca,
        fontSize: fontSize ?? 14,
        fontWeight: fontWeight ?? FontWeight.normal);
  }
}
