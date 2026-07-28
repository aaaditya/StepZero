import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/app_container.dart';
import '../../../../core/widgets/reveal.dart';

/// Spine between hero and method — three POV statements, no decoration.
class TrustConvictionStrip extends StatelessWidget {
  const TrustConvictionStrip({super.key});

  static const _lines = <String>[
    'We don’t sell websites.',
    'Brand before traffic.',
    'Limited projects per quarter.',
  ];

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SectionLandmark(
      label: 'Convictions',
      header: false,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.border),
            bottom: BorderSide(color: AppColors.border),
          ),
        ),
        child: MaxWidthBox(
          maxWidth: 1100,
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.pageGutter(context),
            vertical: isDesktop ? AppSpacing.xxxl : AppSpacing.xxl,
          ),
          child: Reveal(
            child: isDesktop
                ? Row(
                    children: [
                      for (var i = 0; i < _lines.length; i++) ...[
                        if (i > 0)
                          Container(
                            width: 1,
                            height: 48,
                            margin: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.xl,
                            ),
                            color: AppColors.border,
                          ),
                        Expanded(
                          child: Text(
                            _lines[i],
                            textAlign: TextAlign.center,
                            style: AppTypography.bodyStrong.copyWith(
                              fontSize: 20,
                              height: 1.35,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ),
                      ],
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < _lines.length; i++) ...[
                        if (i > 0) ...[
                          const SizedBox(height: AppSpacing.lg),
                          const Divider(color: AppColors.border, height: 1),
                          const SizedBox(height: AppSpacing.lg),
                        ],
                        Text(
                          _lines[i],
                          style: AppTypography.bodyStrong.copyWith(
                            fontSize: 18,
                            height: 1.35,
                            letterSpacing: -0.2,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
