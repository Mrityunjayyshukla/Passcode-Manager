import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AddEntry extends StatefulWidget {
  final Function(Map<String, String>) onAdd;
  AddEntry({super.key, required this.onAdd});

  @override
  State<AddEntry> createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {

  bool _obscureText = true;
  bool _obscureConfirmText=true;

  TextEditingController titleController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,

      // Appbar
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          "Add Entry",
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
            padding: const EdgeInsets.all(16),
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
                    color: Theme.of(context).colorScheme.tertiary
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
                      border: Border.all(width: 2,color: Theme.of(context).colorScheme.tertiary),
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
                      border: Border.all(width: 2,color: Theme.of(context).colorScheme.tertiary),
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
                      border: Border.all(width: 2,color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      obscureText: _obscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            child: const Icon(Icons.visibility),
                            onTap: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }),
                        border: InputBorder.none,
                      ),
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
                      border: Border.all(width: 2,color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      obscureText: _obscureConfirmText,
                      controller: confirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                            child: const Icon(Icons.visibility),
                            onTap: () {
                              setState(() {
                                _obscureConfirmText = !_obscureConfirmText;
                              });
                            }),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4,horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Theme.of(context).colorScheme.secondary
                      ),
                      child: IconButton(
                        onPressed: (){
                          if (passwordController.text==confirmPasswordController.text){
                            // Get the details from the text controllers
                            Map<String, String> newRecord = {
                              'Title': titleController.text,
                              'Email': emailController.text,
                              'Password': passwordController.text,
                            };
                                      
                            // Trigger the callback to add the new
                            // record on the ListPage
                            widget.onAdd(newRecord);
                                      
                            // Navigate back to list page
                            Navigator.pop(context);
                          }
                          
                        }, 
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.save, color: Theme.of(context).colorScheme.tertiary,),
                            const SizedBox(width: 8),
                            Text(
                              "Add Entry",
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}