import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/analytics/analytics.dart';
import '../../core/analytics/analytics_providers.dart';
import '../../core/animations/hover_effects.dart';
import '../../core/constants/app_layout.dart';
import '../../core/routing/routes.dart';
import '../../core/seo/seo_controller.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/external_link.dart';
import '../../core/utils/responsive.dart';
import '../../core/utils/validators.dart';
import '../../core/widgets/app_button.dart';
import '../../core/widgets/app_container.dart';
import '../../core/widgets/app_text_field.dart';
import '../../core/widgets/glass_app_bar.dart';
import '../../core/widgets/lazy_section.dart';
import '../../core/widgets/reveal.dart';
import '../../features/content/domain/site_config.dart';
import '../../features/content/presentation/providers/content_providers.dart';

/// Persistent site chrome — sticky glass nav + smooth scroll body + footer.
class PageShell extends ConsumerStatefulWidget {
  const PageShell({
    required this.child,
    required this.location,
    super.key,
  });

  final Widget child;
  final String location;

  @override
  ConsumerState<PageShell> createState() => _PageShellState();
}

class _PageShellState extends ConsumerState<PageShell> {
  final _scrollController = ScrollController();
  final _mainContentKey = GlobalKey();
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _applySeoAndAnalytics());
  }

  @override
  void didUpdateWidget(covariant PageShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.location != widget.location) {
      _applySeoAndAnalytics();
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }
  }

  void _applySeoAndAnalytics() {
    SeoController.apply(SeoController.forPath(widget.location));
    ref.read(analyticsProvider).screen(
          widget.location,
          properties: {'path': widget.location},
        );
  }

  void _onScroll() {
    final next = _scrollController.offset > AppLayout.navElevateOffset;
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
                ContainedLayout(
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

/// Wraps main content so the scroll view always has a box adapter sliver.
class ContainedLayout extends StatelessWidget {
  const ContainedLayout({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: child);
  }
}

/// Premium colophon footer — driven by Footer + Settings config.
class AppFooter extends ConsumerWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          maxWidth: AppLayout.pageMaxWidth,
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
                        const Expanded(child: _FooterNewsletter()),
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
                    const _FooterNewsletter(),
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
                          Flexible(
                            child: Text(
                              '© ${DateTime.now().year} ${settings.legalName}. All rights reserved.',
                              style: AppTypography.captionStyle,
                            ),
                          ),
                          const SizedBox(width: AppSpacing.lg),
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: AppLayout.minTouchTarget,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
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
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                minHeight: AppLayout.minTouchTarget,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  email,
                  style: AppTypography.bodyStyle.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
        Text(blurb, style: AppTypography.smallStyle),
      ],
    );
  }
}

class _FooterNewsletter extends ConsumerStatefulWidget {
  const _FooterNewsletter();

  @override
  ConsumerState<_FooterNewsletter> createState() => _FooterNewsletterState();
}

class _FooterNewsletterState extends ConsumerState<_FooterNewsletter> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _honeypot = TextEditingController();
  bool _submitted = false;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _controller.dispose();
    _honeypot.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (AppValidators.honeypot(_honeypot.text) != null) {
      setState(() => _submitted = true);
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    await ref.read(analyticsProvider).track(
          AnalyticsEvents.newsletterSubmit,
          properties: {'source': 'footer'},
        );

    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (!mounted) return;
    setState(() {
      _loading = false;
      _submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final footer = ref.watch(siteSettingsProvider).footer;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          footer.newsletterTitle,
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(footer.newsletterBlurb, style: AppTypography.smallStyle),
        const SizedBox(height: AppSpacing.md),
        if (_submitted)
          Text(
            'You’re on the list. We’ll keep it rare and useful.',
            style: AppTypography.smallStyle.copyWith(color: AppColors.success),
          )
        else
          Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Offstage(
                  offstage: true,
                  child: TextFormField(
                    controller: _honeypot,
                    validator: AppValidators.honeypot,
                    decoration: const InputDecoration(labelText: 'Company url'),
                  ),
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final stacked = constraints.maxWidth < 280;
                    final field = AppTextField(
                      controller: _controller,
                      label: 'Email',
                      hint: 'you@company.com',
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      validator: AppValidators.email,
                      onSubmitted: (_) => _submit(),
                    );
                    final button = AppButton(
                      label: _loading ? '…' : 'Join',
                      size: AppButtonSize.sm,
                      isLoading: _loading,
                      onPressed: _loading ? null : _submit,
                    );
                    if (stacked) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          field,
                          const SizedBox(height: AppSpacing.sm),
                          button,
                        ],
                      );
                    }
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(child: field),
                        const SizedBox(width: AppSpacing.sm),
                        button,
                      ],
                    );
                  },
                ),
                if (_error != null) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    _error!,
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  }
}

class _SocialLinks extends ConsumerWidget {
  const _SocialLinks({required this.socials});

  final List<SocialLink> socials;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Wrap(
      spacing: AppSpacing.md,
      runSpacing: AppSpacing.sm,
      children: [
        for (final link in socials)
          Semantics(
            link: true,
            label: '${link.label} (opens in new tab)',
            child: HoverOpacity(
              onTap: () async {
                await ref.read(analyticsProvider).track(
                      AnalyticsEvents.outboundLink,
                      properties: {
                        'label': link.label,
                        'url': link.url,
                      },
                    );
                await ExternalLink.open(link.url);
              },
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  minHeight: AppLayout.minTouchTarget,
                  minWidth: AppLayout.minTouchTarget,
                ),
                child: Align(
                  child: Text(
                    link.label,
                    style: AppTypography.captionStyle.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
