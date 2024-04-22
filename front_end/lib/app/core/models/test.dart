import 'candidate.dart';
import 'quiz.dart';

class Test {
  final int id;
  final String title;
  final DateTime timeCreated;
  final String quizCode;
  final String? note;
  final Quiz quiz;
  final List<Candidate> candidates;
  final DateTime timeStart;
  final DateTime timeEnd;

  Test({
    required this.id,
    required this.title,
    required this.timeCreated,
    required this.quizCode,
    this.note,
    required this.quiz,
    required this.candidates,
    required this.timeStart,
    required this.timeEnd,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'timeCreated': timeCreated.toString(),
      'quizCode': quizCode,
      'note': note,
    };
  }

  factory Test.fromJson(Map<String, dynamic> map) {
    return Test(
      id: map['id'] as int,
      title: map['title'] as String,
      timeCreated: DateTime.parse(map['timeCreated'] as String),
      quizCode: map['quizCode'] as String,
      note: map['note'] != null ? map['note'] as String : null,
      quiz: Quiz.fromJson(map['quiz']),
      candidates: map['candidates'] != null
          ? (map['candidates'] as List)
              .map((e) => Candidate.fromJson(e))
              .toList()
          : [],
      timeStart: DateTime.parse(map['timeStart']),
      timeEnd: DateTime.parse(map['timeEnd']),
    );
  }
}
