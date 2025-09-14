import 'package:flutter/material.dart';
import 'register.dart';
import 'dashboard.dart';
import 'login.dart';
import 'editprofile.dart';
import 'note.dart';
import 'findthematch.dart'; // Include findthematch page
import 'message.dart';      // Include message page
import 'chat.dart';         // Include chat page
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
        '/findthematch': (context) => const FindTheMatchPage(),
        '/message': (context) => const MessagePage(),
        '/chat': (context) => const ChatPage(
          contactUsername: '',
          contactAvatarUrl: '',
        ), // Update to pass real data via Navigator
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/editprofile') {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          return MaterialPageRoute(
            builder: (context) => EditProfilePage(
              name: args['name'] as String? ?? '',
              initialDob: args['dob'] as String? ?? '',
              initialImage: args['image'] as String?,
              initialLocation: args['location'] as String?,
              initialGalleryImages: (args['galleryImages'] as List<dynamic>?)?.cast<String>(),
              initialNotes: (args['notes'] as List<dynamic>?)?.cast<String>(),
            ),
          );
        }
        if (settings.name == '/chat') {
          final args = settings.arguments as Map<String, dynamic>? ?? {};
          return MaterialPageRoute(
            builder: (context) => ChatPage(
              contactUsername: args['contactUsername'] ?? '',
              contactAvatarUrl: args['contactAvatarUrl'] ?? '',
            ),
          );
        }
        return null;
      },
    );
  }
}
