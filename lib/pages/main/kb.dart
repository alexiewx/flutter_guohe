import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guohe/constant/UrlConstant.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_guohe/model/Course.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final String tableCourse = 'course';
final String columnId = '_id';
final String columnJieCi = 'jieci';
final String columnWeekDay = 'weekday';
final String columnWeek = 'week';
final String columnDes = 'des';
final String columnClassRoomName = 'classRoomName';
final String columnClassTypeName = 'classTypeName';
final String columnClassName = 'className';
final String columnClassTeacher = 'classTeacher';

class Kb extends StatefulWidget {
  @override
  KbState createState() => new KbState();
}

class KbState extends State<Kb> {
  List<Map> mondayList = new List();
  List<Map> tuesdayList = new List();
  List<Map> wednesdayList = new List();
  List<Map> thursdayList = new List();
  List<Map> fridayList = new List();
  List<Map> saturdayList = new List();
  List<Map> sundayList = new List();

  bool isLoading = false;

  // 获取数据库地址
  Future<String> get _dbPath async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "course.db");

    return path;
  }

  // 创建数据库
  Future<Database> get _localFile async {
    final path = await _dbPath;

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table $tableCourse ( 
  $columnId integer primary key autoincrement, 
  $columnJieCi text not null,
  $columnWeekDay text not null,
  $columnWeek text not null,
  $columnDes text not null,
  $columnClassRoomName text not null,
  $columnClassTypeName text not null,
  $columnClassName text not null,
  $columnClassTeacher text not null  )
''');
    });
    return database;
  }

  // 新增一条数据
  Future<Course> insert(Course course) async {
    final db = await _localFile;
    course.id = await db.insert(tableCourse, course.toMap());
    return course;
  }

  // 根据weekday查找数据
  Future<Course> getCourseByWeekday(String weekday) async {
    final db = await _localFile;
    List<Map> maps = await db.query(tableCourse,
        columns: [
          columnId,
          columnJieCi,
          columnWeekDay,
          columnWeek,
          columnDes,
          columnClassRoomName,
          columnClassTypeName,
          columnClassName,
          columnClassTeacher
        ],
        where: '$columnWeekDay = ?',
        whereArgs: [weekday]);
    if (maps.length > 0) {
      return Course.fromMap(maps.first);
    }
    return null;
  }

  // 获取数据库中的全部数据
  Future<List<Map>> get() async {
    final db = await _localFile;
    List<Map> list = await db.rawQuery('SELECT * FROM course');
    return list;
  }

  // 根据des返回周次
  String zhouci(String s) {
    return s.split("@")[3];
  }

  //判断当前周是否在该课的周次内
  bool isInThisWeek(int week, String s) {
    /**
     * 原本的周次字符串可能为“1-6,7,8,9-13（周）”
     * 所以需要对字符串进行匹配
     * 第一步：取出字符串中的“(周)”
     * 第二步：按照逗号分割
     * 第三步：判断是否有“-”，如果有则将“-”左右范围内的数字添加进list，如果没有直接添加数字
     */
    List<String> zhoucis = s.substring(0, s.length - 3).split(",");
    for (String s1 in zhoucis) {
      if (s1.contains("-")) {
        List<String> ss = s1.split("-");
        int begin = int.parse(ss[0]);
        int end = int.parse(ss[1]);
        if (week >= begin && week <= end) return true;
      } else {
        if (week == int.parse(s1)) return true;
      }
    }
    return false;
  }

  //获取课表
  void getKb() {
    Future<List<Map>> kb = get();
    kb.then((List<Map> courses) {
      if (courses.length > 0) {
        setState(() {
          this.isLoading = true;
        });
        // 从数据库中获取课表
        getKbFromDB(courses);
      } else {
        //从服务器端获取课表
        getKbFromServer();
      }
    });
  }

  // 从数据库中获取课表
  void getKbFromDB(List<Map> courses) {
    List<Map> kb = new List();
    for (var map in courses) {
      if (isInThisWeek(13, map['week'])) {
        kb.add(map);
      }
    }
    showKb(kb);
  }

  // 展示课表
  void showKb(List<Map> kb) {
    for (var map in kb) {
      switch (map['weekday']) {
        case "1":
          mondayList.add(map);
          break;
        case "2":
          tuesdayList.add(map);
          break;
        case "3":
          wednesdayList.add(map);
          break;
        case "4":
          thursdayList.add(map);
          break;
        case "5":
          fridayList.add(map);
          break;
        case "6":
          saturdayList.add(map);
          break;
        case "7":
          sundayList.add(map);
          break;
      }
    }
    setState(() {
      this.mondayList = mondayList;
      this.tuesdayList = tuesdayList;
      this.wednesdayList = wednesdayList;
      this.thursdayList = thursdayList;
      this.fridayList = fridayList;
      this.saturdayList = saturdayList;
      this.sundayList = sundayList;
    });
  }

  //从服务器端获取课表
  void getKbFromServer() {
    FormData formData = new FormData.from({
      "username": "152210702112",
      "password": "liang19991108",
      "semester": "2017-2018-2"
    });
    Dio().post(Constant.ALL_COURSE_NEW, data: formData).then((res) {
      int code = res.data['code'];

      var days = [
        'monday',
        'tuesday',
        'wednesday',
        'thursday',
        'friday',
        'saturday',
        'sunday'
      ];

      if (code == 200) {
        var list = res.data['info'] as List;

        String courseNum = "";
        String courseClassroom = "";
        String courseName = "";
        String courseTeacher = "";

        for (var i = 0; i < list.length - 1; i++) {
          var object = list[i];
          for (String day in days) {
            int weekday = days.indexOf(day) + 1; //判断是星期几
            int jieci = 2 * i + 1; //设置是第几节
            List<String> dess = object[day].split("---------------------");
            if (dess.length > 0 && dess[0].length > 1) {
              for (String des in dess) {
                String week = zhouci(des);
                List<String> courseInfo = des.split('@');
                if (courseInfo.length == 1) {
                  courseNum = courseInfo[0];
                }
                if (courseInfo.length == 2) {
                  courseNum = courseInfo[0];
                  courseName = courseInfo[1];
                }
                if (courseInfo.length == 3 || courseInfo.length == 4) {
                  courseNum = courseInfo[0];
                  courseName = courseInfo[1];
                  courseTeacher = courseInfo[2];
                }
                if (courseInfo.length == 5) {
                  courseNum = courseInfo[0];
                  courseName = courseInfo[1];
                  courseTeacher = courseInfo[2];
                  courseClassroom = courseInfo[4];
                }

                Course course = new Course();
                course.des = des;
                course.week = week;
                course.weekday = weekday;
                course.jieci = jieci;
                course.classTeacher = courseTeacher;
                course.className = courseName;
                course.classTypeName = courseNum;
                course.classRoomName = courseClassroom;
                insert(course);
              }
            }
          }
        }
        getKb();
      }
    });
  }

  List<DropdownMenuItem> getListData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('1'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('2'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    DropdownMenuItem dropdownMenuItem3 = new DropdownMenuItem(
      child: new Text('3'),
      value: '3',
    );
    items.add(dropdownMenuItem3);
    DropdownMenuItem dropdownMenuItem4 = new DropdownMenuItem(
      child: new Text('4'),
      value: '4',
    );
    items.add(dropdownMenuItem4);
    DropdownMenuItem dropdownMenuItem5 = new DropdownMenuItem(
      child: new Text('5'),
      value: '5',
    );
    items.add(dropdownMenuItem5);
    DropdownMenuItem dropdownMenuItem6 = new DropdownMenuItem(
      child: new Text('6'),
      value: '6',
    );
    items.add(dropdownMenuItem6);
    return items;
  }

  @override
  void initState() {
    super.initState();
    getKb();
  }

  var value;

  @override
  Widget build(BuildContext context) {
    // 加载动画
    var loadingView = new Offstage(
      offstage: isLoading,
      child: new SpinKitFadingCircle(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.green,
            ),
          );
        },
      ),
    );

    //选择学年和周次的view
    var chooseWeekView = new Container(
      height: 50.0,
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Container(
                margin: new EdgeInsets.only(right: 15.0),
                alignment: Alignment.centerRight,
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    items: getListData(),
                    hint: new Text('2017-2018-2'),
                    //当没有默认值的时候可以设置的提示
                    value: value,
                    //下拉菜单选择完之后显示给用户的值
                    onChanged: (T) {
                      //下拉菜单item点击之后的回调
                      setState(() {
                        value = T;
                      });
                    },
                    elevation: 24,
                    //设置阴影的高度
                  ),
                )),
            flex: 1,
          ),
          new Text('|'),
          new Expanded(
            child: new Container(
                margin: new EdgeInsets.only(left: 15.0),
                alignment: Alignment.centerLeft,
                child: new DropdownButtonHideUnderline(
                  child: new DropdownButton(
                    items: getListData(),
                    hint: new Text('第9周'),
                    //当没有默认值的时候可以设置的提示
                    value: value,
                    //下拉菜单选择完之后显示给用户的值
                    onChanged: (T) {
                      //下拉菜单item点击之后的回调
                      setState(() {
                        value = T;
                      });
                    },
                  ),
                )),
            flex: 1,
          ),
        ],
      ),
    );

    // 课表页
    var kbView = new DefaultTabController(
      length: 7,
      child: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.orangeAccent,
            title: new TabBar(
              tabs: [
                new Tab(text: "周一"),
                new Tab(text: "周二"),
                new Tab(text: "周三"),
                new Tab(text: "周四"),
                new Tab(text: "周五"),
                new Tab(text: "周六"),
                new Tab(text: "周日"),
              ],
              indicatorColor: Colors.white,
              isScrollable: true,
            ),
          ),
          body: new Stack(
            children: <Widget>[
              loadingView,
              new TabBarView(
                children: [
                  new KbList(
                    page: 1,
                    itemCount: mondayList.length,
                    list: this.mondayList,
                  ),
                  new KbList(
                    page: 2,
                    itemCount: tuesdayList.length,
                    list: this.tuesdayList,
                  ),
                  new KbList(
                    page: 3,
                    itemCount: wednesdayList.length,
                    list: this.wednesdayList,
                  ),
                  new KbList(
                    page: 4,
                    itemCount: thursdayList.length,
                    list: this.thursdayList,
                  ),
                  new KbList(
                    page: 5,
                    itemCount: fridayList.length,
                    list: this.fridayList,
                  ),
                  new KbList(
                    page: 6,
                    itemCount: saturdayList.length,
                    list: this.saturdayList,
                  ),
                  new KbList(
                    page: 7,
                    itemCount: sundayList.length,
                    list: this.sundayList,
                  ),
                ],
              ),
            ],
          )),
    );

    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text("课表"), //设置标题内容
            backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
            centerTitle: true, //设置标题是否局中
          ),
          body: new Stack(
            children: <Widget>[
              chooseWeekView,
              new Container(
                margin: new EdgeInsets.only(top: 50.0),
                child: kbView,
              )
            ],
          )),
    );
  }
}

class KbList extends StatefulWidget {
  KbList({@required this.page, @required this.itemCount, @required this.list});

  final int page; //用于判断当前是周几
  final int itemCount; //用于表示当前天有多少节课
  final List<Map> list; //当前天的所有的课的集合

  @override
  KbListState createState() => new KbListState();
}

class KbListState extends State<KbList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: widget.itemCount, itemBuilder: buildItem);
  }

  //ListView的Item
  Widget buildItem(BuildContext context, int index) {
    return new GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  content: new Container(
                    width: 500,
                    height: 200,
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('课程信息为：',
                            style: new TextStyle(
                                fontSize: 22.0, color: Colors.teal[500])),
                        new Divider(),
                        new Text(
                            '课程号：' + widget.list[index][columnClassTypeName],
                            style: new TextStyle(fontSize: 17.0)),
                        new Text('课程名：' + widget.list[index][columnClassName],
                            style: new TextStyle(fontSize: 17.0)),
                        new Text(
                            '课程教师：' + widget.list[index][columnClassTeacher],
                            style: new TextStyle(fontSize: 17.0)),
                        new Text(
                            '教室：' + widget.list[index][columnClassRoomName],
                            style: new TextStyle(fontSize: 17.0)),
                        new Text('周次：' + widget.list[index][columnWeek],
                            style: new TextStyle(fontSize: 17.0)),
                      ],
                    ),
                  ),
                ));
      },
      child: new KbItem(
        course: widget.list[index],
      ),
    );
  }
}

class KbItem extends StatefulWidget {
  final Icon icon;
  final Map course;

  KbItem({
    this.icon = const Icon(Icons.add_alert),
    @required this.course,
  });

  @override
  KbItemState createState() => new KbItemState();
}

class KbItemState extends State<KbItem> {
  @override
  Widget build(BuildContext context) {
    Map course = widget.course;
    return new Card(
      margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      elevation: 5,
      child: new ListTile(
        title: new Text(course['className'],
            style: new TextStyle(fontWeight: FontWeight.w500)),
        subtitle: new Text(course['classRoomName']),
        leading: widget.icon,
      ),
    );
  }
}
