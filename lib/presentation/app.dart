// app.dart
import 'package:chatott/presentation/screens/chat_box_screen.dart';
import 'package:chatott/presentation/screens/home_screen.dart';
import 'package:chatott/presentation/screens/login_screen.dart';
import 'package:chatott/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const HomeScreen(),
          '/chat': (context) => const ChatBoxScreen(),
        });
  }
}
