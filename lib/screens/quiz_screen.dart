import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/utilities/quiz_helper.dart';

QuizHelper quizHelper = QuizHelper();

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Image> answerIconList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 45.0, left: 10.0, right: 10.0),
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blueGrey,
                  minHeight: 15,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                  value: quizHelper.loadingProcessValue(),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: answerIconList,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    quizHelper.getQuestionText(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  child: const Text(
                    'True',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(true);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: const Text(
                    'False',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    checkAnswer(false);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizHelper.getCorrectAnswer();

    setState(() {
      if (quizHelper.isFinished() == true) {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Finished'),
            content: const Text('Quiz is over.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Start Again'),
              ),
            ],
          ),
        );

        quizHelper.reset();
        answerIconList = [];
      } else {
        if (userPickedAnswer == correctAnswer) {
          answerIconList.add(
            const Image(
                image: AssetImage("assets/icons/true_icon.png"), height: 70.0),
          );
        } else {
          answerIconList.add(
            const Image(
                image: AssetImage("assets/icons/false_icon.png"), height: 70.0),
          );
        }
        quizHelper.nextQuestion();
      }
    });
  }
}
