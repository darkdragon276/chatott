// app.dart
import 'package:chatott/presentation/screens/chat_box_screen.dart';
import 'package:chatott/presentation/screens/home_screen.dart';
import 'package:chatott/presentation/screens/login_screen.dart';
import 'package:chatott/presentation/screens/signup_screen.dart';
import 'package:chatott/presentation/screens/home_screen_web.dart';

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
      onGenerateRoute: (RouteSettings settings) {
        final args = settings.arguments;
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(
              builder: (context) => const HomeScreenWeb(),
            );
          case '/signup':
            return MaterialPageRoute(
              builder: (context) => const SignupScreen(),
            );
          case '/home':
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );
          case '/chat':
            return MaterialPageRoute(
              builder: (context) => ChatBoxScreen(conversationId: args as int),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            );
        }
      },
    );
  }
}
