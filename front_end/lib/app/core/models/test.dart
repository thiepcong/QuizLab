class Test {
  final int id;
  final String title;
  final DateTime timeCreated;
  final String quizCode;
  final String? note;

  Test({
    required this.id,
    required this.title,
    required this.timeCreated,
    required this.quizCode,
    this.note,
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
    );
  }

  Test copyWith({
    int? id,
    String? title,
    DateTime? timeCreated,
    String? quizCode,
    String? note,
  }) {
    return Test(
      id: id ?? this.id,
      title: title ?? this.title,
      timeCreated: timeCreated ?? this.timeCreated,
      quizCode: quizCode ?? this.quizCode,
      note: note ?? this.note,
    );
  }
}
