import 'package:flutter/material.dart';
import 'package:magic_ball/design/demensions.dart';

import 'screens/magic_ball_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

/// App,s main widget.
class MyApp extends StatelessWidget {
  /// Constructor for [MyApp].
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'Lato',
        textTheme: TextTheme(
          displayLarge: TextStyle(color: Color(0xFF6C698C), fontSize: fontSize32),
          bodyMedium: TextStyle(color: Color(0xFF6C698C), fontSize: fontSize16),
        ),
      ),
      home: MagicBallScreen(),
    );
  }
}
