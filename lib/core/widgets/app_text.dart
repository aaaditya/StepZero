import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';

/// Semantic text wrappers bound to the typography scale.
///
/// Prefer these over raw [Text] + style so hierarchy stays consistent.
class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    required this.style,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.softWrap,
    super.key,
  });

  final String data;
  final TextStyle style;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool? softWrap;

  /// Fluid hero that scales with viewport.
  factory AppText.hero(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      _HeroText(
        data,
        key: key,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  factory AppText.headingXl(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      AppText(
        data,
        key: key,
        style: AppTypography.headingXlStyle,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  factory AppText.headingL(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      AppText(
        data,
        key: key,
        style: AppTypography.headingLStyle,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  factory AppText.headingM(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      AppText(
        data,
        key: key,
        style: AppTypography.headingMStyle,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  factory AppText.headingS(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      AppText(
        data,
        key: key,
        style: AppTypography.headingSStyle,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  factory AppText.bodyLarge(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      AppText(
        data,
        key: key,
        style: AppTypography.bodyLargeStyle,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  factory AppText.body(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      AppText(
        data,
        key: key,
        style: AppTypography.bodyStyle,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  factory AppText.small(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      AppText(
        data,
        key: key,
        style: AppTypography.smallStyle,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  factory AppText.caption(
    String data, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
  }) =>
      AppText(
        data,
        key: key,
        style: AppTypography.captionStyle,
        color: color,
        textAlign: textAlign,
        maxLines: maxLines,
      );

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: style.copyWith(color: color),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}

class _HeroText extends AppText {
  _HeroText(
    super.data, {
    super.key,
    super.color,
    super.textAlign,
    super.maxLines,
  }) : super(style: AppTypography.displayHero);

  @override
  Widget build(BuildContext context) {
    final size = Responsive.heroFontSize(context);
    return Text(
      data,
      style: AppTypography.displayHero.copyWith(
        fontSize: size,
        color: color ?? AppColors.textPrimary,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
    );
  }
}
