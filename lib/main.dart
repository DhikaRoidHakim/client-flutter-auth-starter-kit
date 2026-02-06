import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:auth_starter_kit/shared/themes.dart';
import 'package:auth_starter_kit/ui/pages/splash_screen.dart';
import 'package:auth_starter_kit/ui/pages/login_page.dart';
import 'package:auth_starter_kit/ui/pages/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColor.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const AuthStarterKit());
}

class AuthStarterKit extends StatelessWidget {
  const AuthStarterKit({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return OverlaySupport(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Auth Starter Kit',
            theme: ThemeData(
              useMaterial3: true,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: AppColor.background,
              primaryColor: AppColor.primary,
              colorScheme: ColorScheme.dark(
                primary: AppColor.primary,
                secondary: AppColor.secondary,
                surface: AppColor.surface,
                error: AppColor.error,
              ),
              textTheme: TextTheme(
                displayLarge: AppTextStyle.displayLarge,
                displayMedium: AppTextStyle.displayMedium,
                displaySmall: AppTextStyle.displaySmall,
                headlineLarge: AppTextStyle.headlineLarge,
                headlineMedium: AppTextStyle.headlineMedium,
                headlineSmall: AppTextStyle.headlineSmall,
                titleLarge: AppTextStyle.titleLarge,
                titleMedium: AppTextStyle.titleMedium,
                titleSmall: AppTextStyle.titleSmall,
                bodyLarge: AppTextStyle.bodyLarge,
                bodyMedium: AppTextStyle.bodyMedium,
                bodySmall: AppTextStyle.bodySmall,
                labelLarge: AppTextStyle.labelLarge,
                labelMedium: AppTextStyle.labelMedium,
                labelSmall: AppTextStyle.labelSmall,
              ),
            ),
            routes: {
              '/': (context) => const SplashScreen(),
              '/login': (context) => const LoginPage(),
              '/home': (context) => const HomePage(),
            },
            initialRoute: '/',
          ),
        );
      },
    );
  }
}
