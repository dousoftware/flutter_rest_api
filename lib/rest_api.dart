import 'dart:convert';

import 'package:http/http.dart' as http;

// class URLS {
//   static const String BASE_URL = 'https://aodapi.eralpsoftware.net';
// }

class ApiService {
  static Future<List<dynamic>> getListTodo() async {

    final response = await http.get('https://api_temp.k12mos.com/api/personel', headers: {
      "Authorization":"Bearer eyJhbGciOiJSUzI1NiIsImtpZCI6IjI5RTA3QTZBRjRDRjQ3RDNGQkY2MkZBNjAyMTlCRUNDQTIzOUM2MjlSUzI1NiIsInR5cCI6ImF0K2p3dCIsIng1dCI6IktlQjZhdlRQUjlQNzlpLW1BaG0tektJNXhpayJ9.eyJuYmYiOjE2MjAzMDA3MDcsImV4cCI6MTYyMDMyOTUwNywiaXNzIjoiaHR0cHM6Ly9pZHNydi5rMTJtb3MuY29tIiwiYXVkIjoiUGVyc29uZWxBUEkiLCJjbGllbnRfaWQiOiJrMTIucGVyc29uZWwiLCJzdWIiOiJrMTJQZXJzb25lbCIsImF1dGhfdGltZSI6MTYyMDMwMDcwNywiaWRwIjoibG9jYWwiLCJpZF91cnVuIjoiNjI4OCIsImlkX3VzZXIiOiIzNTY1IiwiaWRfdW52YW4iOiIwIiwicm9sZXMiOiIwIiwia3VydW1fYWRpIjoiMCIsImpzb25feWV0a2kiOiIwIiwiaWRfc2VoaXIiOiIwIiwiY2VwVGVsIjoiMCIsImt2a2siOiIwIiwiZGVtb19saXNhbnMiOiIwIiwiYWdlbnRfaWQiOiIwIiwia3VsbGFuaWNpX3lldGtpIjoiMCIsImt1cnVtX3R1ciI6IjAiLCJrdXJ1bV90dXJfbm8iOiIwIiwiYWt0aWYiOiIwIiwic2l0ZV9pZCI6IjAiLCJrX2FkaSI6IjAiLCJrX3NveWFkaSI6IjAiLCJqdGkiOiJGRUU2M0NGRUVBNzk2ODNFOEE1MjM4OTk1RkI1MzE1NyIsImlhdCI6MTYyMDMwMDcwNywic2NvcGUiOlsiazEyLnBlcnNvbmVsLmFwaSJdLCJhbXIiOlsicHdkIl19.M-Z8dfOPGs_a3UUtMVR6h4zzMSuUg00fKcDYMX27k2sRWTESBgMxY038a9OCn-nxvm_RrMYKWoxB_bvUzn8WLgJLo2RNXmyv4KZAOHXfdZ9tWTJ0zMlTO2Y8bGftV-F0v1GHL-dMmpTuF-3OGQA6Yap5vKO06T5-s-CNKGKMmTtxCXSwakIxy8PSm-cgfh8SpB-OpVWkVQ7G3_PYNLR2l-OMenKOG6oc0E-WFj3XtblgOrUHpYvN--CzULXzMrV2wI-1IzoRT4XBrqQe8DAno6y9p8XBr67sgAlt7DlyEburzA7LxGK5RQOuzD0xQE8L9wyTRtyzbW70zUFNa0vK0g",
    },);
    if (response.statusCode == 200) {

      return json.decode(response.body);
    } else {
      return null;
    }
  }
//
// static Future<bool> addEmployee(body) async {
//
//   final response = await http.post('${URLS.BASE_URL}/create', body: jsonEncode);
//   if (response.statusCode == 200) {
//     return true;
//   } else {
//     return false;
//   }
// }
}