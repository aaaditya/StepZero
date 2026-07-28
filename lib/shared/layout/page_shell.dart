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

/// Site footer — large brand mark, utility nav, contact, newsletter.
class AppFooter extends StatefulWidget {
  const AppFooter({super.key});

  @override
  State<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends State<AppFooter> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: MaxWidthBox(
        maxWidth: 1200,
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.pageGutter(context),
          vertical: AppSpacing.section,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Brand.name,
              style: AppTypography.displayHero.copyWith(
                fontSize: Responsive.fluidFontSize(
                  context,
                  desktop: 72,
                  tablet: 56,
                  mobile: 40,
                ),
                fontWeight: FontWeight.w700,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              Brand.tagline,
              style: AppTypography.bodyLargeStyle,
            ),
            const SizedBox(height: AppSpacing.xxxl),
            if (isDesktop)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _FooterNav()),
                  Expanded(child: _FooterContact()),
                  Expanded(child: _FooterNewsletter(controller: _emailController)),
                ],
              )
            else ...[
              _FooterNav(),
              const SizedBox(height: AppSpacing.xxl),
              _FooterContact(),
              const SizedBox(height: AppSpacing.xxl),
              _FooterNewsletter(controller: _emailController),
            ],
            const SizedBox(height: AppSpacing.xxxl),
            const Divider(color: AppColors.border),
            const SizedBox(height: AppSpacing.xl),
            Responsive.isMobile(context)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '© ${DateTime.now().year} ${Brand.legalName}',
                        style: AppTypography.captionStyle,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const _SocialLinks(),
                    ],
                  )
                : Row(
                    children: [
                      Text(
                        '© ${DateTime.now().year} ${Brand.legalName}. All rights reserved.',
                        style: AppTypography.captionStyle,
                      ),
                      const Spacer(),
                      const _SocialLinks(),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class _FooterNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Navigate',
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final item in AppNav.primary) ...[
          HoverOpacity(
            onTap: () => context.go(item.path),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Text(
                item.label,
                style: AppTypography.bodyStyle.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class _FooterContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact',
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        HoverOpacity(
          onTap: () => context.go(AppRoutes.contact),
          child: Text(
            'hello@stepzero.studio',
            style: AppTypography.bodyStyle.copyWith(
              color: AppColors.textPrimary,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Book a discovery call',
          style: AppTypography.smallStyle,
        ),
      ],
    );
  }
}

class _FooterNewsletter extends StatelessWidget {
  const _FooterNewsletter({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Newsletter',
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Operator notes. No spam.',
          style: AppTypography.smallStyle,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: AppTypography.smallStyle.copyWith(
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'Email address',
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            AppButton(
              label: 'Join',
              size: AppButtonSize.sm,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialLinks extends StatelessWidget {
  const _SocialLinks();

  @override
  Widget build(BuildContext context) {
    const links = ['Instagram', 'LinkedIn', 'X'];
    return Wrap(
      spacing: AppSpacing.lg,
      children: [
        for (final link in links)
          HoverOpacity(
            onTap: () {},
            child: Text(
              link,
              style: AppTypography.captionStyle.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
