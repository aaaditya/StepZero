import 'package:flutter/material.dart';

/// Maps catalog icon keys to Material icons (presentation-only).
abstract final class ContentIcons {
  static IconData resolve(String key) {
    switch (key) {
      case 'brush':
        return Icons.brush_outlined;
      case 'desktop':
        return Icons.desktop_windows_outlined;
      case 'bolt':
        return Icons.bolt_outlined;
      case 'insights':
        return Icons.insights_outlined;
      case 'restaurant':
        return Icons.restaurant;
      case 'cafe':
        return Icons.local_cafe_outlined;
      case 'salon':
        return Icons.content_cut;
      case 'clinic':
        return Icons.medical_services_outlined;
      case 'gym':
        return Icons.fitness_center;
      case 'retail':
        return Icons.storefront_outlined;
      case 'hotel':
        return Icons.hotel_outlined;
      case 'realestate':
        return Icons.home_work_outlined;
      default:
        return Icons.circle_outlined;
    }
  }

  static Color toneColor(int tone) => Color(tone);
}
