import 'answer.dart';

class Question {
  final int id;
  final String content;
  final List<Answer> answers;

  Question({
    this.id = -1,
    required this.content,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
      'answers': answers.map((x) => x.toJson()).toList(),
    };
  }

  factory Question.fromJson(Map<String, dynamic> map) {
    return Question(
      id: map['id'] != null
          ? map['id'] as int
          : map['questionId'] != null
              ? map['questionId'] as int
              : -1,
      content: map['content'] as String,
      answers: List<Answer>.from(
        (map['answers'] as List).map<Answer>(
          (x) => Answer.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
