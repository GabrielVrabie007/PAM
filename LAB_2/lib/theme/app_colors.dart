import 'package:flutter/material.dart';

/// Culorile extrase direct din fisierul Figma "Laboratoare 2026".
/// Singura sursa de adevar pentru culori - nu hardcoda hex-uri in widget-uri.
abstract final class AppColors {
  // Accent (stele, link-uri, bare de rating)
  static const accent = Color(0xFF508A7B);

  // Text
  static const textPrimary = Color(0xFF1D1F22);
  static const textHeading = Color(0xFF000000);
  static const textDark = Color(0xFF33302E);
  static const textRating = Color(0xFF231F20);
  static const textMuted = Color(0xFF8A8A8F);
  static const textShowAll = Color(0xFF9B9B9B);
  static const textCategoryOff = Color(0xFF9D9D9D);
  static const textBanner = Color(0xFF777E90);
  static const textBannerDark = Color(0xFF353945);
  static const textLabel = Color(0xFF737680);
  static const textSizeOff = Color(0xFFC5C5C5);

  // Suprafete
  static const surfaceCard = Color(0xFFF4F2F0); // fundal card produs
  static const surfaceBanner = Color(0xFFF8F8FA); // fundal banner
  static const surfaceCategoryOff = Color(0xFFF3F3F3);
  static const surfaceSizeOff = Color(0xFFFAFAFA);
  static const surfaceRecImage = Color(0xFFC4C4C4);
  static const heroPlaceholder = Color(0xFFE7E8E9);

  // Linii
  static const divider = Color(0xFFF3F3F6);
  static const ratingTrack = Color(0xFFEFF0F1);
  static const cardBorder = Color(0xFFF9F9F9);

  // Accente punctuale
  static const categoryActive = Color(0xFF3A2C27);
  static const heart = Color(0xFFFF6E6E);
  static const notificationDot = Color(0xFFEF466F);
  static const sizeActive = Color(0xFF515151);
  static const addToCartBar = Color(0xFF343434);

  // Ecranul de produs
  static const productBackdrop = Color(0xFFFFFCFA);
  static const productCircle = Color(0xFFEACAB7);

  // Cercuri decorative din bannere
  static const bannerCircleLarge = Color(0xFFE2E2E2);
  static const bannerCircleSmall = Color(0xFFECECEC);
  static const bannerCircleGrey = Color(0xFFF3F3F3);

  // Pastile de culoare pe ecranul de produs
  static const swatchBeige = Color(0xFFE7C0A7);
  static const swatchBlack = Color(0xFF050302);
  static const swatchRed = Color(0xFFEE6969);
}
