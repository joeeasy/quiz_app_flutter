import 'package:flutter/material.dart';
import 'package:quizzler/questions_controller.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuestionController _questionController = QuestionController();
  List<Icon> scoreKeeper = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                _questionController.question(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                handleOnPress(true, context);
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                handleOnPress(false, context);

              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }

  void handleOnPress(bool selectedAnswer, BuildContext _context) {
    bool correctAnswer = _questionController.questionAnswer();
    if(_questionController.isLast()) {
      Alert(
        context: context,
        type: AlertType.success,
        title: "End Of Question",
        desc: "You've gotten to the end of this quiz",
        buttons: [
          DialogButton(
            child: Text(
              "Reset Quiz",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                scoreKeeper = [];
                _questionController.resetIndex();

              });
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    } else {
      if(selectedAnswer == correctAnswer)  {
        setState(() {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green,));
          _questionController.nextQuestion();
        });


      } else {
        setState(() {
          _questionController.nextQuestion();
          scoreKeeper.add(Icon(Icons.cancel, color: Colors.red,));
        });

      }
    }

  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
