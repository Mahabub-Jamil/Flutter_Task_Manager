import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/ui/screens/forgot_password_pin_verify_screen.dart';
import 'package:project/ui/screens/sign_in_screen.dart';
import 'package:project/ui/utils/app_colors.dart';
import 'package:project/ui/widgets/screen_background.dart';

class ForgotPasswordSetPasswordScreen extends StatefulWidget {
  const ForgotPasswordSetPasswordScreen({super.key});

  @override
  State<ForgotPasswordSetPasswordScreen> createState() =>
      _ForgotPasswordSetPasswordScreenState();
}

class _ForgotPasswordSetPasswordScreenState
    extends State<ForgotPasswordSetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 82),
                Text(
                  'Set Password',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Minimum length password 8 character with latter and number combination',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildSetPasswordForm(),
                const SizedBox(height: 32),
                _buildDecisionSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSetPasswordForm() {
    return Column(
      children: [
        TextFormField(decoration: InputDecoration(hintText: 'Password')),
        const SizedBox(height: 24),
        TextFormField(
          decoration: InputDecoration(hintText: 'Confirm password'),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _onTapConfirmButton,
          child: const Text('Confirm'),
        ),
      ],
    );
  }

  Widget _buildDecisionSection() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                letterSpacing: 0.5,
              ),
              text: 'Have account? ',
              children: [
                TextSpan(
                  text: 'Sign In',
                  style: TextStyle(color: AppColors.themeColor),
                  recognizer: TapGestureRecognizer()..onTap = _onTapGoToSignIn,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onTapConfirmButton() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }

  void _onTapGoToSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }
}
