import './question.dart';

class Quiz{
  List<Question> _questions;
  int _currentQuestIndex = -1;
  int _score = 0;

  Quiz(this._questions){
    _questions.shuffle();
  }

  int get score => _score;
  List<Question> get questions => _questions;
  int get length => _questions.length;
  int get questionNumber => _currentQuestIndex + 1;

  Question get nextQuestion {
    _currentQuestIndex++;
    if (_currentQuestIndex >= length) return null;
    return questions[_currentQuestIndex];
  }

  void answer(bool isCorrect){
    if (isCorrect) _score++;
  }
}