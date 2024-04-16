import 'answer.dart';

class Question {
  final String content;
  final List<Answer> answers;

  Question({required this.content, required this.answers});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
      'answers': answers.map((x) => x.toJson()).toList(),
    };
  }

  factory Question.fromJson(Map<String, dynamic> map) {
    return Question(
      content: map['content'] as String,
      answers: List<Answer>.from(
        (map['answers'] as List).map<Answer>(
          (x) => Answer.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
