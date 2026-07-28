import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';

/// Styled text field aligned to StepZero input tokens.
///
/// Wraps [TextFormField] so forms stay visually consistent without
/// re-declaring decoration on every screen.
class AppTextField extends StatelessWidget {
  const AppTextField({
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.helperText,
    this.errorText,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.prefix,
    this.suffix,
    this.autofocus = false,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final String? helperText;
  final String? errorText;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTypography.labelStyle.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          obscureText: obscureText,
          enabled: enabled,
          readOnly: readOnly,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          autofillHints: autofillHints,
          inputFormatters: inputFormatters,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          autofocus: autofocus,
          style: AppTypography.bodyStyle.copyWith(color: AppColors.textPrimary),
          cursorColor: AppColors.accent,
          decoration: InputDecoration(
            hintText: hint,
            helperText: helperText,
            errorText: errorText,
            prefixIcon: prefix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.md, right: AppSpacing.xs),
                    child: prefix,
                  ),
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            suffixIcon: suffix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.md, left: AppSpacing.xs),
                    child: suffix,
                  ),
            suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
            counterText: '',
          ),
        ),
      ],
    );
  }
}
