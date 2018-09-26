import 'package:flutter/material.dart';
import 'package:flutter_guohe/views/banner.dart';
import 'package:flutter_guohe/model/Ad.dart';
import 'package:dio/dio.dart';
import 'package:flutter_guohe/constant/UrlConstant.dart';
import 'package:flutter_guohe/model/AdRes.dart';
import 'package:flutter_guohe/views/browser.dart';

class Playground extends StatefulWidget {
  @override
  PlaygroundState createState() => new PlaygroundState();
}

class PlaygroundState extends State<Playground> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new ListView(
          children: <Widget>[
            new AppBar(
              title: new Text("操场"),
              backgroundColor: Color.fromARGB(255, 119, 136, 213), //设置appbar背景颜色
              centerTitle: true, //设置标题是否局中
            ),
            new BannerHeader(),
            new Cards(),
          ],
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {
  void navigateTo(BuildContext context, String url,String title) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (_) {
      return new Browser(url: url,title: title,);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new GestureDetector(
          onTap: () => navigateTo(context, 'https://www.baidu.com',"抽奖"),
          child: new Card(
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
                  const Radius.circular(
                      15.0), // <-- rectangle 时，BorderRadius 才有效
                ),
              ),
            ),
          ),
        ),
        new GestureDetector(
          onTap: () => navigateTo(context, Constant.BIAO_BAI,"表白墙"),
          child: new Card(
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
                  const Radius.circular(
                      15.0), // <-- rectangle 时，BorderRadius 才有效
                ),
              ),
            ),
          ),
        ),
        new GestureDetector(
          onTap: () => navigateTo(context, Constant.ER_SHOU,"二手市场"),
          child: new Card(
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
                  const Radius.circular(
                      15.0), // <-- rectangle 时，BorderRadius 才有效
                ),
              ),
            ),
          ),
        ),
        new GestureDetector(
          onTap: () => navigateTo(context, Constant.FIND_JOB,"兼职"),
          child: new Card(
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
                  const Radius.circular(
                      15.0), // <-- rectangle 时，BorderRadius 才有效
                ),
              ),
            ),
          ),
        ),
        new GestureDetector(
          onTap: () => navigateTo(context, Constant.FIND_LOST,"失物招领"),
          child: new Card(
            margin: new EdgeInsets.only(
                left: 15.0, right: 15.0, top: 15.0, bottom: 15.0),
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
                  const Radius.circular(
                      15.0), // <-- rectangle 时，BorderRadius 才有效
                ),
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
    Dio().get(Constant.SLIDE).then((res) {
      int code = res.data['code'];
      if (code == 200) {
        var list = res.data['info'] as List;
        List<Ads> adsList = list.map((i) => Ads.fromJson(i)).toList();
        List<Ad> ads = new List();
        for (Ads ad in adsList) {
          ads.add(new Ad(ad.des, ad.title, ad.img, ad.url));
        }
        setState(() {
          adList = ads;
        });
      }
    });
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
              width: 420.0,
              image: NetworkImage(ad.img),
              fit: BoxFit.cover,
            ),
            new Positioned(
                left: 0.0,
                right: 0.0,
                top: 215.0,
                child: new Container(
                    height: 35.0,
                    color: Colors.black26,
                    child: new Padding(
                      padding: new EdgeInsets.all(5.0),
                      child: new Row(
                        children: <Widget>[
                          new Expanded(
                            child: new Align(
                              alignment: Alignment.centerLeft,
                              child: new Text(
                                ad.des,
                                style: new TextStyle(
                                    fontSize: 14.0,
                                    fontFamily: 'serif',
                                    color: Color.fromARGB(255, 248, 248, 255)),
                              ),
                            ),
                            flex: 1,
                          ),
                        ],
                      ),
                    ))),
          ]),
        );
      },
      onBannerClickListener: (index, data) {
        print(index);
      },
    );
  }
}
