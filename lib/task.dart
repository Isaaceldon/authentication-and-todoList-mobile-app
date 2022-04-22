class Task {
  int? id;
  late String name;
  late String description;
  late String priority;
  late String startDate;
  late String endDate;

  Task({this.id, required this.name, required this.description, required this.priority, required this.startDate, required this.endDate});

  Map<String,dynamic> toMap() {
    return {
      'id' : id,
      'name' : name,
      'description' : description,
      'priority' : priority,
      'startDate' : startDate,
      'endDate' : endDate
    };
  }

}