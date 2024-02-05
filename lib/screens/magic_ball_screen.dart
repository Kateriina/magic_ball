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
                        image: AssetImage('assets/magic_ball.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(60.0),
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
            Image.asset('assets/shade.png'),
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
}
