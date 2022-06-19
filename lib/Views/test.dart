import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:kids_game/Views/Home.dart';
import 'package:kids_game/Widgets/choice.dart';
import 'score.dart';
import 'dart:async';
import 'package:kids_game/mediaquery/Mediaquery.dart';
import 'package:flutter/services.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  Map<Image, bool> score = {};
  int shuffle = 0;

  int right = 0;
  Map<Image, Image> choice = choice1;
  int choiceee = 1;

  @override
  void initState() {
    score.keys.map((e) => print(e));
    shuffle = Random().nextInt(10);

    super.initState();
  }

  static AudioCache player = AudioCache(prefix: "sounds/");
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xffe08035),
        onPressed: () {
          setState(() {
            choiceee++;
            print(choiceee);
            if (choiceee == 2) {
              choice = choice2;
            } else if (choiceee == 3) {
              choice = choice3;
            } else if (choiceee == 4) {
              choice = choice4;
            } else if (choiceee == 5) {
              choice = choice5;
            } else if (choiceee == 6) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => Score(right: right)));
            }
          });
        },
        child: Icon(Icons.arrow_forward),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image: AssetImage(
                        'images/testbackground.jpg',
                      ),
                      fit: BoxFit.fill)),
              height: getkDeviceHeightFactor(context, 280),
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    left: 15,
                    top: 17,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffe08035),
                      radius: 25,
                      child: InkWell(
                          onTap: () => Navigator.push(context,
                              MaterialPageRoute(builder: (ctx) => HomePage())),
                          child:
                              Icon(Icons.home, size: 45, color: Colors.white)),
                    ),
                  ),
                  Positioned(
                    right: 46,
                    top: 48,
                    child: Text(
                      'Score: $right/28 ',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: getkDeviceHeightFactor(context, 40),
            ),
            Center(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      
                        ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: choice.keys
                          .map((answer) => buildDagTarget(answer))
                          .toList()
                            ..shuffle(Random((shuffle))),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: choice.keys.map((letter) {
                        return Draggable<Image>(
                          onDragCompleted: () {
                            if (score.length == 28) {
                              new Timer(Duration(milliseconds: 1), () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (ctx) => Score(right: right)));
                              });
                            }
                          },
                          data: letter,
                          child: Letter(
                              letter: score[letter] == true
                                  ? Image.asset("images/correct.jpg")
                                  : score[letter] == false
                                      ? Image.asset("images/wrong.jpg")
                                      : letter),
                          feedback: Letter(letter: letter),
                          childWhenDragging: Container(
                              height: getkDeviceHeightFactor(context, 60),
                              width: getkDeviceWidthFactor(context, 90),
                              color: Colors.transparent),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      width: getkDeviceWidthFactor(context, 13),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: getkDeviceHeightFactor(context, 5),
            )
          ],
        ),
      ),
    );
  }

  Widget buildDagTarget(letter) {
    return DragTarget<Image>(
        builder: (BuildContext context, List<Image> incoming, List rejected) {
  
          return Container(
              margin: EdgeInsets.only(bottom: 7),
              child: choice[letter],
              width: getkDeviceWidthFactor(context, 90),
              height: getkDeviceHeightFactor(context, 60));
        },
 
        onAccept: (data) {
          if (data == letter) {
            if (!score.containsKey(letter)) {
              setState(() {
                score[letter] = true;
      
                print('dataaa 1 $data');
                right++;
              });

              player.play('correct.mp3');
            }
          } else {
            if (!score.containsKey(data)) {
              setState(() {
       
                print('dataaa $data');
                score[data] = false;
             
              });

              player.play('wrong answer.mp3');
            }
          }

        
        },
        onLeave: (data) {});
  }
}

class Letter extends StatelessWidget {
  final Image letter;
  Letter({this.letter});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        margin: EdgeInsets.only(bottom: 7, left: 27, right: 10),
        alignment: Alignment.center,
        height: getkDeviceHeightFactor(context, 60),
        width: getkDeviceWidthFactor(context, 90),
        child: Container(
          margin: EdgeInsets.only(bottom: 7, left: 27, right: 10),
          child: letter,
        ),
      ),
    );
  }
}
