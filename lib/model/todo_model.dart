class Todo {
  static const String collectionName = 'Todos';
  String id;
  String title;
  String description;
  DateTime date;
  String time;
  bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    this.isDone = false,
  });

  Todo.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          title: json['title']! as String,
          description: json['description']! as String,
          date: DateTime.fromMillisecondsSinceEpoch(json['date'] as int),
          time: json['time'] as String,
          isDone: json['isDone'] as bool,
        );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'time': time,
      'isDone': isDone,
    };
  }
}
