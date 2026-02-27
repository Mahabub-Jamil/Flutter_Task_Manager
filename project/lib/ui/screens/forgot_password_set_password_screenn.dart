import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/Data/services/network_caller.dart';
import 'package:project/Data/utils/urls.dart';
import 'package:project/ui/screens/forgot_password_pin_verify_screen.dart';
import 'package:project/ui/screens/sign_in_screen.dart';
import 'package:project/ui/utils/app_colors.dart';
import 'package:project/ui/widgets/screen_background.dart';
import 'package:project/ui/widgets/snack_bar_message.dart';

class ForgotPasswordSetPasswordScreen extends StatefulWidget {
  const ForgotPasswordSetPasswordScreen({
    super.key,
    required this.email,
    required this.otp,
  });
  final String email;
  final String otp;
  @override
  State<ForgotPasswordSetPasswordScreen> createState() =>
      _ForgotPasswordSetPasswordScreenState();
}

class _ForgotPasswordSetPasswordScreenState
    extends State<ForgotPasswordSetPasswordScreen> {
  bool _inProgress = false;
  final TextEditingController _passwordTEController = TextEditingController();
  final TextEditingController _confirmPasswordTEController =
      TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _passwordTEController,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter new password";
              }
              if (value!.length < 8) {
                return "Password must be atleast 8 characters";
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Password'),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _confirmPasswordTEController,
            validator: (String? value) {
              if (value?.isEmpty ?? true) {
                return "Enter new password again";
              }
              if (value != _passwordTEController.text) {
                return "Passwords do not match";
              }
              return null;
            },
            decoration: InputDecoration(hintText: 'Confirm password'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _onTapConfirmButton,
            child: _inProgress
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(color: Colors.white),
                  )
                : const Text('Confirm'),
          ),
        ],
      ),
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
    if (_formKey.currentState!.validate()) {
      _setNewPassword();
    }
  }

  Future<void> _setNewPassword() async {
    _inProgress = true;
    setState(() {});
    Map<String, dynamic> requestBody = {
      "email": widget.email,
      "OTP": widget.otp,
      "password": _passwordTEController.text,
    };
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.RecoverResetPass,
      body: requestBody,
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      showSnackBarMessage(context, "Password reset successfully");
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const SignInScreen()),
        (_) => false,
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _onTapGoToSignIn() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (_) => false,
    );
  }
}
