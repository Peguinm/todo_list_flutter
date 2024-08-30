class TaskModel {
  final int id;
  final String description;
  final DateTime date;
  final bool done;

  TaskModel({
    required this.id,
    required this.description,
    required this.date,
    required this.done,
  });

  factory TaskModel.loadFromDB(Map<String, dynamic> task) {
    return TaskModel(
      id: task['id'],
      description: task['description'],
      date: DateTime.parse(task['date']),
      done: task['complete'] == 1,
    );
  }

  TaskModel copyWith({
    int? id,
    String? description,
    DateTime? date,
    bool? done,
  }) {
    return TaskModel(
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
      done: done ?? this.done,
    );
  }
}
