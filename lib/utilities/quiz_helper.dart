import '../models/question.dart';

class QuizHelper {
  int _questionNumber = 0;

  List<Question> _questionList = [
    Question('The capital of Turkey is Ankara.', true),
    Question('Water boils at 100 degrees Celsius.', true),
    Question('Flutter is an open source framework by Google.', true),
    Question('First month of the year is February.', false),
    Question('The last day of the week is Tuesday.', false),

  ];

  void nextQuestion() {
    if (_questionNumber < _questionList.length - 1) {
      _questionNumber++;
    }
  }

  double? loadingProcessValue() {
    return _questionNumber / _questionList.length;
  }

  String getQuestionText() {
    return _questionList[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionList[_questionNumber].questionAnswer;
  }


  bool isFinished() {
    if (_questionNumber >= _questionList.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}