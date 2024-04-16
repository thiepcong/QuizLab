class Answer {
  final int id;
  final String content;
  final bool status;

  Answer({this.id = -1, required this.content, required this.status});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'content': content,
      'status': status,
    };
  }

  factory Answer.fromJson(Map<String, dynamic> map) {
    return Answer(
      content: map['content'] as String,
      status: map['status'] as bool,
    );
  }

  Answer copyWith({
    String? content,
    bool? status,
  }) {
    return Answer(
      content: content ?? this.content,
      status: status ?? this.status,
    );
  }
}
