import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:personel_demo/list.dart';
import 'package:personel_demo/login_page.dart';
import 'package:personel_demo/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';




//async eklemedim diye çalışmamış
void main() async{
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
      MyApp()

  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hoş Geldiniz",
      home: MainPage(),
      theme: ThemeData(
          accentColor: Colors.white70
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _MainPageState extends State<MainPage> {

  SharedPreferences sharedPreferences;


  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    getLiist();
  }

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("access_token") == null) {
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
    }
  }

   getLiist() async{
    print("test1");
    sharedPreferences = await SharedPreferences.getInstance();
    String token=sharedPreferences.getString("access_token");

    //listeleme yeri
    http.Response response = await http.get(
        'https://api_temp.k12mos.com/api/personel',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          "Authorization":'Bearer $token'});

    if (response.statusCode == 200) {

      final _jsonBody = response.body;

      return jsonDecode(_jsonBody);
    } else {
      print(response.body);
      return null;
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personel Listesi", style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              sharedPreferences.clear();
              sharedPreferences.commit();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => LoginPage()), (Route<dynamic> route) => false);
            },
            child: Text("Çıkış Yap", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
      body: Center(child: PersonelListView()
      ),
      drawer: Drawer(),
    );
  }



}
//bu datayı liste olarak map leyeceksin sonra listview builder ile ekrana listeleyeceksin