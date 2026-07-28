import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/app_text.dart';

/// Services feature entry — strategy, branding, websites, AI, growth.
class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.caption('SERVICES'),
          const SizedBox(height: AppSpacing.md),
          AppText.headingL('Services'),
          const SizedBox(height: AppSpacing.lg),
          Text(
            'Service architecture stub. Add domain models and section '
            'widgets under features/services without touching core.',
            style: AppTypography.bodyStyle,
          ),
        ],
      ),
    );
  }
}
