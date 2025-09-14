import 'package:flutter/material.dart';
import 'register.dart';
import 'dashboard.dart';
import 'login.dart';
import 'editprofile.dart';
import 'note.dart'; // Import NotePage
import 'splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LoveLoom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Nunito',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/register': (context) => const RegisterPage(),
        '/login': (context) => const LoginPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/note': (context) => const NotePage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/editprofile') {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          return MaterialPageRoute(
            builder: (context) => EditProfilePage(
              initialName: args['name'] ?? '',
              initialDob: args['dob'] ?? '',
              initialImage: args['image'],
              initialLocation: args['location'],
              initialGalleryImages: args['galleryImages'],
              initialNotes: args['notes'],
            ),
          );
        }
        return null;
      },
    );
  }
}
