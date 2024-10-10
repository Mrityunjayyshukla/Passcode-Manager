// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:passcodemanager/entry_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

String appPassKey = "0000";

class PasskeyBuildSheet extends StatefulWidget {
  List<Map<String, String>> records = [];
  int index;
  PasskeyBuildSheet({super.key, required this.index, required this.records});

  @override
  State<PasskeyBuildSheet> createState() => _PasskeyBuildSheetState();
}

class _PasskeyBuildSheetState extends State<PasskeyBuildSheet> {
  
  bool isPasskey = true;
  var pin11;
  var pin12;
  var pin13;
  var pin14;

  void _checkValue1(val) {
    setState(() {
      pin11 = val;
    });
  }

  void _checkValue2(val) {
    setState(() {
      pin12 = val;
    });
  }

  void _checkValue3(val) {
    setState(() {
      pin13 = val;
    });
  }

  void _checkValue4(val) {
    setState(() {
      pin14 = val;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPasskey();
    
  }

  Future<void> _loadPasskey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      appPassKey = prefs.getString('passkey') ?? appPassKey; // Default passkey
    });
  }

  @override
  Widget build(BuildContext context) {
    final record = widget.records[widget.index];
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        color: Theme.of(context).colorScheme.primary,
      ),
      padding: const EdgeInsets.all(16),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            "Enter the Passkey",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.tertiary,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    passkeyBlock(
                      context, 
                      68, 
                      64, 
                      (value) {
                        _checkValue1(value);
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    passkeyBlock(
                      context, 
                      68, 
                      64, 
                      (value) {
                        _checkValue2(value);
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    passkeyBlock(
                      context, 
                      68, 
                      64, 
                      (value) {
                        _checkValue3(value);
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                    passkeyBlock(
                      context, 
                      68, 
                      64, 
                      (value) {
                        _checkValue4(value);
                        if (value.length == 1) {
                          FocusScope.of(context).nextFocus();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(32)),
            child: TextButton(
              onPressed: () {
                if (pin11 + pin12 + pin13 + pin14 == appPassKey) {
                  isPasskey = true;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              RecordDetailsPage(record: record)));
                } else {
                  isPasskey = false;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passkey is incorrect. Try Again😊")),
                  );
                }
              },
              child: Text(
                "Enter",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget passkeyBlock(BuildContext context, double height, double width, Function(String)? onChanged) {
  return Container(
    decoration: BoxDecoration(
      border:
          Border.all(width: 4, color: Theme.of(context).colorScheme.tertiary),
      borderRadius: BorderRadius.circular(16),
    ),
    height: height,
    width: width,
    child: TextFormField(
      obscureText: false,
      cursorColor: Theme.of(context).colorScheme.secondary,
      decoration: const InputDecoration(border: InputBorder.none),
      onChanged: onChanged,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headlineMedium,
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
    ),
  );
}
