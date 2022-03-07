import 'dart:convert';
import 'dart:io';

import 'package:findzipcode/zip_code.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FindZipScreen extends StatefulWidget {
  const FindZipScreen({Key? key}) : super(key: key);

  @override
  State<FindZipScreen> createState() => _FindZipScreenState();
}

class _FindZipScreenState extends State<FindZipScreen> {
  final _zoneCodeTextEditingController = TextEditingController();
  final _addressTextEditingController = TextEditingController();
  final _address2TextEditingController = TextEditingController();
  final _TextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        // initialUrl: 'http://10.0.2.2:5500/index.html',
        initialUrl: 'http://192.168.0.80:5500/index.docs',
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: <JavascriptChannel>{
          JavascriptChannel(
            onMessageReceived: (JavascriptMessage message) {
              Map<String, dynamic> json = jsonDecode(message.message);
              ZipCode zipCode = ZipCode.fromJson(json);
              Navigator.pop(context, zipCode);
            },
            name: 'zipcode',
          )
        },
      ),
    );
  }
}
