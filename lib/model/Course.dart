final String tableCourse = 'course';
final String columnId = '_id';
final String columnJieCi = 'jieci';
final String columnWeekDay = 'weekday';
final String columnWeek='week';
final String columnDes = 'des';
final String columnClassRoomName = 'classRoomName';
final String columnClassTypeName = 'classTypeName';
final String columnClassName = 'className';
final String columnClassTeacher = 'classTeacher';

class Course {
  int id;
  int jieci; //节次
  int weekday; //周几的课
  String week; //第几周的课
  String des; //课程描述
  String classRoomName; //教室
  String classTypeName; //课程号
  String className; //课程名
  String classTeacher; //教师名

  Course() {}

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnJieCi: jieci,
      columnWeekDay: weekday,
      columnDes: des,
      columnWeek:week,
      columnClassRoomName: classRoomName,
      columnClassTypeName: classTypeName,
      columnClassName: className,
      columnClassTeacher: classTeacher
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Course.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    jieci = map[columnJieCi];
    weekday = map[columnWeekDay];
    week=map[columnWeek];
    des = map[columnDes];
    classRoomName = map[columnClassRoomName];
    classTypeName = map[columnClassTypeName];
    className = map[columnClassName];
    classTeacher = map[columnClassTeacher];
  }
}
