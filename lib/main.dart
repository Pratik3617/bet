import 'package:bet/Accounts.dart';
import 'package:bet/Home/Barcode.dart';
import 'package:bet/Home/HomeRight.dart';
import 'package:bet/Login/Login.dart';
import 'package:bet/Result.dart';
import 'package:bet/providers/game_selector.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Home.dart';
import 'Result.dart';

const TextStyle customTextStyle = TextStyle(
  fontFamily: 'SansSerif', // Use the font family you specified in pubspec.yaml
  fontSize: 16.0,
  fontWeight: FontWeight.normal,
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameSelector()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyText2: customTextStyle,
          ),
        ),
        home: const Home(),
        routes: {
          '/result': (_) => Result(),
          '/accounts': (_) => Accounts(),
          '/login': (_) => const Login(),
        },

      ),
    ),
  );
}

