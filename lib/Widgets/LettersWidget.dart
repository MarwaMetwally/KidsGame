import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_game/Views/LetterScreen.dart';
import 'package:kids_game/mediaquery/Mediaquery.dart';

class LettersWidget extends StatelessWidget {
  final String letterName;
  final String letterExample1;
  final String letterExample2;
  final String letterSoundEffect;
  final String imagePicture;
  final String example1Image;
  final String example2Image;

  const LettersWidget({
    this.example1Image,
    this.example2Image,
    this.letterSoundEffect,
    this.letterExample1,
    this.letterExample2,
    this.letterName,
    this.imagePicture,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LetterScreen(
                letterImage: imagePicture,
                letterSound: letterSoundEffect,
                letterNamee: letterName,
                example1: letterExample1,
                example2: letterExample2,
                example1Pic: example1Image,
                example2Pic: example2Image,
              ),
            ));
      },
      child: Container(
        child: ClipRRect(
          child: Hero(
            tag: letterName,
            child: Image.asset(
              imagePicture,
              height: getkDeviceHeightFactor(context, 80),
              width: getkDeviceWidthFactor(context, 60),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
