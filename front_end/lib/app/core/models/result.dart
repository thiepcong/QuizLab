class Result {
  final int id;
  final bool selected;

  Result({required this.id, required this.selected});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'selected': selected,
    };
  }

  factory Result.fromJson(Map<String, dynamic> map) {
    return Result(
      id: map['id'] as int,
      selected: map['selected'] as bool,
    );
  }
}
