import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:talent_hive/services/otpServices.dart';

class OTPScreen extends StatefulWidget {
  late String email;
  OTPScreen({super.key, required this.email});
  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  // Define the colors for different parts of the UI
  final Color accentPurpleColor = Color(0xFF6A53A1);
  final Color primaryColor = Color(0xFF121212); // Black color for button

  // Function to create a TextStyle with specific color
  TextStyle createStyle(BuildContext context, Color color) {
    return Theme.of(context).textTheme.headlineLarge?.copyWith(color: color) ??
        TextStyle(color: color, fontSize: 24);
  }

  @override
  Widget build(BuildContext context) {
    OTPService otpService = OTPService();
    // List of styles for each OTP input field
    List<TextStyle> otpTextStyles = [
      createStyle(context, accentPurpleColor),
      createStyle(context, Color(0xFFFFB612)),
      createStyle(context, Color(0xFF115C49)),
      createStyle(context, Color(0xFFEA7A3B)),
      createStyle(context, Color(0xFFF99BBD)),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title: Verification Code
              Text(
                "Verification Code",
                style: Theme.of(context)
                        .textTheme
                        .headlineLarge
                        ?.copyWith(fontWeight: FontWeight.bold) ??
                    TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),

              // Subtitle: We texted you a code...
              Text(
                "We texted you a code, please enter it below.",
                style: Theme.of(context).textTheme.bodyLarge ??
                    const TextStyle(fontSize: 16, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),

              // OTP Text Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: OtpTextField(
                  numberOfFields: 5,
                  keyboardType: TextInputType.number,
                  borderColor: accentPurpleColor,
                  focusedBorderColor: accentPurpleColor,
                  styles: otpTextStyles,
                  showFieldAsBox: true,
                  fieldWidth: 50,
                  borderRadius: BorderRadius.circular(12),
                  onCodeChanged: (String code) {
                    // Handle validation or checks here if necessary
                  },
                  onSubmit: (String verificationCode) {
                    print(verificationCode);
                    print("WIDGET: ${widget.email}");
                    otpService.verifyOTP(
                        verificationCode, widget.email, context);
                  },
                ),
              ),
              const SizedBox(height: 32),

              // "Didn't get the code?" text
              TextButton(
                onPressed: () {
                  print("Resend code clicked");
                },
                child: Text(
                  "Didn't get the code? Resend",
                  style: TextStyle(
                    fontSize: 14,
                    color: accentPurpleColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Confirm Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    print("Confirm button clicked");
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
