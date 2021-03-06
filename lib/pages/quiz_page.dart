import 'package:flutter/material.dart';

import '../ui/answer_button.dart';
import '../ui/currect_wrong_overlay.dart';
import '../ui/question_text.dart';
import '../utils/question.dart';
import '../utils/quiz.dart';
import 'score_page.dart';

class QuizPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question? currentQuestion;
  Quiz quiz = new Quiz([
    new Question("Superman is human?", false),
    new Question("Piza is healthy?", false),
    new Question("Flutter is awesome?", true)
  ]);

  String? questionText;
  int? questionNumber;
  bool? isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();

    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion!.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion!.answer == answer);
    quiz.answer(isCorrect!);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () => handleAnswer(true)),
            new QuestionText(questionText!, questionNumber!),
            new AnswerButton(false, () => handleAnswer(false))
          ],
        ),
        overlayShouldBeVisible
            ? new CorrectWrongOverlay(isCorrect!, () {
                if (questionNumber! >= quiz.length) {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new ScorePage(quiz.score, quiz.length)),
                      (Route route) => route == null);
                  return;
                }
                currentQuestion = quiz.nextQuestion;
                this.setState(() {
                  overlayShouldBeVisible = false;
                  questionText = currentQuestion!.question;
                  questionNumber = quiz.questionNumber;
                });
              })
            : new Container()
      ],
    );
  }
}
