import 'dart:io';
import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'user_model.dart';

class SliderScreen extends StatelessWidget {
  SliderScreen({super.key});
  final DBHelper dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Users')),
      body: FutureBuilder<List<UserModel>>(
        future: dbHelper.getUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final users = snapshot.data!;
          return PageView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.file(File(user.imagePath), height: 200),
                    Text(user.name, style: TextStyle(fontSize: 20)),
                    Text(user.email),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
