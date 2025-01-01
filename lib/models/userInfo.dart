class Userinfo {
  late String Plan;
  late String Height;
  late int Weight;
  late int age;

  Userinfo(
      {required this.Plan,
      required this.Height,
      required this.Weight,
      required this.age});

  static Userinfo fromJson(Map<String, dynamic> json) {
    return Userinfo(
      Plan: json['Plan'] ?? "Beginner",
      Height: json['Height'] ?? "3'0",
      Weight: json['Weight'] ?? 50,
      age: json['age'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Plan': Plan,
      'Height': Height,
      'Weight': Weight,
      'age': age,
    };
  }
}
