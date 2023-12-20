import 'dart:convert';

import 'package:api_practice/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<User> users = [];

  void fetchUsers() async{
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    setState(() {
      users = results.map((e) {
        return User(
          gender: e['gender'], 
          email: e['email'], 
          phone: e['phone'], 
          cell: e['cell'], 
          nat: e['nat'],
        );
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API PARCTICE', textAlign: TextAlign.center,),
      ),
      body: ListView.builder(
        itemCount: users.length, 
        itemBuilder: (context, index) {
          final user = users[index];
          final color = user.gender == 'male' ? Colors.green : Colors.yellow;
        return ListTile(
          title: Text(user.phone),
          subtitle: Text(user.email),
          tileColor: color,
          
        );
      },),

      floatingActionButton: FloatingActionButton(onPressed: fetchUsers, backgroundColor: const Color.fromARGB(255, 240, 75, 25),
      ),
    );
  }
}