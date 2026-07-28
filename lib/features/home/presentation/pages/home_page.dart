import 'package:flutter/material.dart';

import '../../../../core/constants/brand.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/app_text.dart';

/// Home feature entry — content sections land here in a later pass.
///
/// Intentionally minimal: proves routing, shell, typography, and spacing
/// without designing marketing sections yet.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.caption('FOUNDATION'),
          const SizedBox(height: AppSpacing.md),
          AppText.hero(Brand.name),
          const SizedBox(height: AppSpacing.lg),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              Brand.tagline,
              style: AppTypography.bodyLargeStyle,
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          const Divider(color: AppColors.border),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Page sections will be composed here. '
            'Design system, routing, and layout chrome are ready.',
            style: AppTypography.bodyStyle,
          ),
        ],
      ),
    );
  }
}
