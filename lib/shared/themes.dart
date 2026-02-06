import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ==================== COLOR PALETTE ====================
class AppColor {
  // Primary Colors - Modern Purple & Cyan Gradient
  static const Color primary = Color(0xFF6C63FF);
  static const Color primaryDark = Color(0xFF5548E8);
  static const Color primaryLight = Color(0xFFEEEDFF);

  static const Color secondary = Color(0xFF00D9FF);
  static const Color secondaryDark = Color(0xFF00B8D4);
  static const Color secondaryLight = Color(0xFF4DE8FF);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C63FF), Color(0xFF00D9FF)],
  );

  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
  );

  // Light Theme Colors
  static const Color backgroundLight = Color(0xFFFFFFFF);
  static const Color surfaceWhite = Color(0xFFFFFFFF);
  static const Color surfaceGray = Color(0xFFF8F9FA);
  static const Color borderLight = Color(0xFFE8E8E8);

  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGray = Color(0xFF6B7280);
  static const Color textLight = Color(0xFF9CA3AF);

  // Neutral Colors (Dark Theme)
  static const Color background = Color(0xFF0F0F1E);
  static const Color surface = Color(0xFF1A1A2E);
  static const Color surfaceLight = Color(0xFF252541);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB8B8D1);
  static const Color textTertiary = Color(0xFF7E7E9A);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFFDBEAFE);

  // Accent Colors
  static const Color accent1 = Color(0xFFFF6B9D);
  static const Color accent2 = Color(0xFFFFC371);
  static const Color accent3 = Color(0xFF9D50BB);

  // Overlay Colors
  static Color overlay = Colors.black.withOpacity(0.5);
  static Color shimmer = Colors.white.withOpacity(0.1);
}

// ==================== TEXT STYLES ====================
class AppTextStyle {
  // Display Styles - For large headings
  static TextStyle displayLarge = GoogleFonts.poppins(
    fontSize: 57.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColor.textPrimary,
    height: 1.2,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium = GoogleFonts.poppins(
    fontSize: 45.sp,
    fontWeight: AppFontWeight.bold,
    color: AppColor.textPrimary,
    height: 1.2,
  );

  static TextStyle displaySmall = GoogleFonts.poppins(
    fontSize: 28.sp,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.textPrimary,
    height: 1.2,
  );

  // Headline Styles - For section headers
  static TextStyle headlineLarge = GoogleFonts.poppins(
    fontSize: 32.sp,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.textPrimary,
    height: 1.25,
  );

  static TextStyle headlineMedium = GoogleFonts.poppins(
    fontSize: 28.sp,
    fontWeight: AppFontWeight.semiBold,
    color: AppColor.textPrimary,
    height: 1.3,
  );

  static TextStyle headlineSmall = GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimary,
    height: 1.3,
  );

  // Title Styles - For card titles, list items
  static TextStyle titleLarge = GoogleFonts.poppins(
    fontSize: 22.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimary,
    height: 1.4,
  );

  static TextStyle titleMedium = GoogleFonts.poppins(
    fontSize: 16.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimary,
    height: 1.5,
    letterSpacing: 0.15,
  );

  static TextStyle titleSmall = GoogleFonts.poppins(
    fontSize: 14.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimary,
    height: 1.4,
    letterSpacing: 0.1,
  );

  // Body Styles - For regular content
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: AppFontWeight.regular,
    color: AppColor.textSecondary,
    height: 1.5,
    letterSpacing: 0.5,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: AppFontWeight.regular,
    color: AppColor.textSecondary,
    height: 1.4,
    letterSpacing: 0.25,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: AppFontWeight.regular,
    color: AppColor.textTertiary,
    height: 1.3,
    letterSpacing: 0.4,
  );

  // Label Styles - For buttons, tabs
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimary,
    height: 1.4,
    letterSpacing: 0.1,
  );

  static TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textPrimary,
    height: 1.3,
    letterSpacing: 0.5,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 11.sp,
    fontWeight: AppFontWeight.medium,
    color: AppColor.textSecondary,
    height: 1.3,
    letterSpacing: 0.5,
  );
}

// ==================== FONT WEIGHTS ====================
class AppFontWeight {
  static const FontWeight thin = FontWeight.w100;
  static const FontWeight extraLight = FontWeight.w200;
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extraBold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;
}

// ==================== SPACING ====================
class AppSpacing {
  static double xs = 4.w;
  static double sm = 8.w;
  static double md = 16.w;
  static double lg = 24.w;
  static double xl = 32.w;
  static double xxl = 48.w;
  static double xxxl = 64.w;
}

// ==================== BORDER RADIUS ====================
class AppRadius {
  static double xs = 4.r;
  static double sm = 8.r;
  static double md = 12.r;
  static double lg = 16.r;
  static double xl = 24.r;
  static double xxl = 32.r;
  static double full = 999.r;
}

// ==================== SHADOWS ====================
class AppShadow {
  static List<BoxShadow> small = [
    BoxShadow(
      color: Colors.black.withOpacity(0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> medium = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> large = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> glow = [
    BoxShadow(
      color: AppColor.primary.withOpacity(0.3),
      blurRadius: 20,
      offset: const Offset(0, 0),
    ),
  ];

  static List<BoxShadow> glowCyan = [
    BoxShadow(
      color: AppColor.secondary.withOpacity(0.3),
      blurRadius: 20,
      offset: const Offset(0, 0),
    ),
  ];
}

// ==================== ANIMATIONS ====================
class AppAnimation {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration verySlow = Duration(milliseconds: 800);

  static const Curve easeIn = Curves.easeIn;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve elasticOut = Curves.elasticOut;
}
