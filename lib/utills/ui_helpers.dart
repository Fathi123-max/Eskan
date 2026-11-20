import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'ui_tokens.dart';

/// Small UI helpers used by the refreshed components.
///
/// These are intentionally boring: formatting, directional padding, and a
/// couple of shared widget builders. The point is to stop repeating the same
/// choices in every card and state widget.

/// Returns a padding that respects RTL direction for horizontal spacing.
EdgeInsetsDirectional paddingDirectional({
  double start = Space.xs,
  double end = Space.xs,
  double top = 0,
  double bottom = 0,
}) {
  return EdgeInsetsDirectional(
    start: start,
    end: end,
    top: top,
    bottom: bottom,
  );
}

/// A fade wrapper that respects the platform reduced-motion setting.
///
/// Used only for the few deliberate entrances we keep in the refreshed UI.
/// If the platform asks for reduced motion, the child is shown immediately.
Widget reducedMotionFade({
  required Widget child,
  required BuildContext context,
  Duration duration = const Duration(milliseconds: 350),
  required bool show,
}) {
  if (show && Motion.prefersReducedMotion(context)) {
    return child;
  }
  return AnimatedOpacity(
    duration: duration,
    curve: Curves.easeOut,
    opacity: show ? 1.0 : 0.0,
    child: show ? child : const SizedBox.shrink(),
  );
}

/// Format a numeric price value as an Arabic-locale price string.
///
/// Keeps the price readable and consistent across cards and detail screens.
String formatPrice(String? value) {
  if (value == null || value.trim().isEmpty) {
    return '-';
  }
  final trimmed = value.trim();
  final numeric = int.tryParse(trimmed) ?? double.tryParse(trimmed);
  if (numeric == null) {
    return trimmed;
  }
  return NumberFormat.currency(
    locale: 'ar_EG',
    symbol: 'ج.م',
    decimalDigits: numeric == numeric.roundToDouble() ? 0 : 2,
  ).format(numeric);
}

/// Format a size/area value with an Arabic metric unit.
String formatMetric(String? value, {String unit = 'م²'}) {
  if (value == null || value.trim().isEmpty) {
    return '-';
  }
  final trimmed = value.trim();
  if (trimmed.contains(RegExp(r'[-+]?\d'))) {
    final numeric = double.tryParse(trimmed);
    if (numeric != null) {
      return '${formatNumber(numeric)} $unit';
    }
  }
  return '$trimmed $unit';
}

/// Format a plain number for Arabic-locale display (tabular when possible).
String formatNumber(double value) {
  return NumberFormat.decimalPatternDigits(locale: 'ar_EG', decimalDigits: 0)
      .format(value);
}

/// Build a spec chip row item for a property card.
///
/// Keeps the spec label style and spacing consistent across cards.
Widget specChip({
  required IconData icon,
  required String label,
  Color? iconColor,
  Color? labelColor,
}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        icon,
        color: iconColor ?? Accent.primary,
        size: 14,
      ),
      const SizedBox(width: Space.xxs),
      Text(
        label,
        style: Type.metadataStyle(
          color: labelColor ?? Accent.primary,
        ),
      ),
    ],
  );
}

/// A small, tappable favorite button placed over a card image.
///
/// Uses a real minimum touch target and a clear selected/non-selected visual
/// without being visually loud.
class FavoriteChip extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onPressed;
  final String? accessibilityLabel;

  const FavoriteChip({
    super.key,
    required this.isFavorite,
    required this.onPressed,
    this.accessibilityLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: accessibilityLabel ??
          (isFavorite ? 'إزالة من المفضلة' : 'أضف للمفضلة'),
      button: true,
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: Touch.minTarget,
          minHeight: Touch.minTarget,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            customBrightness: Brightness.light,
            child: Container(
              padding: const EdgeInsets.all(Space.xs),
              decoration: BoxDecoration(
                color: isFavorite
                    ? Accent.warm.withOpacity(0.14)
                    : Colors.white.withOpacity(0.86),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isFavorite ? Icons.favorite_rounded : Icons.favorite_outline,
                color: isFavorite ? Accent.warm : Accent.primary,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A simple horizontal divider that uses the hairline token.
class HairlineDivider extends StatelessWidget {
  final EdgeInsetsDirectional padding;

  const HairlineDivider({super.key, EdgeInsetsDirectional? padding})
      : padding = padding ?? const EdgeInsetsDirectional.only(top: Space.xxs));

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      height: 1,
      color: Accent.hairline,
    );
  }
}
