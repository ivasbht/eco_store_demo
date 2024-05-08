import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String? text;
  final List<TextSpan>? textSpans;
  final Color? color;
  final Color? backgroundColor;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final double? letterSpacing;
  final double? wordSpacing;
  final TextBaseline? textBaseline;
  final double? height;
  final List<Shadow>? shadows;
  final TextDecoration? decoration;
  final Color? decorationColor;
  final TextDecorationStyle? decorationStyle;
  final double? decorationThickness;
  final String? fontFamily;
  final int? maxLine;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final bool softWrap;

  const CustomText({
    super.key,
    this.text,
    this.textSpans,
    this.color,
    this.backgroundColor,
    this.fontSize = 16,
    this.fontWeight,
    this.fontStyle,
    this.letterSpacing,
    this.wordSpacing,
    this.textBaseline,
    this.height,
    this.shadows,
    this.decoration,
    this.decorationColor,
    this.decorationStyle,
    this.decorationThickness,
    this.fontFamily,
    this.maxLine,
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.start,
    this.softWrap = true,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLine,
      overflow: overflow,
      softWrap: softWrap,
      textAlign: textAlign,
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          backgroundColor: backgroundColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          letterSpacing: letterSpacing,
          wordSpacing: wordSpacing,
          textBaseline: textBaseline,
          height: height,
          shadows: shadows,
          decoration: decoration,
          decorationColor: decorationColor,
          decorationStyle: decorationStyle,
          decorationThickness: decorationThickness,
          fontFamily: fontFamily,
        ),
        children: textSpans,
      ),
    );
  }
}
