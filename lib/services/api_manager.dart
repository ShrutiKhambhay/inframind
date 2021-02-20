import 'dart:convert';

import 'package:trackhealth/models/healthinfo.dart';
import 'package:http/http.dart';

// ignore: camel_case_types
class API_Manager {
  // ignore: non_constant_identifier_names
  final String health_url = 'https://healthtrackapp.herokuapp.com/api/normal/';
  Future getInfo() async {
    final Response response = await get(health_url);
    var data = jsonDecode(response.body);
    // var client = http.Client();
    // // ignore: avoid_init_to_null
    // //var wel = null;
    // try {
    //    print(await client.get(Strings.health_url));
    //  /* if (response.statusCode == 200) {
    //     var jsonString = response.body;
    //     var jsonMap = json.decode(jsonString);
    //     wel = Welcome.fromJson(jsonMap);*/
    //   }
    //  finally {
    //   client.close();
    // }
    //return wel;
    return Welcome.fromJson(data);
  }
}
