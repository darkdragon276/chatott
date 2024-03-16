import 'package:chatott/data/data_sources/auth_remote_data_source.dart';
import 'package:chatott/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:chatott/data/repositories/auth_repository_impl.dart';
import 'package:chatott/domain/entities/auth_user.dart';
import 'package:chatott/domain/repositories/auth_repositories.dart';
import 'package:chatott/domain/use_cases/sign_in_use_case.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _authUser = AuthUser.empty;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _header(context),
            _inputField(context),
            _forgotPassword(context),
            _signup(context),
          ],
        ),
      ),
    );
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Welcome Back",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Enter your credential to login"),
      ],
    );
  }

  _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.blueAccent.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
          controller: _emailController,
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.blueAccent.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
          controller: _passwordController,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () =>
              _login(context, _emailController.text, _passwordController.text),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20),
          ),
        )
      ],
    );
  }

  _forgotPassword(context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Colors.blueAccent),
      ),
    );
  }

  _signup(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Dont have an account? "),
        TextButton(
            onPressed: () {
              Navigator.pushNamed(context, '/signup');
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.blueAccent),
            ))
      ],
    );
  }

  void _login(context, email, password) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: const Text('Invalid email address or password!'),
      duration: const Duration(seconds: 2),
    );
    if (_validateEmail(context, email)) {
      if (_validatePassword(context, password)) {
        try {
          final AuthRemoteDataSource dataSource = AuthRemoteDataSourceImpl();
          final AuthRepository repository =
              AuthRepositoryImpl(remoteDataSource: dataSource);
          _authUser = await SignInUseCase(repository: repository)
              .call(SignInParams(email: email, password: password));
          // route to home screen
          if (_authUser != AuthUser.empty) {
            Navigator.pushNamed(context, '/home');
          } else {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        } on ArgumentError {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }

  bool _validateEmail(context, String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: const Text('Invalid email address!'),
      duration: const Duration(seconds: 10),
    );
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    if (emailValid) {
      print(value);
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  bool _validatePassword(context, password) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: const Text('Password must be at least 6 characters long!'),
      duration: const Duration(seconds: 10),
    );
    if (password.length >= 6) {
      print(password);
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }
}
