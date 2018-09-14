import 'package:flutter/material.dart';
import 'package:flutter_guohe/common/eventBus.dart';
import 'package:flutter_guohe/views/customview.dart';

class Today extends StatefulWidget {
  @override
  TodayState createState() => new TodayState();
}

class TodayState extends State<Today> {
  //打开drawer
  void openDrawer() {
    eventBus.fire(new EventOpenDrawer(true));
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: Icon(Icons.home),
            onPressed: () {
              //打开drawer
              openDrawer();
            },
          ),
          title: new Text("今日"), //设置标题内容
          backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: new ListView(
          children: <Widget>[
            new Header(),
            new BigDivider(),
            new TodayKb(),
            new BigDivider(),
            new Message(),
            new BigDivider(),
            new One()
          ],
        ),
      ),
    );
  }
}

//首页的头部信息
class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 100.0,
      margin: new EdgeInsets.all(8.0),
      child: new Row(
        children: <Widget>[
          new Expanded(
            child: new Column(
              children: <Widget>[
                //头像
                new Container(
                  width: 60.0,
                  height: 60.0,
                  margin: new EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('assets/imgs/ic_menu_score.png'),
                      //从Assets加载图片
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                new Text(
                  '查成绩',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            flex: 1,
          ),
          new Expanded(
            child: new Column(
              children: <Widget>[
                //头像
                new Container(
                  width: 60.0,
                  height: 60.0,
                  margin: new EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('assets/imgs/ic_menu_pe.png'),
                      //从Assets加载图片
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                new Text(
                  '查体育',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            flex: 1,
          ),
          new Expanded(
            child: new Column(
              children: <Widget>[
                //头像
                new Container(
                  width: 60.0,
                  height: 60.0,
                  margin: new EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('assets/imgs/ic_menu_bus.png'),
                      //从Assets加载图片
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                new Text(
                  '查校车',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            flex: 1,
          ),
          new Expanded(
            child: new Column(
              children: <Widget>[
                //头像
                new Container(
                  width: 60.0,
                  height: 60.0,
                  margin: new EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('assets/imgs/ic_menu_system.png'),
                      //从Assets加载图片
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                new Text(
                  '校园系统',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            flex: 1,
          ),
          new Expanded(
            child: new Column(
              children: <Widget>[
                //头像
                new Container(
                  width: 60.0,
                  height: 60.0,
                  margin: new EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: new AssetImage('assets/imgs/ic_menu_more.png'),
                      //从Assets加载图片
                      fit: BoxFit.cover,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
                new Text(
                  '更多',
                  textAlign: TextAlign.center,
                )
              ],
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}

//今日课表
class TodayKb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(18.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                new Icon(
                  Icons.camera,
                  color: Colors.black26,
                  size: 17.0,
                ),
                new Container(
                  margin: new EdgeInsets.only(left: 5.0),
                  child: new Text(
                    '今日课表',
                    style: new TextStyle(color: Color(0xFF888888)),
                  ),
                )
              ],
            ),
          ),
          new Divider(
            color: Color(0xFF888888),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 30.0, bottom: 2.0),
            child: new Text("今天居然没有课~" + "\uD83D\uDE01"),
          ),
          new Container(
            margin: new EdgeInsets.only(top: 30.0, bottom: 2.0),
            child: new Text('点我查看完整课表',
                style: new TextStyle(
                    color: Color(
                      0xFF888888,
                    ),
                    fontSize: 12.0)),
          ),
        ],
      ),
    );
  }
}

//消息
class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(18.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                new Icon(
                  Icons.message,
                  color: Colors.black26,
                  size: 17.0,
                ),
                new Container(
                  margin: new EdgeInsets.only(left: 5.0),
                  child: new Text(
                    '消息',
                    style: new TextStyle(color: Color(0xFF888888)),
                  ),
                )
              ],
            ),
          ),
          new Divider(
            color: Color(0xFF888888),
          ),
          new Container(
            margin: new EdgeInsets.all(10.0),
            child: new Text("这里是消息"),
          ),
          new Divider(
            color: Color(0xFF888888),
          )
        ],
      ),
    );
  }
}

//日知录
class One extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(18.0),
      child: new Column(
        children: <Widget>[
          new Container(
            child: new Row(
              children: <Widget>[
                new Icon(
                  Icons.email,
                  color: Colors.black26,
                  size: 17.0,
                ),
                new Container(
                  margin: new EdgeInsets.only(left: 5.0),
                  child: new Text(
                    '日知录',
                    style: new TextStyle(color: Color(0xFF888888)),
                  ),
                )
              ],
            ),
          ),
          new Divider(
            color: Color(0xFF888888),
          ),
          new Container(
            margin: new EdgeInsets.all(10.0),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text(
                  '2018/09/14',
                  style: new TextStyle(color: Color(0xFF888888)),
                ),
                new Margin(indent: 6.0),
                new Image(
                    image: new NetworkImage(
                        'http://image.wufazhuce.com/Fn5E1UnrcvN0jwFRiOtDZ2WnQa4N')),
                new Margin(indent: 6.0),
                new Text(
                  'Fahmi Ramadhan | 摄影',
                  style: new TextStyle(color: Color(0xFF888888)),
                ),
                new Margin(indent: 6.0),
                new Text(
                  '所有的爱情，都是两个心灵相通的人胜利，无法相互了解的人失败，没有所谓对错。',
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Color(0xFF888888)),
                ),
                new Margin(indent: 6.0),
                new Text(
                  '《东京爱情故事》',
                  style: new TextStyle(color: Color(0xFF888888)),
                )
              ],
            ),
          ),
          new Divider(
            color: Color(0xFF888888),
          )
        ],
      ),
    );
  }
}
