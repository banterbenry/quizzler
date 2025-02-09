import 'package:flutter/material.dart';
import 'quiz_logic.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> scoreKeeper = [];

  int correctAnswers = 0;

  QuizLogic quizlogic = QuizLogic();

  void checkAnswer(bool selectedAnswer) {
    bool questionAnswer = quizlogic.getAnswer();
    if (selectedAnswer == questionAnswer) {
      scoreKeeper.add(
        const Icon(Icons.check, color: Colors.green),
      );
      correctAnswers++;
    } else {
      scoreKeeper.add(
        const Icon(Icons.close, color: Colors.red),
      );
    }

    setState(() {
      int quizComplete = quizlogic.isFinished();
      if (scoreKeeper.length > quizComplete) {
        Alert(
          context: context,
          type: AlertType.info,
          title: "RFLUTTER ALERT",
          desc:
              "The Quiz has ended. You got $correctAnswers out of ${scoreKeeper.length}",
          buttons: [
            DialogButton(
              onPressed: () {
                setState(() {
                  scoreKeeper.clear();
                  Navigator.pop(context);
                  correctAnswers = 0;
                  quizlogic.restartQuiz();
                });
              },

              width: 125,
              child: Text(
                "Restart Quiz",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Center(
                child: Text(
                  quizlogic.getQuestion(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    checkAnswer(true);
                    quizlogic.nextQuestion();
                  },
                  child: const Text('True',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    checkAnswer(false);
                    quizlogic.nextQuestion();
                  },
                  child: const Text('False',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ),
              ),
            ),
            Row(
              children: scoreKeeper,
            )
          ],
        ),
      ),
    );
  }
}
