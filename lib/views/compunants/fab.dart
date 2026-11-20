import 'package:flutter/material.dart';

import '../utills/ui_tokens.dart';
import '../utills/ui_helpers.dart';

/// A search affordance used as a floating button or inline action.
///
/// Refreshed treatment:
/// - real minimum touch target instead of a fixed 50x150 box
/// - theme-driven colors from the token layer
/// - clear label semantics for assistive tech
/// - width adapts to content rather than a hard-coded short width that can
///   clip translated Arabic labels
class SearchButton extends StatelessWidget {
  /// Button text label.
  final String text;

  /// Callback when the button is tapped.
  final VoidCallback onTap;

  /// Optional icon to display before the text.
  final IconData? icon;

  /// Icon tint overrides the token default when provided.
  final Color? iconColor;

  /// Text tint overrides the token default when provided.
  final Color? textColor;

  /// When true, the button keeps a compact fixed width suitable for small
  /// floating buttons. Otherwise it sizes to content.
  final bool compact;

  /// Creates a [SearchButton].
  const SearchButton({
    super.key,
    required this.text,
    required this.onTap,
    this.icon,
    this.iconColor,
    this.textColor,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final label = semanticsLabel ?? text;

    Widget inner = Material(
      color: Colors.white,
      child: InkWell(
        onTap: onTap,
        customBrightness: Brightness.light,
        child: Container(
          height: Touch.minTarget,
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: Space.sm,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(Radius.chip),
            border: Border.all(color: Accent.hairline),
          ),
          child: Row(
            mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: iconColor ?? Accent.primary,
                  size: 18,
                ),
                const SizedBox(width: Space.xs),
              ],
              Text(
                text,
                style: Type.metadataStyle(
                  size: 14,
                  weight: FontWeight.w600,
                  color: textColor ?? Accent.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (compact) {
      return SizedBox(
        width: 48,
        height: Touch.minTarget,
        child: inner,
      );
    }

    return SizedBox(
      height: Touch.minTarget,
      child: Semantics(
        button: true,
        label: label,
        child: inner,
      ),
    );
  }

  /// Optional semantic label for assistive tech. Defaults to the visible text.
  final String? semanticsLabel;
}
