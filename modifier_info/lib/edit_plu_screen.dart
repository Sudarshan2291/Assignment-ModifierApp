import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditModifierScreen extends StatefulWidget {
  final Map<String, dynamic> modifierData;

  const EditModifierScreen({super.key, required this.modifierData});

  @override
  State<EditModifierScreen> createState() => _EditModifierScreenState();
}

class _EditModifierScreenState extends State<EditModifierScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _skuController;
  late TextEditingController _minController;
  late TextEditingController _maxController;

  @override
  void initState() {
    super.initState();
    _nameController =
        TextEditingController(text: widget.modifierData['name'] ?? '');
    _descriptionController = TextEditingController(
        text: widget.modifierData['modifier_group_description'] ?? '');
    _skuController =
        TextEditingController(text: widget.modifierData['PLU'] ?? '');
    _minController =
        TextEditingController(text: widget.modifierData['min'].toString());
    _maxController =
        TextEditingController(text: widget.modifierData['max'].toString());
  }

  Future<void> updateModifierGroup() async {
    final String apiUrl =
        "https://megameal.twilightparadox.com/pos/setting/modifier_group/${widget.modifierData['id']}/?vendorId=1";

    final body = {
      "PLU": _skuController.text,
      "name": _nameController.text,
      "modifier_group_description": _descriptionController.text,
      "min": int.parse(_minController.text),
      "max": int.parse(_maxController.text),
      "active": true,
      "vendorId": 1,
    };

    try {
      final response = await http.patch(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Modifier updated successfully')),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update modifier')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating modifier')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Modifier')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextFormField(
                controller: _skuController,
                decoration: InputDecoration(labelText: 'PLU (SKU)'),
              ),
              TextFormField(
                controller: _minController,
                decoration: InputDecoration(labelText: 'Min Quantity'),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _maxController,
                decoration: InputDecoration(labelText: 'Max Quantity'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updateModifierGroup();
                  }
                },
                child: Text('Update Modifier'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
