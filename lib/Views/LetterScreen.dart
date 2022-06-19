import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:kids_game/mediaquery/Mediaquery.dart';

class LetterScreen extends StatefulWidget {
  final String letterImage;
  final String letterNamee;
  final String letterSound;
  final String example1;
  final String example2;
  final String example1Pic;
  final String example2Pic;

  LetterScreen(
      {@required this.letterImage,
      this.letterNamee,
      this.example1Pic,
      this.example2Pic,
      this.letterSound,
      this.example1,
      this.example2});

  @override
  _LetterScreenState createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  static AudioCache player = AudioCache(prefix: "sounds/");
  AudioPlayer audioPlayer = AudioPlayer();
  @override
  void dispose() {
    audioPlayer.dispose();

    super.dispose();
  }

  void playSong() async {
    audioPlayer = await player.play(
      widget.letterSound,
    );
  }

  @override
  void initState() {
    playSong();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 40),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton(
              elevation: 5,
              backgroundColor: Colors.purple,
              onPressed: () {
                player.clearCache();
                Navigator.pop(context);
              },
              child: Center(
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("images/backgroundImage.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Center(
                child: Hero(
                  tag: widget.letterNamee,
                  child: GestureDetector(
                    onTap: () async {
                      await audioPlayer.stop();

                      playSong();
                    },
                    child: Image(
                      image: AssetImage(widget.letterImage),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getkDeviceHeightFactor(context, 40),
              ),
              AnimalExample(
                animalImage: widget.example1Pic,
                name: widget.example1,
              ),
              SizedBox(
                height: getkDeviceHeightFactor(context, 50),
              ),
              AnimalExample(
                animalImage: widget.example2Pic,
                name: widget.example2,
              )
            ],
          ),
        ));
  }
}

class AnimalExample extends StatelessWidget {
  const AnimalExample({
    Key key,
    @required this.animalImage,
    @required this.name,
  }) : super(key: key);

  final String animalImage;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(animalImage),
                )),
            width: getkDeviceWidthFactor(context, 120),
            height: getkDeviceHeightFactor(context, 120),
          ),
          Text(
            name,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
