import 'package:flutter/material.dart';
import 'profile.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
  scaffoldBackgroundColor: Color(0xFF0B1120),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFFF9A8D4),
    primary: Color(0xFFF9A8D4),
    secondary: Color(0xFFFDF2F8),
    surface: Color(0xFF0B1120),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF111827),
    foregroundColor: Color(0xFFFDF2F8),
  ),
),
    home: MainPage(),
  ));
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Main Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.home,
              size: 80,
              color: Color(0xFFEC4899),
            ),

            SizedBox(height: 20),

            Text(
              'Welcome to Home Page',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF172554),
              ),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEC4899),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      name: 'Mahad Abbas',
                      role: 'Founder & CEO DigiHust',
                    ),
                  ),
                );
              },
              child: Text('Open Profile'),
            ),
          ],
        ),
      ),
    );
  }
}