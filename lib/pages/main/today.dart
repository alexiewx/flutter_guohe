import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_guohe/common/eventBus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_guohe/views/customview.dart';
import 'package:flutter_guohe/constant/UrlConstant.dart';
import 'package:flutter_guohe/constant/SpConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
            new Header(), //头部
            new BigDivider(),
            new TodayKb(), //今日课表
            new BigDivider(),
            new Message(), //消息
            new BigDivider(),
            new One() //日知录
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
class TodayKb extends StatefulWidget {
  @override
  TodayKbState createState() => new TodayKbState();
}

class TodayKbState extends State<TodayKb> {
  @override
  Widget build(BuildContext context) {
    //跳转至课表
    _toKb() {
      print('跳转至课表');
    }

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
          new GestureDetector(
            child: new Container(
              margin: new EdgeInsets.only(top: 30.0, bottom: 2.0),
              child: new Text('点我查看完整课表',
                  style: new TextStyle(
                      color: Color(
                        0xFF888888,
                      ),
                      fontSize: 12.0)),
            ),
            onTap: _toKb,
          ),
        ],
      ),
    );
  }
}

//消息
class Message extends StatefulWidget {
  @override
  MessageState createState() => new MessageState();
}

class MessageState extends State<Message> {
  String message = "这里是消息模块";

  @override
  void initState() {
    super.initState();

    getMessage();
  }

  //获取消息
  void getMessage() {
    Dio().get('http://guohe3.com/getToast').then((res) {
      if (res.statusCode == 200) {
        int code = res.data['code'];
        if (code == 200) {
          String info = res.data['info'][0];
          print(info);
          setState(() {
            message = info;
          });
        }
      }
    });
  }

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
            child: new Text(message),
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
class One extends StatefulWidget {
  @override
  OneState createState() => new OneState();
}

class OneState extends State<One> {
  String date = "2018/09/14";
  String imgUrl = 'http://image.wufazhuce.com/Fn5E1UnrcvN0jwFRiOtDZ2WnQa4N';
  String imgAuthor = "Fahmi Ramadhan";
  String imgKind = "摄影";
  String url = "http://m.wufazhuce.com/one/2202";
  String word = "恋爱不是用谈的，是坠入的。";
  String wordFrom = "《寂寞东京铁塔》";

  //获取日知录的内容
  void getOneContent() {
    FormData formData = new FormData.from(
        {"TransCode": "030111", "OpenId": "123456789", "Body": "123456789"});
    Dio().post(Constant.ONE, data: formData).then((res) {
      setState(() {
        date = res.data['Body']['date'].toString().split(" ")[0].replaceAll("-", "/");
        imgUrl = res.data['Body']['img_url'];
        imgAuthor = res.data['Body']['img_author'];
        imgKind = res.data['Body']['img_kind'];
        url = res.data['Body']['url'];
        word = res.data['Body']['word'];
        wordFrom = res.data['Body']['word_from'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getOneContent();
  }

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
                  date,
                  style: new TextStyle(color: Color(0xFF888888)),
                ),
                new Margin(indent: 6.0),
                new Image(image: new NetworkImage(imgUrl)),
                new Margin(indent: 6.0),
                new Text(
                  imgAuthor + " | " + imgKind,
                  style: new TextStyle(color: Color(0xFF888888)),
                ),
                new Margin(indent: 6.0),
                new Text(
                  word,
                  textAlign: TextAlign.center,
                  style: new TextStyle(color: Color(0xFF888888)),
                ),
                new Margin(indent: 6.0),
                new Text(
                  wordFrom,
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
