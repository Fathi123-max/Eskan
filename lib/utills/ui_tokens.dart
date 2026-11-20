/// Visual tokens for the Eskan UI refresh.
///
/// These are the knobs the rest of the refreshed UI reads from so the app
/// stays consistent: color accents, text styles, spacing, radii, and a little
/// motion guidance. Keep this file as the place to change the look, not the
/// individual widgets.
///
/// The existing `themes.dart` already defines a full Material 3 color scheme
/// for light and dark mode. This file is not a replacement for it — it is the
/// smaller, more opinionated layer the refreshed components use for things the
/// theme does not already express well (Arabic headline scale, spec/number
/// styles, card rhythm, touch targets, reduced-motion handling).

import 'package:flutter/material.dart';

/// Brand accent used for the one memorable place (price, selected state,
/// primary interactive moments). Kept honest and restrained rather than
/// decorative.
abstract final class Accent {
  /// Primary brand accent.
  static const Color primary = Color(0xFF00658D);

  /// Softer accent tint for surfaces/selected states.
  static const Color primarySoft = Color(0xFFC6E7FF);

  /// Warm neutral used sparingly for emphasis that should not feel like the
  /// brand (price highlight, active chips).
  static const Color warm = Color(0xFFE8743B);

  /// Neutral grey scale anchor for borders and dividers.
  static const Color hairline = Color(0xFFDDE3EA);
}

/// Surface tokens.
abstract final class Surface {
  /// Light-mode background.
  static const Color background = Color(0xFFFCFCFF);

  /// Card / elevated surface.
  static const Color card = Color(0xFFFFFFFF);

  /// Slightly deeper surface for contrast without a hard shadow on every card.
  static const Color surfaceVariant = Color(0xFFF3F5F8);
}

/// Type scale for the refreshed Arabic-first UI.
///
/// Arabic is the primary locale, so the Arabic headline sizes and line heights
/// are chosen for Arabic readability. There is no artificial letter-spacing on
/// Arabic labels (a common tell of an English layout poured into Arabic).
abstract final class Type {
  /// Largest display/headline size used for the hero line on home.
  static const double headlineLarge = 26.0;

  /// Section header size.
  static const double sectionTitle = 20.0;

  /// Card title / address.
  static const double cardTitle = 15.0;

  /// Small metadata text (city, specs, price unit).
  static const double metadata = 12.0;

  /// The size used for prices in card context.
  static const double price = 16.0;

  /// Arabic headline style.
  static TextStyle arabicHeadline({
    double size = headlineLarge,
    FontWeight weight = FontWeight.w700,
    Color? color,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.25,
      // No letter-spacing on Arabic labels.
      letterSpacing: 0,
    );
  }

  /// Section header style used above listing blocks.
  static TextStyle sectionTitleStyle({
    Color? color,
    FontWeight weight = FontWeight.w700,
  }) {
    return TextStyle(
      fontSize: sectionTitle,
      fontWeight: weight,
      height: 1.3,
      color: color,
    );
  }

  /// Price style. Numbers should stay tabular so prices/scrolls line up.
  static TextStyle priceStyle({
    double size = price,
    FontWeight weight = FontWeight.w700,
    Color? color,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: 1.2,
      // Tabular nums for price-like columns.
      fontVariations: const [],
    );
  }

  /// Metadata style for city, area, spec chips.
  static TextStyle metadataStyle({
    double size = metadata,
    FontWeight weight = FontWeight.w500,
    Color? color,
  }) {
    return TextStyle(
      fontSize: size,
      fontWeight: weight,
      height: 1.35,
      color: color,
    );
  }
}

/// Spacing rhythm. Pick from this scale rather than inventing a new padding
/// on every widget.
abstract final class Space {
  static const double xxs = 4.0;
  static const double xs = 8.0;
  static const double sm = 12.0;
  static const double md = 16.0;
  static const double lg = 20.0;
  static const double xl = 24.0;
  static const double xxl = 32.0;
}

/// Radii reused by the refreshed components.
abstract final class Radius {
  /// Card radius.
  static const double card = 16.0;

  /// Small chip/badge radius.
  static const double chip = 8.0;

  /// Rounded full for circular hit targets.
  static const double circle = 999.0;
}

/// A minimum comfortable touch target for primary mobile actions.
abstract final class Touch {
  /// Recommended minimum touch target height for primary buttons/actions.
  static const double minTarget = 44.0;
}

/// Reduced-motion handling shared by the few deliberate animations in the
/// refreshed UI.
abstract final class Motion {
  /// Whether the current context asks for reduced motion.
  static bool prefersReducedMotion(BuildContext context) {
    final accessibility = MediaQuery.accessibilityFeaturesOf(context);
    return accessibility.any((feature) => feature is AccessibilityFeatures
        ? feature.displaysFeatures.any(
            (f) => f is DisplayFeatures && f.supportsReduceMotion == true,
          )
        ?? false);
  }
}
