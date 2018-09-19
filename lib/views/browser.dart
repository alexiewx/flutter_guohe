import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Browser extends StatelessWidget {
  const Browser({
    Key key, this.url,this.title
  }) : super(key: key);

  final String url;
  final String title;

  @override
  Widget build(BuildContext context) {

    print(url);

    return new WebviewScaffold(
      appBar: new AppBar(
        title: new Text(this.title),
        centerTitle: true,
      ),
      url: this.url,
      withJavascript: true,
      // 允许运行js
      withLocalStorage: true,
      // 运行使用Localstorage
      withZoom: true, // 不允许缩放
    );
  }
}
