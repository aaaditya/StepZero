import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/utils/responsive.dart';
import '../../../../core/widgets/reveal.dart';
import '../../domain/models.dart';
import '../providers/content_providers.dart';
import '../widgets/content_page_scaffold.dart';

class TeamPage extends ConsumerWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final members = ref.watch(teamProvider);
    final columns = Responsive.isDesktop(context)
        ? 3
        : Responsive.isTablet(context)
            ? 2
            : 1;

    return ContentPageScaffold(
      landmark: 'Team',
      eyebrow: 'Team',
      title: 'The people behind the craft.',
      subtitle:
          'A small studio. Senior operators. No junior relay for your brand.',
      ctaLabel: 'Work with us',
      child: LayoutBuilder(
        builder: (context, constraints) {
          const gap = AppSpacing.lg;
          final width = columns == 1
              ? constraints.maxWidth
              : (constraints.maxWidth - gap * (columns - 1)) / columns;
          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (var i = 0; i < members.length; i++)
                SizedBox(
                  width: width,
                  child: Reveal(
                    delay: Duration(milliseconds: 80 * i),
                    child: _MemberCard(member: members[i]),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member});

  final TeamMember member;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.xlAll,
        border: Border.all(color: AppColors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: AppRadius.lgAll,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(member.tone),
                      Color(member.tone).withValues(alpha: 0.5),
                    ],
                  ),
                ),
                child: Center(
                  child: Text(
                    member.name
                        .split(' ')
                        .map((p) => p.isNotEmpty ? p[0] : '')
                        .take(2)
                        .join(),
                    style: AppTypography.headingLStyle.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(member.name, style: AppTypography.headingSStyle),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              member.role,
              style: AppTypography.captionStyle.copyWith(
                color: AppColors.accent,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(member.bio, style: AppTypography.smallStyle.copyWith(height: 1.5)),
            if (member.focus.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.md),
              Wrap(
                spacing: AppSpacing.xs,
                runSpacing: AppSpacing.xs,
                children: [
                  for (final f in member.focus)
                    Text(
                      f,
                      style: AppTypography.captionStyle.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
