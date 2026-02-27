import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:project/Data/models/network_response.dart';
import 'package:project/Data/services/network_caller.dart';
import 'package:project/Data/utils/urls.dart';
import 'package:project/ui/screens/forgot_password_set_password_screenn.dart';
import 'package:project/ui/screens/sign_in_screen.dart';
import 'package:project/ui/utils/app_colors.dart';
import 'package:project/ui/widgets/centered_circular_progress_indicator.dart';
import 'package:project/ui/widgets/screen_background.dart';
import 'package:project/ui/widgets/snack_bar_message.dart';

class ForgotPasswordPinVerifyScreen extends StatefulWidget {
  const ForgotPasswordPinVerifyScreen({super.key, required this.email});
  final String email;
  @override
  State<ForgotPasswordPinVerifyScreen> createState() =>
      _ForgotPasswordPinVerifyScreenState();
}

class _ForgotPasswordPinVerifyScreenState
    extends State<ForgotPasswordPinVerifyScreen> {
  bool _inProgress = false;
  final TextEditingController _otpTEController = TextEditingController();
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
                  'Pin Verification',
                  style: textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'A 6 digit verification pin has been sent to your email address',
                  style: textTheme.titleSmall?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                _buildPinVerificationForm(),
                const SizedBox(height: 32),
                _buildDecisionSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPinVerificationForm() {
    return Column(
      children: [
        PinCodeTextField(
          controller: _otpTEController,
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          keyboardType: TextInputType.number,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
            inactiveFillColor: Colors.white,
            selectedFillColor: Colors.white,
            inactiveColor: Colors.white,
          ),
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.transparent,
          enableActiveFill: true,
          appContext: context,
        ),
        ElevatedButton(
          onPressed: _onTapVerifyButton,
          child: _inProgress
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(color: Colors.white),
                )
              : const Text('Verify'),
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

  void _onTapVerifyButton() {
    if (_otpTEController.text.length == 6) {
      _verifyOTP();
    } else {
      showSnackBarMessage(context, "Please enter the 6 digit PIN", true);
    }
  }

  Future<void> _verifyOTP() async {
    _inProgress = true;
    setState(() {});
    String otp = _otpTEController.text.trim();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.RecoverVerifyOTP(widget.email, otp),
    );
    _inProgress = false;
    setState(() {});
    if (response.isSuccess) {
      showSnackBarMessage(context, "Email verification successfull");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ForgotPasswordSetPasswordScreen(email: widget.email, otp: otp),
        ),
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
