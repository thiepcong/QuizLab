class Result {
  final int id;
  final int candidateId;
  final int questionId;
  final List<String> chosenAnswers;
  final bool correct;

  Result({
    this.id = -1,
    this.candidateId = -1,
    required this.questionId,
    required this.chosenAnswers,
    required this.correct,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'questionId': questionId,
      'chosenAnswers': chosenAnswers,
      'correct': correct,
    };
  }

  factory Result.fromJson(Map<String, dynamic> map) {
    return Result(
      id: map['id'] as int,
      candidateId: map['candidateId'] as int,
      questionId: map['questionId'] as int,
      chosenAnswers:
          (map['chosenAnswers'] as List).map((e) => e.toString()).toList(),
      correct: map['correct'] as bool,
    );
  }
}
