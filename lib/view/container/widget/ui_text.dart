import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UIText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final StrutStyle? strutStyle;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final bool? softWrap;

  const UIText(
      {Key? key,
      required this.text,
      this.style,
      this.strutStyle,
      this.maxLines,
      this.textAlign,
      this.overflow,
      this.softWrap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaleFactor: 1.0,
      maxLines: maxLines,
      style: GoogleFonts.inter(
              fontWeight: FontWeight.w600, fontSize: 14, height: 1.25)
          .merge(style),
      softWrap: softWrap,
      overflow: overflow,
      textAlign: textAlign,
      strutStyle: strutStyle,
    );
  }
}
