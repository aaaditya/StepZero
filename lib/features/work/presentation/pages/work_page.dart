import 'package:flutter/material.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/app_text.dart';
import '../../../../shared/layout/page_body.dart';

/// Work / case studies feature entry.
class WorkPage extends StatelessWidget {
  const WorkPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageBody(
      child: SectionContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText.caption('WORK'),
            const SizedBox(height: AppSpacing.md),
            AppText.headingL('Work'),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Case study grid stub. Data layer belongs in features/work/data.',
              style: AppTypography.bodyStyle,
            ),
          ],
        ),
      ),
    );
  }
}
