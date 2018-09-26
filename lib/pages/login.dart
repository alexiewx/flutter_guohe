import 'package:flutter/material.dart';
import 'package:flutter_guohe/constant//UrlConstant.dart';
import 'package:dio/dio.dart';
import 'package:flutter_guohe/views/customview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_guohe/constant/SpConstant.dart';
import 'package:flutter_guohe/pages/app.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  String _account;

  String _password;

  //表单验证方法
  void _forSubmitted(BuildContext context) {
    var _form = _formKey.currentState;

    if (_form.validate()) {
      _form.save();
      login(context, _account.trim(), _password.trim());
    }
  }

  //登录
  void login(BuildContext context, String account, String password) {
    showDialog(
        context: context,
        builder: (context) {
          return new LoadingDialog(content: "登录中，请稍后......");
        });
    FormData formData =
        new FormData.from({"username": account, "password": password});
    Dio().post(Constant.STU_INFO, data: formData).then((res) {
      print(account + " " + password);
      if (res.statusCode == 200) {
        Navigator.pop(context);
        if (res.data['code'] == 200) {
          print(res.data);
          String name = res.data['info']['name'];
          String academy = res.data['info']['academy'];
          String major = res.data['info']['major'];
          String stu_id = res.data['info']['name'];
          String stu_pass = res.data['info']['password'];
          List<String> list = new List();
          list.add(name);
          list.add(academy);
          list.add(major);
          list.add(stu_id);
          list.add(stu_pass);
          store(list);
          Navigator.push(
            context,
            new MaterialPageRoute(builder: (context) => new Guohe()),
          );
        }
      }
    });
  }

  //将学生的相关信息保存至本地
  void store(List<String> list) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(SpConstant.IS_LOGIN, true);
    sharedPreferences.setStringList(SpConstant.STU_INFO, list);
  }

  @override
  Widget build(BuildContext context) {
    final account = new TextFormField(
      autofocus: true,
      initialValue: '',
      decoration: new InputDecoration(
        labelText: '学号',
      ),
      onSaved: (val) {
        _account = val;
      },
    );

    final password = new TextFormField(
      initialValue: '',
      obscureText: true,
      decoration: new InputDecoration(
        labelText: '密码',
      ),
      onSaved: (val) {
        _password = val;
      },
    );

    final loginButton = new FloatingActionButton(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black26,
      child: const Icon(Icons.arrow_forward),
      elevation: 18.0,
      onPressed: () => _forSubmitted(context),
    );

    final loginBox = new Container(
      width: 320.0,
      height: 250.0,
      margin: new EdgeInsets.only(top: 300.0, right: 30.0),
      child: new Stack(
        children: <Widget>[
          new Container(
              color: Colors.white,
              width: 280.0,
              height: 220.0,
              child: new Form(
                key: _formKey,
                child: new ListView(
                  shrinkWrap: true,
                  padding: new EdgeInsets.only(left: 24.0, right: 24.0),
                  children: <Widget>[
                    SizedBox(height: 48.0),
                    account,
                    new SizedBox(
                      height: 15.0,
                    ),
                    password,
                  ],
                ),
              )),
          new Positioned(
              //方法二
              right: 15.0,
              top: 180.0,
              child: loginButton),
        ],
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage('assets/imgs/bg_login.webp'),
                fit: BoxFit.cover)),
        child: new Center(child: loginBox),
      ),
    );
  }
}
