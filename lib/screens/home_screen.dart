import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:retrofit_app/api_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? firstName;
  String? email;
  String? lastName;
  String? gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Text("Fetch User"),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(
                      firstName ?? '',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                "Last Name :${lastName ?? ""}",
                  style: TextStyle(fontSize: 18),
                )
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<UserDetails> fetchDetails() async {
    final client = ApiClient(
      Dio(
        BaseOptions(
          contentType: "application/json",
          // connectTimeout: Duration(seconds: 30),
        ),
      ),
    );
    try {
      final response = await client.getUserDetails();

      return response;
    } catch (e) {
      throw Exception("Something went wrong");
    }
  }
}

class UserDetails {
  final String gender;
  final String firstName;
  final String lastName;
  final String email;

  UserDetails(
      {required this.gender,
      required this.firstName,
      required this.lastName,
      required this.email});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
        gender: json['results'][0]['gender'],
        firstName: json['results'][0]['name']['first'],
        lastName: json['results'][0]['name']['last'],
        email: json['results'][0]['email']);
  }
}
