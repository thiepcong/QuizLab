import 'result.dart';

class Candidate {
  final int id;
  final String name;
  final int score;
  final List<Result> results;
  final int testId;

  Candidate({
    this.id = -1,
    required this.name,
    this.score = 0,
    this.results = const [],
    this.testId = -1,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'score': score,
      'results': results.map((x) => x.toJson()).toList(),
      'testId': testId,
    };
  }

  factory Candidate.fromJson(Map<String, dynamic> map) {
    return Candidate(
      id: map['id'] as int,
      name: map['name'] as String,
      score: map['score'] as int,
      results: map['results'] != null
          ? List<Result>.from(
              (map['results'] as List).map<Result>(
                (x) => Result.fromJson(x as Map<String, dynamic>),
              ),
            )
          : [],
      testId: map['testId'] as int,
    );
  }
}
