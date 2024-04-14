// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'answer.dart';

class Question {
  final String content;
  final List<Answer> answers;

  Question({required this.content, required this.answers});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'answers': answers.map((x) => x.toMap()).toList(),
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      content: map['content'] as String,
      answers: List<Answer>.from(
        (map['answers'] as List).map<Answer>(
          (x) => Answer.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);

  Question copyWith({
    String? content,
    List<Answer>? answers,
  }) {
    return Question(
      content: content ?? this.content,
      answers: answers ?? this.answers,
    );
  }
}
