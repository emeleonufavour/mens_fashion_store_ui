import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String? text;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  const TextWidget(this.text,
      {this.color, this.fontWeight, this.fontSize, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      style: GoogleFonts.lato(
          color: color, fontWeight: fontWeight, fontSize: fontSize),
    );
  }
}
