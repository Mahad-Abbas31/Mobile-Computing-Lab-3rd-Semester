import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String role;

  const ProfilePage({
    super.key,
    required this.name,
    required this.role,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0B1120),

      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Color(0xFF111827),
        foregroundColor: Color(0xFFFDF2F8),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Color(0xFFF9A8D4),
              child: Icon(
                Icons.person,
                size: 60,
                color: Color(0xFF0B1120),
              ),
            ),

            SizedBox(height: 20),

            Text(
              name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF9A8D4),
              ),
            ),

            SizedBox(height: 10),

            Text(
              role,
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFFD1D5DB),
              ),
            ),

            SizedBox(height: 25),

            // Elevated Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFF9A8D4),
                foregroundColor: Color(0xFF0B1120),
              ),
              onPressed: () {
                print('Edit Profile Clicked');
              },
              child: Text('Edit Profile'),
            ),

            SizedBox(height: 15),

            // Outlined Button
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: Color(0xFFF9A8D4),
                side: BorderSide(
                  color: Color(0xFFF9A8D4),
                ),
              ),
              onPressed: () {
                print('View Details Clicked');
              },
              child: Text('View Details'),
            ),

            SizedBox(height: 15),

            // Text Button
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Color(0xFFF9A8D4),
              ),
              onPressed: () {
                print('Settings Clicked');
              },
              child: Text('Settings'),
            ),

            SizedBox(height: 15),

            // Icon Button
            IconButton(
              onPressed: () {
                print('Favorite Clicked');
              },
              icon: Icon(Icons.favorite),
              color: Color(0xFFF9A8D4),
              iconSize: 30,
            ),

            SizedBox(height: 15),

            // Go Back Button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF1F2937),
                foregroundColor: Color(0xFFFDF2F8),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF9A8D4),
        foregroundColor: Color(0xFF0B1120),
        onPressed: () {
          print('Add Button Clicked');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
