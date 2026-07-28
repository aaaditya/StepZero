import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_typography.dart';
import '../../../../core/widgets/animated_counter.dart';
import '../../../../core/widgets/floating_glass_card.dart';

/// Floating glassmorphism "business operating system" composition.
///
/// Product metaphor: StepZero doesn't sell a single deliverable —
/// it installs a growth stack. Cards overlap with depth to feel
/// alive, not like a flat icon grid.
class HeroDashboard extends StatelessWidget {
  const HeroDashboard({
    this.compact = false,
    super.key,
  });

  /// Tighter layout for tablet / narrow widths.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final w = compact ? 420.0 : 520.0;
    final h = compact ? 440.0 : 520.0;

    return SizedBox(
      width: w,
      height: h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Depth plate — soft ground shadow for the cluster
          Positioned(
            left: w * 0.12,
            right: w * 0.12,
            bottom: 8,
            height: 48,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: AppRadius.xxlAll,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.accent.withValues(alpha: 0.12),
                    blurRadius: 48,
                    spreadRadius: 8,
                  ),
                ],
              ),
            ),
          ),

          // Website preview — largest, back-left anchor
          Positioned(
            left: 0,
            top: compact ? 36 : 48,
            child: FloatingGlassCard(
              width: compact ? 200 : 240,
              floatDelay: const Duration(milliseconds: 0),
              floatOffset: 7,
              floatDuration: const Duration(milliseconds: 3400),
              rotateAmplitude: 0.01,
              child: const _WebsitePreviewCard(),
            ),
          ),

          // Google reviews — top right
          Positioned(
            right: compact ? 8 : 16,
            top: 0,
            child: FloatingGlassCard(
              width: compact ? 150 : 168,
              floatDelay: const Duration(milliseconds: 400),
              floatOffset: 10,
              floatDuration: const Duration(milliseconds: 3800),
              rotateAmplitude: 0.014,
              child: const _ReviewsCard(),
            ),
          ),

          // Analytics spike
          Positioned(
            right: compact ? 0 : 8,
            top: compact ? 110 : 130,
            child: FloatingGlassCard(
              width: compact ? 148 : 164,
              floatDelay: const Duration(milliseconds: 700),
              floatOffset: 9,
              floatDuration: const Duration(milliseconds: 3000),
              rotateAmplitude: -0.012,
              child: const _MetricCard(
                label: 'Analytics',
                value: '+248%',
                caption: 'Qualified traffic',
                positive: true,
              ),
            ),
          ),

          // QR Menu
          Positioned(
            left: compact ? 16 : 28,
            top: compact ? 210 : 250,
            child: FloatingGlassCard(
              width: compact ? 112 : 124,
              padding: const EdgeInsets.all(14),
              floatDelay: const Duration(milliseconds: 200),
              floatOffset: 6,
              floatDuration: const Duration(milliseconds: 3600),
              child: const _QrMenuCard(),
            ),
          ),

          // AI Chatbot
          Positioned(
            left: compact ? 140 : 170,
            top: compact ? 200 : 235,
            child: FloatingGlassCard(
              width: compact ? 168 : 188,
              floatDelay: const Duration(milliseconds: 550),
              floatOffset: 11,
              floatDuration: const Duration(milliseconds: 4100),
              rotateAmplitude: 0.01,
              child: const _ChatbotCard(),
            ),
          ),

          // WhatsApp automation
          Positioned(
            right: compact ? 20 : 36,
            bottom: compact ? 88 : 100,
            child: FloatingGlassCard(
              width: compact ? 170 : 190,
              floatDelay: const Duration(milliseconds: 900),
              floatOffset: 8,
              floatDuration: const Duration(milliseconds: 3300),
              rotateAmplitude: -0.01,
              child: const _WhatsAppCard(),
            ),
          ),

          // Online orders
          Positioned(
            left: compact ? 8 : 12,
            bottom: compact ? 24 : 28,
            child: FloatingGlassCard(
              width: compact ? 148 : 160,
              floatDelay: const Duration(milliseconds: 300),
              floatOffset: 7,
              floatDuration: const Duration(milliseconds: 2900),
              child: const _MetricCard(
                label: 'Online Orders',
                value: '+187%',
                caption: 'Last 90 days',
                positive: true,
              ),
            ),
          ),

          // Revenue growth — front accent
          Positioned(
            right: compact ? 40 : 56,
            bottom: 8,
            child: FloatingGlassCard(
              width: compact ? 150 : 168,
              opacity: 0.82,
              floatDelay: const Duration(milliseconds: 1100),
              floatOffset: 12,
              floatDuration: const Duration(milliseconds: 3500),
              rotateAmplitude: 0.015,
              child: const _RevenueCard(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Card interiors ───────────────────────────────────────────────

class _CardLabel extends StatelessWidget {
  const _CardLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppTypography.captionStyle.copyWith(
        color: AppColors.textTertiary,
        fontWeight: FontWeight.w500,
        fontSize: 11,
        letterSpacing: 0.2,
      ),
    );
  }
}

class _WebsitePreviewCard extends StatelessWidget {
  const _WebsitePreviewCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            const _Dot(color: Color(0xFFFF5F57)),
            const SizedBox(width: 5),
            const _Dot(color: Color(0xFFFEBC2E)),
            const SizedBox(width: 5),
            const _Dot(color: Color(0xFF28C840)),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        const _CardLabel('Website Preview'),
        const SizedBox(height: AppSpacing.xs),
        Container(
          height: 88,
          decoration: BoxDecoration(
            borderRadius: AppRadius.smAll,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.accentSubtle,
                AppColors.surfaceMuted,
                AppColors.accent.withValues(alpha: 0.08),
              ],
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 72,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 120,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 56,
                  height: 18,
                  decoration: BoxDecoration(
                    color: AppColors.accent,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 7,
      height: 7,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _ReviewsCard extends StatelessWidget {
  const _ReviewsCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _CardLabel('Google Reviews'),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '★★★★★',
          style: AppTypography.headingSStyle.copyWith(
            fontSize: 18,
            color: const Color(0xFFFBBF24),
            letterSpacing: 1.5,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '4.9 · Trust signal',
          style: AppTypography.captionStyle.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
    required this.caption,
    required this.positive,
  });

  final String label;
  final String value;
  final String caption;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _CardLabel(label),
        const SizedBox(height: AppSpacing.xs),
        AnimatedCounter.fromMetricString(
          value,
          style: AppTypography.headingSStyle.copyWith(
            fontSize: 26,
            color: positive ? AppColors.success : AppColors.textPrimary,
            letterSpacing: -0.6,
          ),
          semanticLabel: '$label $value',
        ),
        const SizedBox(height: 2),
        Text(
          caption,
          style: AppTypography.captionStyle.copyWith(
            color: AppColors.textTertiary,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        ExcludeSemantics(
          child: CustomPaint(
            size: const Size(120, 28),
            painter: _SparklinePainter(
              color: positive ? AppColors.success : AppColors.accent,
            ),
          ),
        ),
      ],
    );
  }
}

class _SparklinePainter extends CustomPainter {
  _SparklinePainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.75)
      ..cubicTo(
        size.width * 0.2,
        size.height * 0.7,
        size.width * 0.3,
        size.height * 0.9,
        size.width * 0.45,
        size.height * 0.45,
      )
      ..cubicTo(
        size.width * 0.6,
        size.height * 0.1,
        size.width * 0.75,
        size.height * 0.35,
        size.width,
        size.height * 0.15,
      );

    final line = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final fill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          color.withValues(alpha: 0.22),
          color.withValues(alpha: 0),
        ],
      ).createShader(Offset.zero & size);

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(fillPath, fill);
    canvas.drawPath(path, line);
  }

  @override
  bool shouldRepaint(covariant _SparklinePainter oldDelegate) =>
      oldDelegate.color != color;
}

class _QrMenuCard extends StatelessWidget {
  const _QrMenuCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _CardLabel('QR Menu'),
        const SizedBox(height: AppSpacing.xs),
        Container(
          width: 72,
          height: 72,
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.surfaceMuted,
            borderRadius: AppRadius.smAll,
          ),
          child: ExcludeSemantics(
            child: CustomPaint(painter: _QrPainter()),
          ),
        ),
      ],
    );
  }
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppColors.textPrimary;
    const cells = 7;
    final cell = size.width / cells;
    const pattern = <List<int>>[
      [1, 1, 1, 0, 1, 1, 1],
      [1, 0, 1, 0, 1, 0, 1],
      [1, 1, 1, 0, 1, 1, 1],
      [0, 0, 0, 1, 0, 0, 0],
      [1, 1, 0, 1, 0, 1, 1],
      [1, 0, 1, 0, 1, 0, 1],
      [1, 1, 1, 0, 1, 1, 0],
    ];
    for (var y = 0; y < cells; y++) {
      for (var x = 0; x < cells; x++) {
        if (pattern[y][x] == 1) {
          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromLTWH(x * cell, y * cell, cell * 0.85, cell * 0.85),
              const Radius.circular(1.5),
            ),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChatbotCard extends StatelessWidget {
  const _ChatbotCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              width: 22,
              height: 22,
              decoration: const BoxDecoration(
                color: AppColors.accentSubtle,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                size: 12,
                color: AppColors.accent,
              ),
            ),
            const SizedBox(width: 8),
            const _CardLabel('AI Chatbot'),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        const _Bubble(
          text: 'Book a table for 2?',
          alignEnd: false,
        ),
        const SizedBox(height: 6),
        const _Bubble(
          text: 'Done — 7:30 tonight.',
          alignEnd: true,
        ),
      ],
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.text, required this.alignEnd});

  final String text;
  final bool alignEnd;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignEnd ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: alignEnd ? AppColors.accent : AppColors.surfaceMuted,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: Radius.circular(alignEnd ? 12 : 4),
            bottomRight: Radius.circular(alignEnd ? 4 : 12),
          ),
        ),
        child: Text(
          text,
          style: AppTypography.captionStyle.copyWith(
            color: alignEnd ? AppColors.textOnAccent : AppColors.textPrimary,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _WhatsAppCard extends StatelessWidget {
  const _WhatsAppCard();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: const BoxDecoration(
            color: Color(0xFFDCF8C6),
            borderRadius: AppRadius.smAll,
          ),
          child: const Icon(
            Icons.chat_bubble_rounded,
            size: 18,
            color: Color(0xFF128C7E),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const _CardLabel('WhatsApp Automation'),
              const SizedBox(height: 2),
              Text(
                'Replies in under 30s',
                style: AppTypography.captionStyle.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RevenueCard extends StatelessWidget {
  const _RevenueCard();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const _CardLabel('Revenue Growth'),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Compounding',
          style: AppTypography.bodyStrong.copyWith(fontSize: 15),
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: const LinearProgressIndicator(
            value: 0.78,
            minHeight: 6,
            backgroundColor: AppColors.surfaceMuted,
            color: AppColors.accent,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Brand → System → Scale',
          style: AppTypography.captionStyle.copyWith(
            color: AppColors.textTertiary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }
}
