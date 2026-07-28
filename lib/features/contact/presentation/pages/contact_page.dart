import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/analytics/analytics.dart';
import '../../../../core/analytics/analytics_providers.dart';
import '../../../../core/constants/app_layout.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/seo/page_meta.dart';
import '../../../../core/seo/seo_effect.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/external_link.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/app_text_field.dart';
import '../../../../core/widgets/reveal.dart';
import '../../../../core/widgets/section_header.dart';
import '../../../../shared/layout/page_body.dart';
import '../../domain/contact_submission.dart';
import '../providers/contact_providers.dart';

/// Production contact / discovery-call form.
class ContactPage extends ConsumerStatefulWidget {
  const ContactPage({super.key});

  @override
  ConsumerState<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends ConsumerState<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _company = TextEditingController();
  final _message = TextEditingController();
  final _honeypot = TextEditingController();

  ContactSubmitStatus _status = ContactSubmitStatus.idle;
  String? _error;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _company.dispose();
    _message.dispose();
    _honeypot.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) return;

    setState(() {
      _status = ContactSubmitStatus.submitting;
      _error = null;
    });

    final analytics = ref.read(analyticsProvider);
    await analytics.track(
      AnalyticsEvents.contactSubmit,
      properties: {'has_company': _company.text.trim().isNotEmpty},
    );

    final result = await ref.read(contactRepositoryProvider).submit(
          ContactSubmission(
            name: _name.text.trim(),
            email: _email.text.trim(),
            company: _company.text.trim().isEmpty ? null : _company.text.trim(),
            message: _message.text.trim(),
            honeypot: _honeypot.text,
          ),
        );

    if (!mounted) return;

    if (result.status == ContactSubmitStatus.success) {
      await analytics.track(AnalyticsEvents.contactSuccess);
      setState(() => _status = ContactSubmitStatus.success);
    } else {
      await analytics.track(
        AnalyticsEvents.contactError,
        properties: {'message': result.errorMessage ?? 'unknown'},
      );
      setState(() {
        _status = ContactSubmitStatus.error;
        _error = result.errorMessage;
      });
    }
  }

  void _reset() {
    _formKey.currentState?.reset();
    _name.clear();
    _email.clear();
    _company.clear();
    _message.clear();
    _honeypot.clear();
    setState(() {
      _status = ContactSubmitStatus.idle;
      _error = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SeoEffect(
      meta: const PageMeta(
        title: 'Contact · StepZero',
        description: 'Book a discovery call with StepZero. hello@stepzero.studio',
        path: AppRoutes.contact,
      ),
      child: SectionLandmark(
        label: 'Contact',
        child: PageBody(
          child: SectionContainer(
            maxWidth: 880,
            child: Responsive.isDesktop(context)
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(flex: 5, child: _ContactIntro()),
                      const SizedBox(width: AppSpacing.xxxl),
                      Expanded(flex: 6, child: _buildFormPanel()),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const _ContactIntro(),
                      const SizedBox(height: AppSpacing.xxxl),
                      _buildFormPanel(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormPanel() {
    if (_status == ContactSubmitStatus.success) {
      return _SuccessState(onReset: _reset);
    }

    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(
            eyebrow: 'Discovery',
            title: 'Tell us where you are.',
            subtitle:
                'We’ll reply within one business day with an honest next step — '
                'even if it isn’t us.',
          ),
          const SizedBox(height: AppSpacing.xxxl),
          AppTextField(
            controller: _name,
            label: 'Name',
            hint: 'Your name',
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
            validator: AppValidators.name,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _email,
            label: 'Email',
            hint: 'you@business.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            validator: AppValidators.email,
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _company,
            label: 'Business (optional)',
            hint: 'Studio, clinic, restaurant…',
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.organizationName],
          ),
          const SizedBox(height: AppSpacing.md),
          AppTextField(
            controller: _message,
            label: 'Message',
            hint: 'What are you trying to transform?',
            maxLines: 6,
            minLines: 4,
            maxLength: 2000,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            validator: AppValidators.message,
          ),
          // Honeypot — visually hidden, not in tab order for humans.
          Offstage(
            offstage: true,
            child: AppTextField(
              controller: _honeypot,
              label: 'Website',
              hint: 'Leave blank',
              validator: AppValidators.honeypot,
            ),
          ),
          if (_error != null) ...[
            const SizedBox(height: AppSpacing.md),
            _ErrorBanner(message: _error!),
          ],
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: _status == ContactSubmitStatus.submitting
                ? 'Sending…'
                : 'Book a discovery call',
            size: AppButtonSize.lg,
            expand: true,
            magnetic: true,
            pulse: true,
            isLoading: _status == ContactSubmitStatus.submitting,
            onPressed:
                _status == ContactSubmitStatus.submitting ? null : _submit,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Or email hello@stepzero.studio — no forms required.',
            style: AppTypography.captionStyle,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Center(
            child: TextButton(
              onPressed: () => ExternalLink.mailto(
                'hello@stepzero.studio',
                subject: 'Discovery call',
              ),
              child: const Text('Email us directly'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactIntro extends StatelessWidget {
  const _ContactIntro();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CONTACT',
          style: AppTypography.captionStyle.copyWith(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          'Start a conversation.',
          style: AppTypography.headingLStyle.copyWith(
            fontSize: Responsive.fluidFontSize(
              context,
              desktop: 48,
              tablet: 36,
              mobile: 28,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          'Discovery calls are diagnostic — we map identity, presence, systems, '
          'and growth, then recommend the honest next step.',
          style: AppTypography.bodyLargeStyle,
        ),
        const SizedBox(height: AppSpacing.xxl),
        const _InfoRow(
          icon: Icons.schedule_outlined,
          title: '30 minutes',
          body: 'Focused, no pitch theater.',
        ),
        const SizedBox(height: AppSpacing.md),
        const _InfoRow(
          icon: Icons.lock_outline,
          title: 'Confidential',
          body: 'Your business details stay private.',
        ),
        const SizedBox(height: AppSpacing.md),
        _InfoRow(
          icon: Icons.mail_outline,
          title: 'hello@stepzero.studio',
          body: 'Prefer email? We answer there too.',
          onTap: () => ExternalLink.mailto('hello@stepzero.studio'),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.title,
    required this.body,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String body;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final row = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: AppLayout.minTouchTarget,
          height: AppLayout.minTouchTarget,
          child: Icon(icon, color: AppColors.accent, size: 22),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(title, style: AppTypography.bodyStrong),
              Text(body, style: AppTypography.smallStyle),
            ],
          ),
        ),
      ],
    );

    if (onTap == null) return row;
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.mdAll,
      child: row,
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.success, size: 36),
            const SizedBox(height: AppSpacing.lg),
            Text('Message received.', style: AppTypography.headingSStyle),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'We’ll review your note and reply within one business day.',
              style: AppTypography.bodyLargeStyle,
            ),
            const SizedBox(height: AppSpacing.xxl),
            Wrap(
              spacing: AppSpacing.md,
              runSpacing: AppSpacing.sm,
              children: [
                AppButton(
                  label: 'Back home',
                  onPressed: () => context.go(AppRoutes.home),
                ),
                AppButton(
                  label: 'Send another',
                  variant: AppButtonVariant.secondary,
                  onPressed: onReset,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.08),
          borderRadius: AppRadius.mdAll,
          border: Border.all(color: AppColors.error.withValues(alpha: 0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: AppColors.error, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  message,
                  style: AppTypography.smallStyle.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
