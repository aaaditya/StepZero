import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/animations/hover_effects.dart';
import '../../core/constants/brand.dart';
import '../../core/routing/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/glass_app_bar.dart';
import '../../core/widgets/reveal.dart';

/// Persistent site chrome — sticky glass nav + smooth scroll body + footer.
class PageShell extends StatefulWidget {
  const PageShell({
    required this.child,
    required this.location,
    super.key,
  });

  final Widget child;
  final String location;

  @override
  State<PageShell> createState() => _PageShellState();
}

class _PageShellState extends State<PageShell> {
  final _scrollController = ScrollController();
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final next = _scrollController.offset > 12;
    if (next != _scrolled) {
      setState(() => _scrolled = next);
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(child: widget.child),
              const SliverToBoxAdapter(child: AppFooter()),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GlassAppBar(
              location: widget.location,
              scrolled: _scrolled,
            ),
          ),
        ],
      ),
    );
  }
}

/// Premium colophon footer — brand gravity + utility.
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

    return SectionLandmark(
      label: 'Footer',
      header: false,
      child: DecoratedBox(
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
          child: Reveal(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Semantics(
                  header: true,
                  child: Text(
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
                      const Expanded(child: _FooterNav()),
                      const Expanded(child: _FooterContact()),
                      Expanded(
                        child: _FooterNewsletter(controller: _emailController),
                      ),
                    ],
                  )
                else ...[
                  const _FooterNav(),
                  const SizedBox(height: AppSpacing.xxl),
                  const _FooterContact(),
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
        ),
      ),
    );
  }
}

class _FooterNav extends StatelessWidget {
  const _FooterNav();

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
          Semantics(
            button: true,
            label: item.label,
            child: HoverOpacity(
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
          ),
        ],
      ],
    );
  }
}

class _FooterContact extends StatelessWidget {
  const _FooterContact();

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
        Semantics(
          link: true,
          label: 'Email hello@stepzero.studio',
          child: HoverOpacity(
            onTap: () => context.go(AppRoutes.contact),
            child: Text(
              'hello@stepzero.studio',
              style: AppTypography.bodyStyle.copyWith(
                color: AppColors.textPrimary,
                fontSize: 16,
              ),
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
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: AppTextField(
                controller: controller,
                label: 'Email',
                hint: 'Email address',
                keyboardType: TextInputType.emailAddress,
                autofillHints: const [AutofillHints.email],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: AppButton(
                label: 'Join',
                size: AppButtonSize.sm,
                onPressed: () {},
              ),
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
          Semantics(
            link: true,
            label: link,
            child: HoverOpacity(
              onTap: () {},
              child: Text(
                link,
                style: AppTypography.captionStyle.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
