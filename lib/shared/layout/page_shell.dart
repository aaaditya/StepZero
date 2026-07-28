import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/animations/hover_effects.dart';
import '../../core/routing/routes.dart';
import '../../core/seo/seo_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/responsive.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/glass_app_bar.dart';
import '../../core/widgets/lazy_section.dart';
import '../../core/widgets/reveal.dart';
import '../../features/content/domain/site_config.dart';
import '../../features/content/presentation/providers/content_providers.dart';

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
  final _mainContentKey = GlobalKey();
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _applySeo();
  }

  @override
  void didUpdateWidget(covariant PageShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      _applySeo();
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }
  }

  void _applySeo() {
    SeoController.apply(SeoController.forPath(widget.location));
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
    return ShellScroll(
      controller: _scrollController,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          children: [
            CustomScrollView(
              key: _mainContentKey,
              controller: _scrollController,
              primary: false,
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              slivers: [
                SliverToBoxAdapter(
                  child: Semantics(
                    container: true,
                    explicitChildNodes: true,
                    label: 'Main content',
                    child: widget.child,
                  ),
                ),
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
      ),
    );
  }
}

/// Premium colophon footer — driven by Footer + Settings config.
class AppFooter extends ConsumerStatefulWidget {
  const AppFooter({super.key});

  @override
  ConsumerState<AppFooter> createState() => _AppFooterState();
}

class _AppFooterState extends ConsumerState<AppFooter> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(siteSettingsProvider);
    final footer = settings.footer;
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
                    settings.siteName,
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
                  settings.tagline,
                  style: AppTypography.bodyLargeStyle,
                ),
                const SizedBox(height: AppSpacing.xxxl),
                if (isDesktop)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (final column in footer.columns)
                        Expanded(child: _FooterColumnView(column: column)),
                      Expanded(
                        child: _FooterContact(
                          email: settings.contactEmail,
                          blurb: footer.contactBlurb,
                        ),
                      ),
                      if (footer.showNewsletter)
                        Expanded(
                          child: _FooterNewsletter(
                            controller: _emailController,
                            title: footer.newsletterTitle,
                            blurb: footer.newsletterBlurb,
                          ),
                        ),
                    ],
                  )
                else ...[
                  for (final column in footer.columns) ...[
                    _FooterColumnView(column: column),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                  _FooterContact(
                    email: settings.contactEmail,
                    blurb: footer.contactBlurb,
                  ),
                  if (footer.showNewsletter) ...[
                    const SizedBox(height: AppSpacing.xxl),
                    _FooterNewsletter(
                      controller: _emailController,
                      title: footer.newsletterTitle,
                      blurb: footer.newsletterBlurb,
                    ),
                  ],
                ],
                const SizedBox(height: AppSpacing.xxxl),
                const Divider(color: AppColors.border),
                const SizedBox(height: AppSpacing.xl),
                Responsive.isMobile(context)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '© ${DateTime.now().year} ${settings.legalName}',
                            style: AppTypography.captionStyle,
                          ),
                          const SizedBox(height: AppSpacing.md),
                          _SocialLinks(socials: footer.socials),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            '© ${DateTime.now().year} ${settings.legalName}. All rights reserved.',
                            style: AppTypography.captionStyle,
                          ),
                          const Spacer(),
                          _SocialLinks(socials: footer.socials),
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

class _FooterColumnView extends StatelessWidget {
  const _FooterColumnView({required this.column});

  final FooterColumn column;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          column.title,
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final item in column.links) ...[
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
  const _FooterContact({
    required this.email,
    required this.blurb,
  });

  final String email;
  final String blurb;

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
          label: 'Email $email',
          child: HoverOpacity(
            onTap: () => context.go(AppRoutes.contact),
            child: Text(
              email,
              style: AppTypography.bodyStyle.copyWith(
                color: AppColors.textPrimary,
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(blurb, style: AppTypography.smallStyle),
      ],
    );
  }
}

class _FooterNewsletter extends StatelessWidget {
  const _FooterNewsletter({
    required this.controller,
    required this.title,
    required this.blurb,
  });

  final TextEditingController controller;
  final String title;
  final String blurb;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(blurb, style: AppTypography.smallStyle),
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
  const _SocialLinks({required this.socials});

  final List<SocialLink> socials;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.lg,
      children: [
        for (final link in socials)
          Semantics(
            link: true,
            label: link.label,
            child: HoverOpacity(
              onTap: () {},
              child: Text(
                link.label,
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
