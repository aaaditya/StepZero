import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../core/widgets/app_text_field.dart';

/// Contact feature entry — form foundation only.
class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.caption('CONTACT'),
          const SizedBox(height: AppSpacing.md),
          AppText.headingL('Contact'),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Form fields use AppTextField from the design system. '
            'Wire submission logic in features/contact/data later.',
            style: AppTypography.bodyStyle,
          ),
          const SizedBox(height: AppSpacing.xxl),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: const Column(
              children: [
                AppTextField(
                  label: 'Name',
                  hint: 'Your name',
                ),
                SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'Email',
                  hint: 'you@business.com',
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: AppSpacing.md),
                AppTextField(
                  label: 'Message',
                  hint: 'Tell us about your business',
                  maxLines: 5,
                  minLines: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
