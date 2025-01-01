class DateModel {
  DateTime date;
  bool isCompleted;
  DateModel({required this.date, required this.isCompleted});
  Map<String, dynamic> toJson() => {
        'date': date.toString(),
        'isCompleted': isCompleted,
      };

  factory DateModel.fromJson(Map<String, dynamic> json) => DateModel(
        date: DateTime.parse(json['date']),
        isCompleted: json['isCompleted'] as bool,
      );
}
