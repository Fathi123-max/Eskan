import 'package:flutter/material.dart';

/// Represents an item in the app drawer navigation.
class DrawerItem {
  /// Display title for the drawer item.
  final String title;

  /// Icon to display for the drawer item.
  final IconData icon;

  /// Creates a [DrawerItem] with the given title and icon.
  const DrawerItem({required this.title, required this.icon});
}
