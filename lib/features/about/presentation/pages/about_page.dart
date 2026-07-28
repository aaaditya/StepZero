import 'package:flutter/material.dart';

import '../../../../core/constants/brand.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/app_text.dart';

/// About feature entry — studio story and philosophy.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.caption('ABOUT'),
          const SizedBox(height: AppSpacing.md),
          AppText.headingL('About'),
          const SizedBox(height: AppSpacing.lg),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Text(
              Brand.mission,
              style: AppTypography.bodyLargeStyle,
            ),
          ),
        ],
      ),
    );
  }
}
