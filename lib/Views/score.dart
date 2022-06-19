import 'package:kids_game/Views/Home.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:kids_game/Views/test.dart';
import 'package:kids_game/mediaquery/Mediaquery.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:flutter/services.dart';

class Score extends StatefulWidget {
  final int right;
  Score({this.right});

  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  AudioCache player = AudioCache(prefix: 'sounds/');

  Gradient gradient = LinearGradient(colors: [
    Colors.blueGrey,
    Colors.deepOrange,
    Colors.deepPurple,
  ]);
  @override
  void initState() {
    widget.right > 14 ? player.play("clap.mp3") : player.play("fail.mp3");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backgroundImage.jpg"),
                  fit: BoxFit.fill)),
          child: Center(
            child: Container(
              height: getkDeviceHeightFactor(context, 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget.right > 14
                      ? Lottie.asset('assets/17174-clap.json')
                      : Lottie.asset('assets/34175-sad-face.json',
                          width: getkDeviceHeightFactor(context, 150),
                          height: getkDeviceWidthFactor(context, 160)),
                  GradientText(
                    'Your Score is : ${widget.right} /28',
                    gradient: gradient,
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Color(0xff87d6fc),
                            onPressed: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (ctx) => HomePage())),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.home, color: Colors.blue),
                                Text('الصفحة الرئيسيه'),
                              ],
                            )),
                        FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)),
                            color: Color(0xffff8e89),
                            onPressed: () => Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (ctx) => Test())),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.refresh, color: Colors.blue),
                                Text('حاول مره أخري')
                              ],
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
