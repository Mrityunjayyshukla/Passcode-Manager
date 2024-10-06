import 'package:flutter/material.dart';

class EditEntry extends StatefulWidget {
  final Map<String, String> record;
  final Function(Map<String, String>) onUpdate;

  const EditEntry({super.key, required this.record, required this.onUpdate});

  @override
  State<EditEntry> createState() => _EditEntryState();
}

class _EditEntryState extends State<EditEntry> {
  late TextEditingController titleController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  @override
  void initState() {
    titleController = TextEditingController(text: widget.record['Title'] ?? '');
    emailController = TextEditingController(text: widget.record['Email'] ?? '');
    passwordController = TextEditingController(text: "");
    confirmPasswordController = TextEditingController(text: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool obscureText = true;
    bool obscureConfirmText=true;
    return Scaffold(
      backgroundColor: Colors.white,

      // Appbar
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Edit Entry",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),

      // Body
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Divider(
                    thickness: 2,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Title",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Email or Username",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            child: const Icon(Icons.visibility),
                            onTap: () {
                              setState(() {
                                obscureText = !obscureText;
                              });
                            }),
                        border: InputBorder.none,
                      ),
                      obscureText: obscureText,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Confirm Password",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            child: const Icon(Icons.visibility),
                            onTap: () {
                              setState(() {
                                obscureConfirmText = !obscureConfirmText;
                              });
                            }),
                        border: InputBorder.none,
                      ),
                      obscureText: obscureConfirmText,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            //Get the updated details from text controllers
                            Map<String, String> updatedRecord = {
                              'Title': titleController.text,
                              'Email': emailController.text,
                              'Password': passwordController.text,
                            };

                            // Trigger the callback to update record
                            // on the List Page
                            widget.onUpdate(updatedRecord);

                            // Navigate back to ListPage
                            Navigator.pop(context);
                          }
                        },
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.save,
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Save",
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.tertiary,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
