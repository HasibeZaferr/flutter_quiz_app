import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/utilities/quiz_helper.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Widget> answerIconList = [];
  QuizHelper quizHelper = QuizHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blueGrey,
                  minHeight: 15,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.lightGreen),
                  value: quizHelper.loadingProcessValue(),
                ),
              ),
            ),
            SingleChildScrollView(
              //TODO? Sağa doğru kaymasını sağlar
              scrollDirection: Axis.horizontal,
              child: Row(
                children: answerIconList,
              ),
            ),
            Wrap(
              //TODO? Ekranın genilişliği dolduktan sonra alt satıra geçer
              children: answerIconList,
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
            checkAnswerButton(true),
            checkAnswerButton(false),
          ],
        ),
      ),
    );
  }

  Widget checkAnswerButton(bool answer) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: answer ? Colors.green : Colors.red,
          ),
          child: Text(
            answer ? 'True' : 'False',
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
          onPressed: () => checkAnswer(answer),
        ),
      ),
    );
  }

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = quizHelper.getCorrectAnswer();
    setState(() {
      var result = userPickedAnswer == correctAnswer;
      addIcon(result);
      quizHelper.isFinished()
          ? showDialog<String>(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('Finished'),
                content: const Text('Quiz is over.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      quizHelper.reset();
                      answerIconList.clear();
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text('Start Again'),
                  ),
                ],
              ),
            )
          : quizHelper.nextQuestion();
    });
  }

  void addIcon(bool answer) {
    double phoneWidth = MediaQuery.of(context).size.width;
    String iconPath =
        answer ? "assets/icons/true_icon.png" : "assets/icons/false_icon.png";
    answerIconList.add(
      Padding(
        padding: EdgeInsets.all(phoneWidth * 0.01),
        child: Image(
          image: AssetImage(iconPath),
          width: phoneWidth * 0.13,
        ),
      ),
    );
  }
}
