import 'question.dart';

class QuizLogic {
  int _questionNumber = 0;

  final List<Question> _questionBank = [
    Question('Phila is the oldest Bhengu child', false),
    Question('Don Bhengu\'s real name is Donald', true),
    Question('Grace is Don Bhengu\'s third wife', false),
  ];

  String getQuestion() => _questionBank[_questionNumber].questionText;

  bool getAnswer() => _questionBank[_questionNumber].questionAnswer;

  void nextQuestion() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  int isFinished() => _questionBank.length - 1;

  int restartQuiz() => _questionNumber = 0;
}
