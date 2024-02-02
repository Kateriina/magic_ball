import 'package:flutter/material.dart';
import 'package:magic_ball/services/magic_ball_service.dart';
import 'package:shake/shake.dart';

class MagicBallScreen extends StatefulWidget {
  @override
  _MagicBallScreenState createState() => _MagicBallScreenState();
}

class _MagicBallScreenState extends State<MagicBallScreen> {
  MagicBallService _magicBallService = MagicBallService();
  String _currentAnswer = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    ShakeDetector.autoStart(onPhoneShake: () {
      // Handle phone shake
      _fetchAnswer();
    });
  }

  @override
  void dispose() {
    //ShakeDetector.stop();
    super.dispose();
  }

  void _fetchAnswer() async {
    setState(() {
      _loading = true;
      _currentAnswer = '';
    });

    try {
      String answer = await _magicBallService.getMagicAnswer();
      setState(() {
        _currentAnswer = answer;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _currentAnswer = 'Error fetching answer';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magic Ball'),
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _fetchAnswer();
          },
          child: Stack(
            children: [
              Column(
                children: [
                  Image.asset('assets/magic_ball.png'), // Image of magic ball
                  Image.asset('assets/shade.png'),
                ],
              ), // Image of magic ball

              if (_loading)
                CircularProgressIndicator() // Loading indicator
              else
                Text(
                  _currentAnswer,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ), // Display answer
            ],
          ),
        ),
      ),
    );
  }
}
