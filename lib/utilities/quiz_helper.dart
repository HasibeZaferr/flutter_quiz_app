import '../models/question.dart';

class QuizHelper {
  int _questionNumber = 0;

  final List<Question> _questionList = [
    Question('The capital of Turkey is Ankara.', true),
    Question('Water boils at 100 degrees Celsius.', true),
    Question('Flutter is an open source framework by Google.', true),
    Question('First month of the year is February.', false),
    Question('The last day of the week is Tuesday.', false),
  ];

  void nextQuestion() {
    if (_questionNumber < _questionList.length - 1) _questionNumber++;
  }

  double? loadingProcessValue() => _questionNumber / _questionList.length;

  String getQuestionText() => _questionList[_questionNumber].questionText;

  bool getCorrectAnswer() => _questionList[_questionNumber].questionAnswer;

  bool isFinished() => _questionNumber >= _questionList.length - 1;

  void reset() => _questionNumber = 0;
}
