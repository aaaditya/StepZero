import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/content/domain/site_config.dart';
import '../../features/content/presentation/providers/content_providers.dart';
import '../animations/hover_effects.dart';
import '../constants/app_layout.dart';
import '../constants/curves.dart';
import '../constants/durations.dart';
import '../routing/routes.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_typography.dart';
import '../utils/responsive.dart';
import 'app_button.dart';
import 'app_container.dart';

/// Sticky glass navigation bar — driven by [SiteSettings] Navigation config.
class GlassAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const GlassAppBar({
    required this.location,
    this.scrolled = false,
    this.height = 72,
    this.maxWidth = AppLayout.heroMaxWidth,
    super.key,
  });

  final String location;
  final bool scrolled;
  final double height;
  final double maxWidth;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(siteSettingsProvider);
    final nav = settings.navigation.primary;
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
              alpha: scrolled ? 0.92 : 0.55,
            ),
            border: Border(
              bottom: BorderSide(
                color: AppColors.border.withValues(
                  alpha: scrolled ? 1 : 0.35,
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
            child: AnimatedContainer(
              duration: reduceMotion ? Duration.zero : AppDurations.fast,
              curve: AppCurves.hover,
              height: scrolled
                  ? AppLayout.navContentHeightScrolled
                  : AppLayout.navContentHeight,
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
                        label: '${settings.siteName} home',
                        child: HoverOpacity(
                          onTap: () => context.go(AppRoutes.home),
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minHeight: AppLayout.minTouchTarget,
                              minWidth: AppLayout.minTouchTarget,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                settings.siteName,
                                style: AppTypography.headingSStyle.copyWith(
                                  fontSize: 22,
                                  letterSpacing: -0.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      if (isDesktop) ...[
                        for (final item in nav) ...[
                          _GlassNavLink(
                            label: item.label,
                            path: item.path,
                            selected: _isSelected(location, item.path),
                          ),
                          const SizedBox(width: AppSpacing.xl),
                        ],
                        AppButton(
                          label: settings.primaryCtaLabel,
                          size: AppButtonSize.sm,
                          magnetic: true,
                          pulse: true,
                          onPressed: () =>
                              context.go(settings.primaryCtaPath),
                        ),
                      ] else
                        Semantics(
                          button: true,
                          label: 'Open menu',
                          child: IconButton(
                            tooltip: 'Menu',
                            constraints: const BoxConstraints(
                              minWidth: AppLayout.minTouchTarget,
                              minHeight: AppLayout.minTouchTarget,
                            ),
                            onPressed: () =>
                                _openMobileMenu(context, settings),
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

  static bool _isSelected(String location, String path) {
    if (path == AppRoutes.home) return location == path;
    return location == path || location.startsWith('$path/');
  }

  void _openMobileMenu(BuildContext context, SiteSettings settings) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final links = [
          ...settings.navigation.primary,
          ...settings.navigation.utility,
        ];
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
                  for (final item in links)
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
                    label: settings.primaryCtaLabel,
                    expand: true,
                    onPressed: () {
                      Navigator.pop(context);
                      context.go(settings.primaryCtaPath);
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
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: AppLayout.minTouchTarget,
            minWidth: AppLayout.minTouchTarget,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTypography.navLabel.copyWith(
                  color: selected
                      ? AppColors.textPrimary
                      : AppColors.textSecondary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              NavUnderline(active: selected),
            ],
          ),
        ),
      ),
    );
  }
}
