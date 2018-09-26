import 'dart:async';

/**
 * APP的主入口文件
 */

import 'package:flutter/material.dart';

import 'package:flutter_guohe/pages/main/today.dart';
import 'package:flutter_guohe/pages/main/playground.dart';
import 'package:flutter_guohe/pages/main/kb.dart';
import 'package:flutter_guohe/pages/main/leftmenu.dart';

import 'package:flutter_guohe/common/eventBus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_guohe/constant/SpConstant.dart';
import 'package:flutter_guohe/pages/login.dart';

//果核的主界面
class Guohe extends StatefulWidget {
  @override
  GuoheState createState() => new GuoheState();
}

class GuoheState extends State<Guohe> with SingleTickerProviderStateMixin {
  TabController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    controller = new TabController(length: 3, vsync: this);
    eventBus.on<EventOpenDrawer>().listen((EventOpenDrawer data) {
      if (data.flag) _scaffoldKey.currentState.openDrawer();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        key: _scaffoldKey,
        drawer: new LeftMenu(),
        body: new TabBarView(
          controller: controller,
          children: <Widget>[
            new Today(),
            new Kb(),
            new Playground(),
          ],
        ),
        bottomNavigationBar: new Material(
          color: Colors.white,
          child: new TabBar(
            controller: controller,
            labelColor: Colors.deepPurpleAccent,
            unselectedLabelColor: Colors.black26,
            tabs: <Widget>[
              new Tab(
                text: "今日",
                icon: new Icon(Icons.brightness_5),
              ),
              new Tab(
                text: "课表",
                icon: new Icon(Icons.map),
              ),
              new Tab(
                text: "操场",
                icon: new Icon(Icons.directions_run),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
