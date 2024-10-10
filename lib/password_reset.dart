import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  const PasswordReset({super.key});

  @override
  State<PasswordReset> createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasskeyController = TextEditingController();

  String? verificationCode;
  bool isCodeSent = false;

  void sendVerificationCode() {
    // Mock sending email with a verification code
    verificationCode = '123456'; // In a real app, generate a random code
    // Send code to email (mocked)
    print('Sending code $verificationCode to ${emailController.text}');
    setState(() {
      isCodeSent = true;
    });
  }

  void resetPasskey() {
    // Check if the entered code matches the sent code
    if (codeController.text == verificationCode) {
      // Code is correct, now allow setting a new passkey
      // Save the new passkey (you would typically save this in your backend or local storage)
      String newPasskey = newPasskeyController.text;
      print('New passkey set: $newPasskey');
      // Clear fields
      codeController.clear();
      newPasskeyController.clear();
      setState(() {
        isCodeSent = false; // Reset state
      });
      // Optionally show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passkey updated successfully!')),
      );
    } else {
      // Show an error message for incorrect code
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect verification code.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Passkey')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (!isCodeSent) ...[
              TextField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Enter your email'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: sendVerificationCode,
                child: Text('Send Code'),
              ),
            ] else ...[
              TextField(
                controller: codeController,
                decoration: InputDecoration(labelText: 'Enter the verification code'),
              ),
              SizedBox(height: 20),
              TextField(
                controller: newPasskeyController,
                decoration: InputDecoration(labelText: 'Enter new 4-digit passkey'),
                keyboardType: TextInputType.number,
                maxLength: 4,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: resetPasskey,
                child: Text('Reset Passkey'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}