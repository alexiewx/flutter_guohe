class CourseRes {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;

  CourseRes(
      {this.monday,
      this.tuesday,
      this.wednesday,
      this.thursday,
      this.friday,
      this.saturday,
      this.sunday});

  factory CourseRes.fromJson(Map<String, String> parseJson) {
    return CourseRes(
      monday: parseJson['monday'],
      tuesday: parseJson['tuesday'],
      wednesday: parseJson['wednesday'],
      thursday: parseJson['thursday'],
      friday: parseJson['friday'],
      saturday: parseJson['saturday'],
      sunday: parseJson['sunday'],
    );
  }
}
