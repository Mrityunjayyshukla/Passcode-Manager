// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final oldPasskeyController = TextEditingController();
  final newPasskeyController = TextEditingController();
  final confirmNewPasskeyController = TextEditingController();
  String? appPassKey; // Store the current passkey
  
  @override
  void initState() {
    super.initState();
    _loadPasskey(); // Load the passkey from SharedPreferences
  }

  Future<void> _loadPasskey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      appPassKey = prefs.getString('passkey') ?? "2505"; // Default passkey
    });
  }

  Future<void> _changePasskey() async {
    if (oldPasskeyController.text == appPassKey) {
      if (newPasskeyController.text == confirmNewPasskeyController.text) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('passkey', newPasskeyController.text); // Update the stored passkey
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passkey changed successfully!")),
        );

        // Clear the fields
        oldPasskeyController.clear();
        newPasskeyController.clear();
        confirmNewPasskeyController.clear();
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("New passkeys do not match!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Old passkey is incorrect!")),
      );
    }
  }

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      // Appbar
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),

      //body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Change Username",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: _controller,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: IconButton(
                    onPressed: () async {
                      await saveUsername(_controller.text);
                      Navigator.pop(context); // Navigate back to the home page
                    },
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Save Name",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32,),
              Divider(thickness: 2, color: Theme.of(context).colorScheme.tertiary,),
              const SizedBox(height: 16,),
              Text(
                "Change Passkey",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16,),
              Text(
                "Enter Previous Passkey",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                width: MediaQuery.of(context).size.width/2,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4), 
                  ],
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: oldPasskeyController,
                  obscureText: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              
              Text(
                "Enter New Passkey",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                width: MediaQuery.of(context).size.width/2,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4), 
                  ],
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: newPasskeyController,
                  obscureText: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 24,),
              Text(
                "Confirm New Passkey",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 16,),
              Container(
                width: MediaQuery.of(context).size.width/2,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 4,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4), 
                  ],
                  keyboardType: TextInputType.number,
                  cursorColor: Theme.of(context).colorScheme.secondary,
                  controller: confirmNewPasskeyController,
                  obscureText: true,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              Center(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  child: IconButton(
                    onPressed: _changePasskey,
                    icon: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.save,
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Save Password",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),  
              const SizedBox(height: 8,),    

            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
  }
}



// 1. Display an input field for the email.
// 2. Send a 6-digit code to the entered email.
// 3. Allow the user to enter the received code.
// 4. If the code is correct, prompt the user to enter a new 4-digit passkey.