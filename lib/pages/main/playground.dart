import 'package:flutter/material.dart';
import 'package:flutter_guohe/views/banner.dart';
import 'package:flutter_guohe/model/Ad.dart';

class Playground extends StatefulWidget {
  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("操场"),
          backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
          centerTitle: true, //设置标题是否局中
        ),
        body: new ListView(
          children: <Widget>[
            new BannerHeader(),
            new Cards(),
          ],
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new Card(
          elevation: 10.0,
          margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          color: Color.fromARGB(0, 255, 255, 255),
          child: new Container(
            width: 400.0,
            height: 200.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              image: new DecorationImage(
                  image: new AssetImage("assets/imgs/cards/card1.webp"),
                  fit: BoxFit.cover),
              shape: BoxShape.rectangle, // <-- 这里需要设置为 rectangle
              borderRadius: new BorderRadius.all(
                const Radius.circular(15.0), // <-- rectangle 时，BorderRadius 才有效
              ),
            ),
          ),
        ),
        new Card(
          margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          elevation: 10.0,
          color: Color.fromARGB(0, 255, 255, 255),
          child: new Container(
            width: 400.0,
            height: 200.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              image: new DecorationImage(
                  image: new AssetImage("assets/imgs/cards/card2.webp"),
                  fit: BoxFit.cover),
              shape: BoxShape.rectangle, // <-- 这里需要设置为 rectangle
              borderRadius: new BorderRadius.all(
                const Radius.circular(15.0), // <-- rectangle 时，BorderRadius 才有效
              ),
            ),
          ),
        ),
        new Card(
          margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          elevation: 10.0,
          color: Color.fromARGB(0, 255, 255, 255),
          child: new Container(
            width: 400.0,
            height: 200.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              image: new DecorationImage(
                  image: new AssetImage("assets/imgs/cards/card3.webp"),
                  fit: BoxFit.cover),
              shape: BoxShape.rectangle, // <-- 这里需要设置为 rectangle
              borderRadius: new BorderRadius.all(
                const Radius.circular(15.0), // <-- rectangle 时，BorderRadius 才有效
              ),
            ),
          ),
        ),
        new Card(
          margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          elevation: 10.0,
          color: Color.fromARGB(0, 255, 255, 255),
          child: new Container(
            width: 400.0,
            height: 200.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              image: new DecorationImage(
                  image: new AssetImage("assets/imgs/cards/card4.webp"),
                  fit: BoxFit.cover),
              shape: BoxShape.rectangle, // <-- 这里需要设置为 rectangle
              borderRadius: new BorderRadius.all(
                const Radius.circular(15.0), // <-- rectangle 时，BorderRadius 才有效
              ),
            ),
          ),
        ),
        new Card(
          margin: new EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
          elevation: 10.0,
          color: Color.fromARGB(0, 255, 255, 255),
          child: new Container(
            width: 400.0,
            height: 200.0,
            decoration: new BoxDecoration(
              color: Colors.white,
              image: new DecorationImage(
                  image: new AssetImage("assets/imgs/cards/card5.webp"),
                  fit: BoxFit.cover),
              shape: BoxShape.rectangle, // <-- 这里需要设置为 rectangle
              borderRadius: new BorderRadius.all(
                const Radius.circular(15.0), // <-- rectangle 时，BorderRadius 才有效
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//头部轮播图
class BannerHeader extends StatefulWidget {
  @override
  BannerState createState() => new BannerState();
}

class BannerState extends State<BannerHeader> {
  List<Ad> adList = new List();

  //初始化轮播图列表
  void initAd() {
    adList.add(new Ad(
        "虚位以待",
        "广告位",
        "http://p7gzvzwe4.bkt.clouddn.com/TIM%E5%9B%BE%E7%89%8720180517233021.png",
        "http://119.23.212.45/guohe/ad/ad.html"));
    adList.add(new Ad(
        "百度APP新产品友话已正式上线",
        "百度友话",
        "http://p7gzvzwe4.bkt.clouddn.com/2AD0F7FD93606B1D688A2F09EB38B4E1.jpg",
        "https://youhua.baidu.com/circle?groupId=10289"));
  }

  @override
  void initState() {
    super.initState();
    initAd();
  }

  @override
  Widget build(BuildContext context) {
    return new BannerView(
      height: 250.0,
      data: adList,
      buildShowView: (index, ad) {
        return new Container(
          color: Colors.black26,
          child: new Stack(children: <Widget>[
            new Image(
              width:420.0,
              image:NetworkImage(ad.img),
              fit: BoxFit.cover,
            ),
            new Positioned(
                left: 0.0,
                right: 0.0,
                top: 215.0,
                child: new Container(
                  height: 35.0,
                  color: Colors.black12,
                  child: new Text(
                    ad.title,
                    style: new TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'serif',
                        color: Color.fromARGB(255, 248, 248, 255)),
                  ),
                )),
          ]),
        );
      },
      onBannerClickListener: (index, data) {
        print(index);
      },
    );
  }
}
