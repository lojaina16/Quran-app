import 'package:flutter/material.dart';
import 'package:quran_app/api_manager.dart';
import 'package:quran_app/model/usersResponse.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "homeScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quran App",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.brown,
        centerTitle: true,
      ),
      body: FutureBuilder<List<UsersResponse>>(
        future: ApiManager.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found'));
          } else {
            List<UsersResponse> users = snapshot.data!;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].name ?? "No Name"),
                  subtitle: Text(users[index].email ?? "No Email"),
                );
              },
            );
          }
        },
      ),
    );
  }
}
