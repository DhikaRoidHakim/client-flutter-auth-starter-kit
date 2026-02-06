import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

import 'package:auth_starter_kit/shared/themes.dart';
import 'package:auth_starter_kit/ui/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late AnimationController _particleController;

  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startSplashSequence();
  }

  void _initAnimations() {
    // Logo Animation Controller
    _logoController = AnimationController(
      vsync: this,
      duration: AppAnimation.verySlow,
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );

    _logoOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // Text Animation Controller
    _textController = AnimationController(
      vsync: this,
      duration: AppAnimation.slow,
    );

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeIn));

    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Particle Animation Controller
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  void _startSplashSequence() async {
    // Start logo animation
    await Future.delayed(const Duration(milliseconds: 300));
    _logoController.forward();

    // Start text animation after logo
    await Future.delayed(const Duration(milliseconds: 500));
    _textController.forward();

    // Navigate to login after splash
    await Future.delayed(const Duration(milliseconds: 2500));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: AppAnimation.slow,
        ),
      );
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColor.darkGradient),
        child: Stack(
          children: [
            // Animated Background Particles
            _buildAnimatedParticles(),

            // Main Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated Logo
                  _buildAnimatedLogo(),

                  SizedBox(height: AppSpacing.xl),

                  // Animated Text
                  _buildAnimatedText(),

                  SizedBox(height: AppSpacing.xxl),

                  // Loading Indicator
                  _buildLoadingIndicator(),
                ],
              ),
            ),

            // Bottom Gradient Overlay
            _buildBottomGradient(),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: List.generate(20, (index) {
            final double offset =
                (index * 0.1 + _particleController.value) % 1.0;
            final double xPos = (index * 37) % 100;

            return Positioned(
              left: xPos.w,
              top: offset * MediaQuery.of(context).size.height,
              child: Container(
                width: (index % 3 + 1) * 2.w,
                height: (index % 3 + 1) * 2.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index % 2 == 0
                      ? AppColor.primary.withOpacity(0.3)
                      : AppColor.secondary.withOpacity(0.3),
                  boxShadow: [
                    BoxShadow(
                      color:
                          (index % 2 == 0
                                  ? AppColor.primary
                                  : AppColor.secondary)
                              .withOpacity(0.5),
                      blurRadius: 10,
                    ),
                  ],
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildAnimatedLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Opacity(
          opacity: _logoOpacityAnimation.value,
          child: Transform.scale(
            scale: _logoScaleAnimation.value,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: AppColor.primaryGradient,
                boxShadow: AppShadow.glow,
              ),
              child: Center(
                child: Icon(
                  Icons.shield_outlined,
                  size: 60.sp,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedText() {
    return AnimatedBuilder(
      animation: _textController,
      builder: (context, child) {
        return SlideTransition(
          position: _textSlideAnimation,
          child: Opacity(
            opacity: _textOpacityAnimation.value,
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColor.primaryGradient.createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                      ),
                  child: Text(
                    'Auth Starter Kit',
                    style: AppTextStyle.headlineLarge.copyWith(
                      color: Colors.white,
                      fontWeight: AppFontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: AppSpacing.sm),
                Text(
                  'Secure & Modern Authentication',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColor.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingIndicator() {
    return SizedBox(
      width: 40.w,
      height: 40.w,
      child: CircularProgressIndicator(
        strokeWidth: 3.w,
        valueColor: AlwaysStoppedAnimation<Color>(AppColor.secondary),
      ),
    );
  }

  Widget _buildBottomGradient() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 200.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, AppColor.background.withOpacity(0.5)],
          ),
        ),
      ),
    );
  }
}
