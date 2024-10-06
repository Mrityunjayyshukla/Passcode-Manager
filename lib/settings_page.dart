import 'package:flutter/material.dart';
import 'package:passcodemanager/components.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isEditClicked=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUsername();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      // Appbar
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Settings",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      // Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 24),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dark Mode",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Add a Username",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2,color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Text(
                      isEditClicked? 'Cancel':'Edit',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  onTap: (){
                    setState(() {
                      isEditClicked=!isEditClicked;
                      if (!isEditClicked){
                        _saveUsername();
                      }
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            isEditClicked?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(width: 2,color: Theme.of(context).colorScheme.tertiary),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            )
            : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }

  void _saveUsername() async {
    String enteredUsername = usernameEditingController.text;
    // Save the entered username to SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', enteredUsername);
    usernameEditingController.clear(); // Clear the text field after saving
    _loadUsername(); // Reload the username to update the displayed value in ListPage
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedUsername = prefs.getString('username') ?? '';
    usernameEditingController.text=savedUsername;
  }
}