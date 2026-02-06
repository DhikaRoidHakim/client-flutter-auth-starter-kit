import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auth_starter_kit/shared/themes.dart';
import 'package:auth_starter_kit/blocs/login/login_bloc.dart';
import 'package:auth_starter_kit/blocs/login/login_event.dart';
import 'package:auth_starter_kit/blocs/login/login_state.dart';
import 'package:auth_starter_kit/repositories/auth_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(authRepository: AuthRepository()),
      child: const _LoginForm(),
    );
  }
}

class _LoginForm extends StatefulWidget {
  const _LoginForm();

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
        LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Login Successful'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushReplacementNamed(context, '/home');
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundLight,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSpacing.xl),
                  _buildHeader(),
                  SizedBox(height: AppSpacing.xl),
                  _buildLoginForm(),
                  SizedBox(height: AppSpacing.xl),
                  _buildDivider(),
                  SizedBox(height: AppSpacing.xl),
                  _buildSocialLogin(),
                  SizedBox(height: AppSpacing.lg),
                  // _buildSignUpLink(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64.w,
          height: 64.w,
          decoration: BoxDecoration(
            // gradient: AppColor.primaryGradient,
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          //gunakan gambar
          child: Image.asset('assets/img/logo_polos.png'),
        ),
        SizedBox(height: AppSpacing.lg),
        Text(
          'Selamat Datang Kembali.',
          style: AppTextStyle.displaySmall.copyWith(
            color: AppColor.textDark,
            fontWeight: AppFontWeight.bold,
          ),
        ),
        SizedBox(height: AppSpacing.xs),
        Text(
          'Masuk untuk melanjutkan ke akun Anda',
          style: AppTextStyle.bodyLarge.copyWith(color: AppColor.textGray),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: AppTextStyle.titleSmall.copyWith(
              color: AppColor.textDark,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: AppTextStyle.bodyMedium.copyWith(color: AppColor.textDark),
            decoration: InputDecoration(
              hintText: 'Masukkan email',
              hintStyle: AppTextStyle.bodyMedium.copyWith(
                color: AppColor.textLight,
              ),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: AppColor.textGray,
                size: 20.sp,
              ),
              filled: true,
              fillColor: AppColor.surfaceWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.borderLight, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.borderLight, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.error, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: AppSpacing.lg),
          Text(
            'Password',
            style: AppTextStyle.titleSmall.copyWith(
              color: AppColor.textDark,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
          SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            style: AppTextStyle.bodyMedium.copyWith(color: AppColor.textDark),
            decoration: InputDecoration(
              hintText: 'Masukkan password',
              hintStyle: AppTextStyle.bodyMedium.copyWith(
                color: AppColor.textLight,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: AppColor.textGray,
                size: 20.sp,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColor.textGray,
                  size: 20.sp,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              filled: true,
              fillColor: AppColor.surfaceWhite,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.borderLight, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.borderLight, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
                borderSide: BorderSide(color: AppColor.error, width: 2),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }
              return null;
            },
          ),
          SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            child: Container(
              decoration: BoxDecoration(
                gradient: AppColor.primaryGradient,
                borderRadius: BorderRadius.circular(AppRadius.md),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _handleLogin,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: AppSpacing.md + 2.h,
                    ),
                    child: Center(
                      child: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return SizedBox(
                              height: 20.w,
                              width: 20.w,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            );
                          }
                          return Text(
                            'Masuk',
                            style: AppTextStyle.titleMedium.copyWith(
                              color: Colors.white,
                              fontWeight: AppFontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColor.borderLight, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Atau lanjutkan dengan',
            style: AppTextStyle.bodySmall.copyWith(color: AppColor.textLight),
          ),
        ),
        Expanded(child: Divider(color: AppColor.borderLight, thickness: 1)),
      ],
    );
  }

  Widget _buildSocialLogin() {
    return Row(
      children: [
        Expanded(
          child: _buildSocialButton(
            label: 'CODEX',
            icon: Icons.g_mobiledata,
            onTap: () {},
          ),
        ),
        SizedBox(width: AppSpacing.md),
        Expanded(
          child: _buildSocialButton(
            label: 'CODEX',
            icon: Icons.apple,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColor.surfaceWhite,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColor.borderLight, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColor.textDark, size: 24.sp),
              SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: AppTextStyle.titleSmall.copyWith(
                  color: AppColor.textDark,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildSignUpLink() {
  //   return Center(
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         Text(
  //           "Don't have an account? ",
  //           style: AppTextStyle.bodyMedium.copyWith(color: AppColor.textGray),
  //         ),
  //         TextButton(
  //           onPressed: () {},
  //           style: TextButton.styleFrom(
  //             padding: EdgeInsets.zero,
  //             minimumSize: Size.zero,
  //             tapTargetSize: MaterialTapTargetSize.shrinkWrap,
  //           ),
  //           child: Text(
  //             'Sign Up',
  //             style: AppTextStyle.bodyMedium.copyWith(
  //               color: AppColor.primary,
  //               fontWeight: AppFontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
