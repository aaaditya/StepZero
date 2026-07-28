import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../../core/animations/hover_effects.dart';
import '../../core/constants/brand.dart';
import '../../core/constants/curves.dart';
import '../../core/routing/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_container.dart';

/// Persistent site chrome — overlay nav + scrollable body + footer.
///
/// Nav floats above the hero so marketing sections can claim true 100vh.
class PageShell extends StatelessWidget {
  const PageShell({
    required this.child,
    required this.location,
    super.key,
  });

  final Widget child;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: child),
              const SliverToBoxAdapter(child: AppFooter()),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppNavBar(location: location)
                .animate()
                .fadeIn(duration: 500.ms, curve: AppCurves.enter)
                .moveY(
                  begin: -8,
                  end: 0,
                  duration: 500.ms,
                  curve: AppCurves.enter,
                ),
          ),
        ],
      ),
    );
  }
}

/// Top navigation — desktop links, mobile menu trigger.
class AppNavBar extends StatelessWidget {
  const AppNavBar({
    required this.location,
    super.key,
  });

  final String location;

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.background.withValues(alpha: 0.78),
            border: const Border(
              bottom: BorderSide(color: AppColors.border),
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: SizedBox(
              height: 72,
              child: MaxWidthBox(
                maxWidth: 1440,
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.pageGutter(context),
                ),
                child: Row(
                  children: [
                    HoverOpacity(
                      onTap: () => context.go(AppRoutes.home),
                      child: Text(
                        Brand.name,
                        style: AppTypography.headingSStyle.copyWith(
                          fontSize: 22,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (isDesktop) ...[
                      for (final item in AppNav.primary) ...[
                        _NavLink(
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
                      IconButton(
                        tooltip: 'Menu',
                        onPressed: () => _openMobileMenu(context),
                        icon: const Icon(Icons.menu_rounded),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
        );
      },
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({
    required this.label,
    required this.path,
    required this.selected,
  });

  final String label;
  final String path;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return HoverOpacity(
      onTap: () => context.go(path),
      child: Text(
        label,
        style: AppTypography.navLabel.copyWith(
          color: selected ? AppColors.textPrimary : AppColors.textSecondary,
          fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
        ),
      ),
    );
  }
}

/// Site footer foundation — expand with columns when content is ready.
class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
        color: AppColors.surface,
      ),
      child: MaxWidthBox(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pageGutter(context),
          vertical: AppSpacing.xxl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Brand.name,
              style: AppTypography.headingSStyle.copyWith(fontSize: 20),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              Brand.tagline,
              style: AppTypography.smallStyle,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text(
              '© ${DateTime.now().year} ${Brand.legalName}. All rights reserved.',
              style: AppTypography.captionStyle,
            ),
          ],
        ),
      ),
    );
  }
}
