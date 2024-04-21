import 'package:chatott/data/data_sources/auth_remote_data_source_impl.dart';
import 'package:chatott/data/repositories/auth_repository_impl.dart';
import 'package:chatott/domain/entities/user.dart';
import 'package:chatott/domain/use_cases/sign_in_uc.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  late User _authUser;
  late AuthRemoteDataSourceImpl _dataSource;
  late AuthRepositoryImpl _repository;

  @override
  void initState() {
    super.initState();
    _dataSource = AuthRemoteDataSourceImpl();
    _repository = AuthRepositoryImpl(remoteDataSource: _dataSource);
    _authUser = _repository.storeUser;
    _usernameController.text = _authUser.username;
  }

  @override
  void dispose() {
    _usernameController.dispose();
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
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                if (constraints.maxWidth > 600) {
                  return _inputFieldWeb(context);
                } else {
                  return _inputField(context);
                }
              },
            ),
            _forgotPassword(context),
            _signup(context),
          ],
        ),
      ),
    );
  }

  _refresh() {
    setState(() {
      _authUser = _repository.storeUser;
      _usernameController.text = _authUser.username;
    });
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
          controller: _usernameController,
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
          onPressed: () => _login(
              context, _usernameController.text, _passwordController.text),
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

  _inputFieldWeb(context) {
    return SizedBox(
      width: 400,
      child: Card.outlined(
        shape: BeveledRectangleBorder(),
        elevation: 10,
        margin: EdgeInsets.all(10),
        surfaceTintColor: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Username",
                    fillColor: Colors.white,
                    prefixIcon: const Icon(Icons.person),
                    filled: true,
                  ),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  controller: _usernameController,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    fillColor: Colors.white,
                    filled: true,
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  obscureText: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => _login(context, _usernameController.text,
                      _passwordController.text),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                )
              ],
            )),
      ),
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
              Navigator.pushNamed(context, '/signup').then((_) {
                _refresh();
              });
            },
            child: const Text(
              "Sign Up",
              style: TextStyle(color: Colors.blueAccent),
            ))
      ],
    );
  }

  void _login(context, username, password) async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    final snackBar = SnackBar(
      content: const Text('Invalid username or password!'),
      duration: const Duration(seconds: 2),
    );
    if (_validatePassword(context, password)) {
      try {
        _authUser = await SignInUseCase(repository: _repository)
            .call(SignInParams(username: username, password: password));
        // route to home screen
        if (_authUser != User.empty) {
          Navigator.pushNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      } on Exception {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
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
