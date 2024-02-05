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
  bool _error = false;

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
      _error = false;
      _loading = true;
      _currentAnswer = '';
    });

    try {
      String answer = await _magicBallService.getMagicAnswer();
      setState(() {
        _error = false;
        _currentAnswer = answer;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _currentAnswer = 'Error fetching answer';
        _loading = false;
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 136.0,
            ),
            GestureDetector(
              onTap: () {
                _fetchAnswer();
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 354,
                    height: 354,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: _loading
                            ? AssetImage('assets/ball_loading.png')
                            : _error
                                ? AssetImage('assets/ball_error.png')
                                : AssetImage('assets/ball_answer.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  if (_loading)
                    CircularProgressIndicator() // Loading indicator
                  else
                    Padding(
                      padding: const EdgeInsets.all(85.0),
                      child: Text(
                        _currentAnswer,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.displayLarge!,
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 54,
            ),
            Image.asset(_loading
                ? 'assets/shade_loading.png'
                : _error
                    ? 'assets/shade_error.png'
                    : 'assets/shade_answer.png'),
            SizedBox(
              height: 47,
            ),
            Container(
              width: 175,
              height: 74,
              child: Text('Нажмите на шар или потрясите телефон',
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                  style: Theme.of(context).textTheme.bodyMedium!),
            ),
          ],
        ),
      ),
    );
  }

  inProcess() {}
}
