import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final _loginFormKey = GlobalKey<FormState>();
  TextEditingController _usernameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              hintText: 'Enter your username',
            ),
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
          ),
          SizedBox(height: 44),
          ElevatedButton(
            onPressed: () {
              // Add your login logic here
            },
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