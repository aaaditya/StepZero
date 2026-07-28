import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../animations/hover_effects.dart';
import '../constants/brand.dart';
import '../constants/curves.dart';
import '../constants/durations.dart';
import '../routing/routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import 'app_button.dart';
import 'app_container.dart';

/// Sticky glass navigation bar — reusable chrome for marketing surfaces.
///
/// Elevates opacity/blur after scroll for WCAG-friendly contrast while
/// keeping the hero immersive at rest.
class GlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GlassAppBar({
    required this.location,
    this.scrolled = false,
    this.height = 72,
    this.maxWidth = 1440,
    super.key,
  });

  final String location;
  final bool scrolled;
  final double height;
  final double maxWidth;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final bar = ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: scrolled ? 18 : 14,
          sigmaY: scrolled ? 18 : 14,
        ),
        child: AnimatedContainer(
          duration: reduceMotion ? Duration.zero : AppDurations.fast,
          curve: AppCurves.hover,
          decoration: BoxDecoration(
            color: AppColors.background.withValues(
              alpha: scrolled ? 0.92 : 0.78,
            ),
            border: Border(
              bottom: BorderSide(
                color: AppColors.border.withValues(
                  alpha: scrolled ? 1 : 0.7,
                ),
              ),
            ),
            boxShadow: scrolled
                ? [
                    BoxShadow(
                      color: AppColors.textPrimary.withValues(alpha: 0.04),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: height,
              child: MaxWidthBox(
                maxWidth: maxWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.pageGutter(context),
                ),
                child: Semantics(
                  container: true,
                  label: 'Primary',
                  explicitChildNodes: true,
                  child: Row(
                    children: [
                      Semantics(
                        button: true,
                        label: '${Brand.name} home',
                        child: HoverOpacity(
                          onTap: () => context.go(AppRoutes.home),
                          child: Text(
                            Brand.name,
                            style: AppTypography.headingSStyle.copyWith(
                              fontSize: 22,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (isDesktop) ...[
                        for (final item in AppNav.primary) ...[
                          _GlassNavLink(
                            label: item.label,
                            path: item.path,
                            selected: location == item.path,
                          ),
                          const SizedBox(width: AppSpacing.lg),
                        ],
                        AppButton(
                          label: Brand.primaryCta,
                          size: AppButtonSize.sm,
                          onPressed: () => context.go(AppRoutes.contact),
                        ),
                      ] else
                        Semantics(
                          button: true,
                          label: 'Open menu',
                          child: IconButton(
                            tooltip: 'Menu',
                            onPressed: () => _openMobileMenu(context),
                            icon: const Icon(Icons.menu_rounded),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    if (reduceMotion) return bar;

    return bar
        .animate()
        .fadeIn(duration: 500.ms, curve: AppCurves.enter)
        .moveY(begin: -8, end: 0, duration: 500.ms, curve: AppCurves.enter);
  }

  void _openMobileMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Semantics(
            scopesRoute: true,
            namesRoute: true,
            label: 'Navigation menu',
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final item in AppNav.primary)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.label,
                        style: AppTypography.headingSStyle.copyWith(fontSize: 22),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        context.go(item.path);
                      },
                    ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    label: Brand.primaryCta,
                    expand: true,
                    onPressed: () {
                      Navigator.pop(context);
                      context.go(AppRoutes.contact);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _GlassNavLink extends StatelessWidget {
  const _GlassNavLink({
    required this.label,
    required this.path,
    required this.selected,
  });

  final String label;
  final String path;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: HoverOpacity(
        onTap: () => context.go(path),
        child: Text(
          label,
          style: AppTypography.navLabel.copyWith(
            color: selected ? AppColors.textPrimary : AppColors.textSecondary,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
