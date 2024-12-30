class Plan {
  final int dayNo;
  final int completedPercentage;
  final String title;
  final String description;
  final int calories;
  final int time;

  const Plan(
      {required this.dayNo,
      required this.completedPercentage,
      required this.title,
      required this.description,
      required this.calories,
      required this.time});
}
