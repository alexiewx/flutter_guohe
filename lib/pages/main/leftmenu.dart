import 'package:flutter/material.dart';

//左侧菜单栏
class LeftMenu extends Drawer {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      //侧边栏按钮Drawer
      child: new ListView(
        children: <Widget>[
          //个人信息部分
          new Container(
              color: Color.fromARGB(255, 119, 136, 213),
              child: new Padding(
                padding: new EdgeInsets.all(26.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        //头像
                        new Container(
                          width: 80.0,
                          height: 80.0,
                          margin:
                              new EdgeInsets.only(right: 10.0, bottom: 15.0),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: new NetworkImage(
                                  'http://www.chedan5.com/upload/article/201803/06/1740235a9e62077e0aexbcUQh.jpg'),
                              //从Assets加载图片
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                        new Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              '梁越勇',
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 25.0),
                            ),
                            new Text(
                              '152210702112',
                              style: new TextStyle(
                                  color: Colors.white, fontSize: 15.0),
                            )
                          ],
                        )
                      ],
                    ),
                    new Text(
                      "计算机学院",
                      style: new TextStyle(color: Colors.white, fontSize: 18.0),
                    )
                  ],
                ),
              )),
          new ListTile(
              //第二个功能项
              title: new Text('关于我们'),
              leading: new Icon(Icons.accessibility),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed('/a');
              }),
          //分割线控件
          new ListTile(
            //退出按钮
            title: new Text('分享此应用'),
            leading: new Icon(Icons.share),
            onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
          ),
          //分割线控件
          new ListTile(
            //退出按钮
            title: new Text('给我们反馈'),
            leading: new Icon(Icons.feedback),
            onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
          ),
          //分割线控件
          new ListTile(
            //退出按钮
            title: new Text('联系开发者'),
            leading: new Icon(Icons.flight),
            onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
          ),
          //分割线控件
          new ListTile(
            //退出按钮
            title: new Text('加入交流群'),
            leading: new Icon(Icons.group_add),
            onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
          ),
          new ListTile(
            //退出按钮
            title: new Text('切换账号'),
            leading: new Icon(Icons.sync),
            onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
          ),
          new ListTile(
            //退出按钮
            title: new Text('检测升级'),
            leading: new Icon(Icons.refresh),
            onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
          ),
          new ListTile(
            //退出按钮
            title: new Text('更新说明'),
            leading: new Icon(Icons.info),
            onTap: () => Navigator.of(context).pop(), //点击后收起侧边栏
          ),
        ],
      ),
    );
  }
}
