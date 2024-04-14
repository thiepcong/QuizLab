// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Answer {
  final int id;
  final String content;
  final bool status;

  Answer({this.id = -1, required this.content, required this.status});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'status': status,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      content: map['content'] as String,
      status: map['status'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) =>
      Answer.fromMap(json.decode(source) as Map<String, dynamic>);

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
