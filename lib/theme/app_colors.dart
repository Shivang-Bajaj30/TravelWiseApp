import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Premium dark palette (current)
  static const Color primary = Color(0xFFEE3054); // deep crimson
  static const Color secondary = Color(0xFFFF6B6B); // soft coral red
  static const Color accent = Color(0xFFFF9F68); // warm amber-red accent

  // Surfaces
  static const Color dark = Color(0xFF07040A); // near‑black background
  static const Color light = Color(0xFFFFF8F8); // soft off‑white

  // Dark theme text colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // white text
  static const Color darkTextSecondary = Color(0xFFAAAAAA); // gray text

  // Dark theme surfaces
  static const Color darkCardBackground = Color(0xFF1E1E1E); // dark card
  static const Color darkAppBar = Color(0xFF121212); // dark app bar

  // White‑forward light theme palette (option 4)
  static const Color lightPrimary = Color(0xFFE50914);
  static const Color lightSecondary = Color(0xFFFF6D6D);
  static const Color lightAccent = Color(0xFF2D3142); // slate
  static const Color lightBackground = Color(0xFFFFF5F5);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF111111);
  static const Color lightTextSecondary = Color(0xFF777777);

  // Light theme surfaces
  static const Color lightAppBar = Color(0xFFFFFFFF); // white app bar
  static const Color lightDivider = Color(0xFFEEEEEE); // light divider

  // Semantic colors (work for both themes)
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Disable/inactive states
  static const Color disabled = Color(0xFFBDBDBD);
}
