class Plan {
  final int dayNo;
  final int completedPercentage;
  final String title;
  final String description;
  final int calories;
  final int time;

  const Plan({
    required this.dayNo,
    required this.completedPercentage,
    required this.title,
    required this.description,
    required this.calories,
    required this.time,
  });

  // toJson method to convert Plan object to Map
  Map<String, dynamic> toJson() => {
        'dayNo': dayNo,
        'completedPercentage': completedPercentage,
        'title': title,
        'description': description,
        'calories': calories,
        'time': time,
      };

  // fromJson method to convert Map to Plan object
  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
        dayNo: json['dayNo'] as int,
        completedPercentage: json['completedPercentage'] as int,
        title: json['title'] as String,
        description: json['description'] as String,
        calories: json['calories'] as int,
        time: json['time'] as int,
      );
}
