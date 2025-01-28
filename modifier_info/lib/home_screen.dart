import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modifier_info/edit_plu_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CreateModifierGroupScreen(),
    ViewModifierGroupsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add PLU',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'View PLU',
          ),
        ],
      ),
    );
  }
}

class CreateModifierGroupScreen extends StatefulWidget {
  const CreateModifierGroupScreen({super.key});
  @override
  State<CreateModifierGroupScreen> createState() =>
      _CreateModifierGroupScreenState();
}

class _CreateModifierGroupScreenState extends State<CreateModifierGroupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pluController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _minQuantityController = TextEditingController();
  final TextEditingController _maxQuantityController = TextEditingController();

  bool _isActive = true;

  Future<void> createModifierGroup() async {
    const String apiUrl =
        "https://megameal.twilightparadox.com/pos/setting/modifier_group/";

    final Map<String, dynamic> requestBody = {
      "PLU": _pluController.text.trim(),
      "name": _nameController.text.trim(),
      "modifier_group_description": _descriptionController.text.trim(),
      "min": int.tryParse(_minQuantityController.text.trim()) ?? 0,
      "max": int.tryParse(_maxQuantityController.text.trim()) ?? 0,
      "active": _isActive, // Use the _isActive variable
      "vendorId": 1,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Modifier Group Created Successfully!')),
        );
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Network Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Modifier Group')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _pluController,
                decoration: InputDecoration(labelText: 'PLU'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'PLU is required' : null,
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _minQuantityController,
                decoration: InputDecoration(labelText: 'Min Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Min Quantity is required'
                    : null,
              ),
              TextFormField(
                controller: _maxQuantityController,
                decoration: InputDecoration(labelText: 'Max Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty
                    ? 'Max Quantity is required'
                    : null,
              ),
              Row(
                children: [
                  Text("Active:"),
                  Switch(
                    value: _isActive,
                    onChanged: (value) {
                      setState(() {
                        _isActive = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    createModifierGroup();
                  }
                },
                child: Text('Create Modifier Group'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ViewModifierGroupsScreen extends StatefulWidget {
  const ViewModifierGroupsScreen({super.key});

  @override
  State<ViewModifierGroupsScreen> createState() =>
      _ViewModifierGroupsScreenState();
}

class _ViewModifierGroupsScreenState extends State<ViewModifierGroupsScreen> {
  List<dynamic> modifierGroups = [];
  bool isLoading = true;
  bool isError = false;

  Future<void> fetchModifierGroups() async {
    const String apiUrl =
        "https://megameal.twilightparadox.com/pos/setting/modifier_group/?vendorId=1&page=1&page_size=10";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          modifierGroups = data['results'];
          isLoading = false;
        });
      } else {
        setState(() {
          isError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false;
      });
    }
  }

  Future<void> deleteModifierGroup(int id) async {
    final String apiUrl =
        "https://megameal.twilightparadox.com/pos/setting/modifier_group/$id/?vendorId=1";

    try {
      final response = await http.delete(Uri.parse(apiUrl));
      if (response.statusCode == 204) {
        setState(() {
          modifierGroups.removeWhere((group) => group['id'] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Modifier deleted successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete modifier')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting modifier')),
      );
    }
  }

  void navigateToEditModifierScreen(Map<String, dynamic> group) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditModifierScreen(modifierData: group),
      ),
    );
    fetchModifierGroups(); // Refresh the list after editing
  }

  @override
  void initState() {
    super.initState();
    fetchModifierGroups();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (isError) {
      return Center(
        child: Text(
          'Error fetching data. Please try again later.',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('View Modifier Groups')),
      body: modifierGroups.isEmpty
          ? Center(
              child: Text(
                'No Modifier Groups available.',
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.builder(
              itemCount: modifierGroups.length,
              itemBuilder: (context, index) {
                final group = modifierGroups[index];
                return Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          group['name'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'PLU: ${group['PLU'] ?? 'N/A'}',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Description: ${group['modifier_group_description'] ?? 'N/A'}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Min Quantity: ${group['min']} | Max Quantity: ${group['max']}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Active: ${group['active'] ? "Yes" : "No"}',
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                navigateToEditModifierScreen(group);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                deleteModifierGroup(group['id']);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
