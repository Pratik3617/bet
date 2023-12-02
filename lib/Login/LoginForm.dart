import 'package:bet/Home.dart';
import 'package:flutter/material.dart';
import '../API/Login_Api.dart';
import 'package:bet/providers/LoginProvider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final response = await userLogin(username, password);
      print(response['username']);

      if (response['message'] == 'Login successful') {
        context.read<UserProvider>().setUser(response['username']);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(),
            ),
          );
      } else {
        print('User does not exist');
      }
    } catch (e) {
      print('Error during login: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              hintText: 'Enter your username',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter your password',
            ),
          ),
          SizedBox(height: 44),
          ElevatedButton(
            onPressed: ()=> _login(context),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurpleAccent), 
            ),
            child: Text('Sign In',style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold, letterSpacing: 1),),
          ),
        ],
      ),
    );
  }
}