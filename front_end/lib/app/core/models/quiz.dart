import 'question.dart';
import 'test.dart';

class Quiz {
  final int id;
  final String subject;
  final String title;
  final int time;
  final List<Question> questions;
  final List<Test> tests;

  Quiz({
    required this.id,
    required this.subject,
    required this.title,
    required this.time,
    required this.questions,
    required this.tests,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'subject': subject,
      'title': title,
      'time': time,
      'questions': questions.map((x) => x.toJson()).toList(),
      'tests': tests.map((x) => x.toJson()).toList(),
    };
  }

  factory Quiz.fromJson(Map<String, dynamic> map) {
    return Quiz(
      id: map['id'] as int,
      subject: map['subject'] as String,
      title: map['title'] as String,
      time: map['time'] as int,
      questions: List<Question>.from(
        (map['questions'] as List).map<Question>(
          (x) => Question.fromJson(x as Map<String, dynamic>),
        ),
      ),
      tests: List<Test>.from(
        (map['tests'] as List).map<Test>(
          (x) => Test.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Quiz copyWith({
    int? id,
    String? subject,
    String? title,
    int? time,
    List<Question>? questions,
    List<Test>? tests,
  }) {
    return Quiz(
      id: id ?? this.id,
      subject: subject ?? this.subject,
      title: title ?? this.title,
      time: time ?? this.time,
      questions: questions ?? this.questions,
      tests: tests ?? this.tests,
    );
  }
}
