//获取轮播图的json实体类

class Ads {
  String des;
  String title;
  String img;
  String url;

  Ads({this.des, this.title, this.img, this.url});

  factory Ads.fromJson(Map<String, dynamic> parseJson) {
    return Ads(
        des:parseJson['describe'],
        title:parseJson['title'],
        img:parseJson['img'],
        url:parseJson['url']
    );
  }
}
