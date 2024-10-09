import 'package:flutter/material.dart';
import 'package:passcodemanager/add_entry.dart';
import 'package:passcodemanager/color_palette.dart';
import 'package:passcodemanager/edit_entry.dart';
import 'package:passcodemanager/passkey.dart';
import 'package:passcodemanager/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightMode,
      darkTheme: darkMode,
      home: const ListPage(),
    );
  }
}

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  String? _username;
  // This is the list of all the records which are there.
  List<Map<String, String>> records = [];

  // This will initially show the list of the records
  @override
  void initState() {
    _loadUsername();
    _loadRecords();
    super.initState();
  }

  // Load the username
  Future<void> _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username');
    });
  }

  // Load Records function will be used to fetch
  // the results from the SharedPreferences
  _loadRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recordsList = prefs.getStringList('records') ?? [];
    setState(() {
      records = recordsList.map((recordString) {
        List<String> parts = recordString.split(',');
        return {
          'Title': parts[0],
          'Email': parts[1],
          'Password': parts[2],
        };
      }).toList();
    });
  }

  // Function to add a new Record
  _addRecord(Map<String, String> newRecord) {
    setState(() {
      records.add(newRecord);
    });

    // Save the Updated Records to sharedPreferences
    _saveRecords();
  }

  // Function to delete a record
  _deleteRecord(int index) {
    setState(() {
      records.removeAt(index);
    });

    // Save updated records to SharedPreferences
    _saveRecords();
  }

  // Function to save records to sharedPreferences
  _saveRecords() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> recordsList = records
        .map((record) =>
            '${record['Title']},${record['Email']},${record['Password']}')
        .toList();
    prefs.setStringList('records', recordsList);
  }

  // Function to update a record
  _updateRecord(int index, Map<String, String> updatedRecord) {
    setState(() {
      records[index] = updatedRecord;
    });

    // Save updated records to SharedPreferences
    _saveRecords();
  }

  // Function to navigate to the EditPage
  _navigateToEditPage(Map<String, String> record) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditEntry(
                  record: record,
                  onUpdate: (updatedRecord) {
                    // Callback to handle the edited record
                    _updateRecord(
                        records.indexWhere((element) => element == record),
                        updatedRecord);
                  },
                )));
  }

  @override
  Widget build(BuildContext context) {
    bool isEmptyRecord;
    if (records.isEmpty) {
      isEmptyRecord = true;
    } else {
      isEmptyRecord = false;
    }
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,

        // Appbar
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          title: Text(
            "Passcode Manager",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                ).then((_) {
                  _loadUsername(); // Refresh the username after returning
                });
              },
              icon: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            )
          ],
        ),

        // Floating Action Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEntry(
                          onAdd: _addRecord,
                        )));
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Passcode Manager is an app where you can store you passwords securely. This app is perfect for you if you always forget your passwords",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  _username != null ? "Hello, $_username ! 😊" : "No Username",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 16),
                Divider(
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                const SizedBox(height: 16),
                (isEmptyRecord == true)
                    ? Text(
                        "No Record Found",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.tertiary),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height - 243,
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: records.length,
                          itemBuilder: (context, index) {
                            final record = records[index];
                            return GestureDetector(
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 16, top: 8, bottom: 8, right: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${record['Title']}",
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      PopupMenuButton(
                                        color: Theme.of(context).colorScheme.primary,
                                        menuPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        shadowColor: Theme.of(context).colorScheme.secondary,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                        ),
                                        itemBuilder: (context) => [
                                          PopupMenuItem(
                                            
                                            child: Text(
                                              "Edit",
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.tertiary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {
                                              _navigateToEditPage(record);
                                            },
                                          ),
                                          PopupMenuItem(
                                            
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.tertiary,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            onTap: () {
                                              _deleteRecord(index);
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  )),
                              onTap: () {
                                showModalBottomSheet(
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25)),
                                  ),
                                  backgroundColor: Colors.purple[50],
                                  isScrollControlled: true,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return PasskeyBuildSheet(
                                        index: index, records: records);
                                  },
                                );
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 16);
                          },
                        ),
                      ),
              ],
            ),
          ),
        ));
  }
}
