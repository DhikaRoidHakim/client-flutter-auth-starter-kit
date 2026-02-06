import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:auth_starter_kit/shared/themes.dart';
import 'package:auth_starter_kit/blocs/logout/logout_bloc.dart';
import 'package:auth_starter_kit/blocs/logout/logout_event.dart';
import 'package:auth_starter_kit/blocs/logout/logout_state.dart';
import 'package:auth_starter_kit/repositories/auth_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogoutBloc(authRepository: AuthRepository()),
      child: const _HomePageContent(),
    );
  }
}

class _HomePageContent extends StatefulWidget {
  const _HomePageContent();

  @override
  State<_HomePageContent> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePageContent> {
  bool _isFabExpanded = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutBloc, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Logout Successful'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        } else if (state is LogoutFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
          // Tetap redirect ke login meskipun API gagal
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      child: _buildScaffold(context),
    );
  }

  Widget _buildScaffold(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeader(),

                SizedBox(height: AppSpacing.xl),

                // Credit Overview Cards
                _buildCreditOverview(),

                SizedBox(height: AppSpacing.xl),

                // Quick Actions
                _buildQuickActions(),

                SizedBox(height: AppSpacing.xl),

                // Add bottom padding for FAB
                SizedBox(height: 80.h),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kredit Dashboard',
              style: AppTextStyle.headlineMedium.copyWith(
                color: AppColor.textDark,
                fontWeight: AppFontWeight.bold,
              ),
            ),
            SizedBox(height: AppSpacing.xs),
            Text(
              'Kelola Kredit',
              style: AppTextStyle.bodyMedium.copyWith(color: AppColor.textGray),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: AppColor.surfaceWhite,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColor.borderLight, width: 1),
          ),
          child: Icon(
            Icons.notifications_outlined,
            color: AppColor.primary,
            size: 24.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildCreditOverview() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Total Kredit',
                value: '156',
                icon: Icons.credit_card,
                color: AppColor.primary,
                lightColor: AppColor.primaryLight,
                subtitle: 'Kredit Aktif',
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                title: 'Outstanding',
                value: 'Rp 2.4M',
                icon: Icons.account_balance_wallet_outlined,
                color: AppColor.warning,
                lightColor: AppColor.warningLight,
                subtitle: 'Total Outstanding',
              ),
            ),
          ],
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Disetujui',
                value: '89',
                icon: Icons.check_circle_outline,
                color: AppColor.success,
                lightColor: AppColor.successLight,
                subtitle: 'Disetujui bulan ini',
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildStatCard(
                title: 'Pending',
                value: '23',
                icon: Icons.pending_outlined,
                color: AppColor.info,
                lightColor: AppColor.infoLight,
                subtitle: 'Perlu Direview',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required Color lightColor,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColor.surfaceWhite,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColor.borderLight, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: lightColor,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(height: AppSpacing.md),
          Text(
            value,
            style: AppTextStyle.headlineSmall.copyWith(
              color: AppColor.textDark,
              fontWeight: AppFontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColor.textDark,
              fontWeight: AppFontWeight.medium,
            ),
          ),
          Text(
            subtitle,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColor.textLight,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Aksi Cepat',
          style: AppTextStyle.titleLarge.copyWith(
            color: AppColor.textDark,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                label: 'Kredit Baru',
                icon: Icons.add_circle_outline,
                color: AppColor.primary,
                lightColor: AppColor.primaryLight,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildActionButton(
                label: 'Review',
                icon: Icons.rate_review_outlined,
                color: AppColor.info,
                lightColor: AppColor.infoLight,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildActionButton(
                label: 'Laporan',
                icon: Icons.assessment_outlined,
                color: AppColor.success,
                lightColor: AppColor.successLight,
              ),
            ),
            SizedBox(width: AppSpacing.md),
            Expanded(
              child: _buildActionButton(
                label: 'Pengaturan',
                icon: Icons.settings_outlined,
                color: AppColor.textGray,
                lightColor: AppColor.surfaceGray,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required Color lightColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColor.surfaceWhite,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColor.borderLight, width: 1),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: lightColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 24.sp),
              ),
              SizedBox(height: AppSpacing.xs),
              Text(
                label,
                style: AppTextStyle.labelSmall.copyWith(
                  color: AppColor.textGray,
                  fontWeight: AppFontWeight.medium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Logout Button (shown when expanded)
        AnimatedOpacity(
          opacity: _isFabExpanded ? 1.0 : 0.0,
          duration: AppAnimation.fast,
          child: AnimatedContainer(
            duration: AppAnimation.fast,
            height: _isFabExpanded ? null : 0,
            child: _isFabExpanded
                ? Container(
                    margin: EdgeInsets.only(bottom: AppSpacing.md),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isFabExpanded = false;
                          });
                          // Show confirmation dialog
                          _showLogoutDialog();
                        },
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.surfaceWhite,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            border: Border.all(
                              color: AppColor.borderLight,
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.logout,
                                color: AppColor.error,
                                size: 20.sp,
                              ),
                              SizedBox(width: AppSpacing.sm),
                              Text(
                                'Logout',
                                style: AppTextStyle.labelMedium.copyWith(
                                  color: AppColor.textDark,
                                  fontWeight: AppFontWeight.semiBold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),

        // Main FAB
        FloatingActionButton(
          onPressed: () {
            setState(() {
              _isFabExpanded = !_isFabExpanded;
            });
          },
          backgroundColor: Colors.white,
          elevation: 4,
          child: Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              gradient: AppColor.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColor.primary.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              _isFabExpanded ? Icons.close : Icons.menu,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    // Simpan context yang memiliki akses ke LogoutBloc
    final blocContext = context;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          backgroundColor: AppColor.surfaceWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          title: Row(
            children: [
              Container(
                padding: EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: AppColor.errorLight,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(Icons.logout, color: AppColor.error, size: 24.sp),
              ),
              SizedBox(width: AppSpacing.md),
              Text(
                'Logout',
                style: AppTextStyle.titleLarge.copyWith(
                  color: AppColor.textDark,
                  fontWeight: AppFontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: AppTextStyle.bodyMedium.copyWith(color: AppColor.textGray),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(
                'Cancel',
                style: AppTextStyle.labelLarge.copyWith(
                  color: AppColor.textGray,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColor.error, AppColor.error.withOpacity(0.8)],
                ),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(dialogContext).pop();
                    // Gunakan blocContext yang memiliki akses ke LogoutBloc
                    blocContext.read<LogoutBloc>().add(
                      const LogoutButtonPressed(),
                    );
                  },
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.sm,
                    ),
                    child: Text(
                      'Logout',
                      style: AppTextStyle.labelLarge.copyWith(
                        color: Colors.white,
                        fontWeight: AppFontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
