import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';

/// Button visual variants for StepZero.
enum AppButtonVariant {
  /// Filled accent — primary conversion CTA.
  primary,

  /// Outlined — secondary actions.
  secondary,

  /// Text-only — tertiary / nav-adjacent.
  ghost,

  /// Near-black fill — high-contrast editorial CTA.
  dark,

  /// White outline for dark surfaces (final CTA, etc.).
  onDark,
}

enum AppButtonSize {
  sm,
  md,
  lg,
}

/// Production button with hover, focus, and disabled states.
///
/// Prefer this over raw Material buttons so CTAs stay brand-consistent.
class AppButton extends StatefulWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.md,
    this.leading,
    this.trailing,
    this.expand = false,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? leading;
  final Widget? trailing;
  final bool expand;
  final bool isLoading;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _hovered = false;
  bool _focused = false;

  bool get _enabled => widget.onPressed != null && !widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padding = _paddingFor(widget.size, compact: isMobile);
    final colors = _colorsFor(widget.variant, hovered: _hovered);

    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      padding: padding,
      decoration: BoxDecoration(
        color: _enabled ? colors.background : colors.background.withValues(alpha: 0.4),
        borderRadius: AppRadius.mdAll,
        border: colors.borderColor != null
            ? Border.all(
                color: _focused ? AppColors.borderFocus : colors.borderColor!,
                width: _focused ? 1.5 : 1,
              )
            : (_focused
                ? Border.all(color: AppColors.borderFocus, width: 1.5)
                : null),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: AppColors.borderFocus.withValues(alpha: 0.25),
                  blurRadius: 0,
                  spreadRadius: 3,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.isLoading) ...[
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: colors.foreground,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
          ] else if (widget.leading != null) ...[
            IconTheme(
              data: IconThemeData(color: colors.foreground, size: 18),
              child: widget.leading!,
            ),
            const SizedBox(width: AppSpacing.xs),
          ],
          Flexible(
            child: Text(
              widget.label,
              style: AppTypography.buttonLabel.copyWith(color: colors.foreground),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (widget.trailing != null && !widget.isLoading) ...[
            const SizedBox(width: AppSpacing.xs),
            IconTheme(
              data: IconThemeData(color: colors.foreground, size: 18),
              child: widget.trailing!,
            ),
          ],
        ],
      ),
    );

    return FocusableActionDetector(
      enabled: _enabled,
      onShowFocusHighlight: (focused) => setState(() => _focused = focused),
      onShowHoverHighlight: (hovered) => setState(() => _hovered = hovered),
      mouseCursor:
          _enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onPressed?.call();
            return null;
          },
        ),
      },
      child: GestureDetector(
        onTap: _enabled ? widget.onPressed : null,
        child: widget.expand ? child : IntrinsicWidth(child: child),
      ),
    );
  }

  EdgeInsets _paddingFor(AppButtonSize size, {required bool compact}) {
    return switch (size) {
      AppButtonSize.sm => const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
      AppButtonSize.md => EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: compact ? AppSpacing.sm : AppSpacing.md,
        ),
      AppButtonSize.lg => const EdgeInsets.symmetric(
          horizontal: AppSpacing.xl,
          vertical: AppSpacing.md + 2,
        ),
    };
  }

  _ButtonColors _colorsFor(
    AppButtonVariant variant, {
    required bool hovered,
  }) {
    return switch (variant) {
      AppButtonVariant.primary => _ButtonColors(
          background: hovered ? AppColors.accentHover : AppColors.accent,
          foreground: AppColors.textOnAccent,
        ),
      AppButtonVariant.secondary => _ButtonColors(
          background: hovered ? AppColors.surfaceMuted : Colors.transparent,
          foreground: AppColors.textPrimary,
          borderColor: AppColors.border,
        ),
      AppButtonVariant.ghost => _ButtonColors(
          background: hovered
              ? AppColors.accent.withValues(alpha: 0.06)
              : Colors.transparent,
          foreground: hovered ? AppColors.accent : AppColors.textPrimary,
        ),
      AppButtonVariant.dark => _ButtonColors(
          background:
              hovered ? const Color(0xFF1A1A1A) : AppColors.textPrimary,
          foreground: AppColors.textInverse,
        ),
      AppButtonVariant.onDark => _ButtonColors(
          background: hovered
              ? AppColors.surface.withValues(alpha: 0.12)
              : Colors.transparent,
          foreground: AppColors.textInverse,
          borderColor: AppColors.surface.withValues(alpha: 0.45),
        ),
    };
  }
}

class _ButtonColors {
  const _ButtonColors({
    required this.background,
    required this.foreground,
    this.borderColor,
  });

  final Color background;
  final Color foreground;
  final Color? borderColor;
}
