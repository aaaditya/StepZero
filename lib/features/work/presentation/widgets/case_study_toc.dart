import 'package:flutter/material.dart';

import '../../../../core/constants/curves.dart';
import '../../../../core/constants/durations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../domain/case_study.dart';

/// Linear/Stripe-style sticky table of contents.
class CaseStudyToc extends StatelessWidget {
  const CaseStudyToc({
    required this.activeId,
    required this.onSelect,
    super.key,
  });

  final String activeId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'On this page',
          style: AppTypography.captionStyle.copyWith(
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
            color: AppColors.textTertiary,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final entry in CaseStudy.toc)
          _TocLink(
            id: entry.$1,
            label: entry.$2,
            selected: activeId == entry.$1,
            onTap: () => onSelect(entry.$1),
          ),
      ],
    );
  }
}

class _TocLink extends StatefulWidget {
  const _TocLink({
    required this.id,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String id;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<_TocLink> createState() => _TocLinkState();
}

class _TocLinkState extends State<_TocLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final active = widget.selected || _hovered;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedContainer(
            duration: AppDurations.fast,
            curve: AppCurves.hover,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              borderRadius: AppRadius.smAll,
              color: widget.selected
                  ? AppColors.accentSubtle
                  : Colors.transparent,
              border: Border(
                left: BorderSide(
                  color: widget.selected ? AppColors.accent : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              widget.label,
              style: AppTypography.captionStyle.copyWith(
                color: active ? AppColors.textPrimary : AppColors.textSecondary,
                fontWeight: widget.selected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13,
                height: 1.35,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Compact mobile TOC as a dropdown-style expansion.
class CaseStudyMobileToc extends StatelessWidget {
  const CaseStudyMobileToc({
    required this.activeId,
    required this.onSelect,
    super.key,
  });

  final String activeId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final current = CaseStudy.toc.firstWhere(
      (e) => e.$1 == activeId,
      orElse: () => CaseStudy.toc.first,
    );

    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        childrenPadding: const EdgeInsets.only(bottom: AppSpacing.md),
        title: Text(
          'On this page · ${current.$2}',
          style: AppTypography.bodyStrong.copyWith(fontSize: 15),
        ),
        children: [
          CaseStudyToc(activeId: activeId, onSelect: onSelect),
        ],
      ),
    );
  }
}
