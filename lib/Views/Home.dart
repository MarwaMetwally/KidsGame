import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:audioplayers/audio_cache.dart';
import 'package:kids_game/Views/test.dart';
import 'package:kids_game/Widgets/test.dart';
import 'package:kids_game/mediaquery/Mediaquery.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static AudioCache player = AudioCache(prefix: "sounds/");
  @override
  void initState() {
    
    player.play("sunnyday.mp3");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/backgroundImage.jpg"),
                        fit: BoxFit.fill)),
                child: Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      SizedBox(
                        height: getkDeviceHeightFactor(context, 180),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Wrap(
                          textDirection: TextDirection.rtl,
                          spacing: 10,
                          children: mywidget,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: getkDeviceWidthFactor(context, 100),
                child: Lottie.asset(
                  "assets/sun.json",
                  width: getkDeviceWidthFactor(context, 200),
                  height: getkDeviceHeightFactor(context, 200),
                ),
              ),
              Positioned(
                bottom: getkDeviceHeightFactor(context, 50),
                right: getkDeviceWidthFactor(context, 100),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Test(),
                      )),
                  child: Container(
                    width: getkDeviceWidthFactor(context, 190),
                    padding: EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                      "اختبر نفسك",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    )),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        Colors.red[700],
                        Colors.blue[700],
                        Colors.purple[700],
                      ]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
