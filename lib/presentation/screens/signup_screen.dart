import 'package:chatott/assets/assets.dart';
import 'package:chatott/data/data_sources/auth_remote_data_source.dart';
import 'package:chatott/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:chatott/data/repositories/auth_repository_impl.dart';
import 'package:chatott/domain/entities/auth_user.dart';
import 'package:chatott/domain/repositories/auth_repositories.dart';
import 'package:chatott/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();
  var _authUser = AuthUser.empty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _header(),
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth > 600) {
                      return _inputFieldWeb(context);
                    } else {
                      return _inputField(context);
                    }
                  },
                ),
                _footer(context)
              ]),
        ),
      ),
    );
  }

  Row _footer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text("Already have an account?"),
        TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.blueAccent),
            ))
      ],
    );
  }

  Column _inputField(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
              hintText: "Username",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.blueAccent.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.person)),
          controller: _usernameController,
        ),
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none),
              fillColor: Colors.blueAccent.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email)),
          controller: _emailController,
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: "Confirm Password",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: Colors.blueAccent.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
          controller: _confirmPasswordController,
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () =>
              _signUp(context, _emailController.text, _passwordController.text),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text(
            "Sign up",
            style: TextStyle(fontSize: 20),
          ),
        ),
        const Center(child: Text("Or")),
        Container(
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Colors.blueAccent,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: TextButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 30.0,
                  width: 30.0,
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://picsum.photos/id/123/200/200"),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 18),
                const Text(
                  "Sign In with Google",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _inputFieldWeb(context) {
    return SizedBox(
      width: 500,
      child: Card.outlined(
        shape: BeveledRectangleBorder(),
        elevation: 10,
        margin: EdgeInsets.all(10),
        surfaceTintColor: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "Username",
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      ),
                      style: TextStyle(
                          fontSize: 15,
                        ),
                  controller: _usernameController,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                      hintText: "Email",
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.email)
                      ),
                      style: TextStyle(
                          fontSize: 15,
                          ),
                  controller: _emailController,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.password),
                  ),
                  style: TextStyle(
                          fontSize: 15,
                          ),
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    fillColor: Colors.white,
                      filled: true,
                    prefixIcon: const Icon(Icons.password),
                  ),
                  style: TextStyle(
                          fontSize: 15,
                          ),
                  obscureText: true,
                  controller: _confirmPasswordController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _signUp(
                      context, _emailController.text, _passwordController.text),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent,
                    fixedSize: Size.fromHeight(45)
                  ),
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                const Center(child: Text("Or")),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 30.0,
                          width: 30.0,
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: NetworkImage(
                                    "https://picsum.photos/id/123/200/200"),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 18),
                        const Text(
                          "Sign In with Google",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
      ),
    );
  }

  Column _header() {
    return Column(
      children: <Widget>[
        const SizedBox(height: 60.0),
        const Text(
          "Sign up",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Create your account",
          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
        )
      ],
    );
  }

  void _signUp(context, email, password) async {
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
          _authUser = await SignUpUseCase(authRepository: repository)
              .call(SignUpParams(email: email, password: password));
          // route to home screen
          if (_authUser != AuthUser.empty) {
            Navigator.pop(context);
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
