import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Personel {
  final int id;
  final String ad;
  final String soyad;
  final String eposta;

  Personel({this.id, this.ad, this.soyad,this.eposta});

  factory Personel.fromJson(Map<String, dynamic> json) {
    return Personel(
      id: json['id'],
      ad: json['ad'],
      soyad: json['soyad'],
      eposta: json['eposta']
    );
  }
}

class PersonelListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Personel>>(
      future: _fetchJobs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Personel> data = snapshot.data;
          return _personelListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }

  Future<List<Personel>> _fetchJobs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token=sharedPreferences.getString("access_token");

    final jobsListAPIUrl = 'https://api_temp.k12mos.com/api/personel';

    final response = await http.get(jobsListAPIUrl,
        headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      "Authorization":'Bearer $token'}
      );

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Personel.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _personelListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].id, data[index].ad,data[index].soyad, data[index].eposta);
        });
  }

  ListTile _tile(int id, String ad, String soyad, String eposta) => ListTile(
    title: Text(ad+" "+soyad,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(eposta),
  );
}