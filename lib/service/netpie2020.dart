import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:termometer/model/model.dart';

class NETPIE2020 {
  // publish message topic
  Future<bool> publish(
      String topic, String clientId, String token, String message) async {
    // sent request token
    String deviceAuth = 'Device ' + clientId + ":" + token;
    Response response =
        await http.put("https://api.netpie.io/v2/device/message?topic=" + topic,
            headers: <String, String>{
              'Authorization': deviceAuth,
            },
            body: message);
    log("statusCode -> " + response.statusCode.toString());
    if (response.statusCode == HttpStatus.ok) {
      return true;
    } else {
      return false;
    }
  }

  // read data from shadow
  Future<Device> readShadow(String clientId, String token) async {
    // sent request token
    String deviceAuth = 'Device ' + clientId + ":" + token;
    Response response = await http.get(
      "https://api.netpie.io/v2/device/shadow/data",
      headers: <String, String>{
        'Authorization': deviceAuth,
      },
    );
    log("statusCode -> " + response.statusCode.toString());
    log("jsonBody -> " + response.body.toString());
    return Device.fromJson(json.decode(response.body));
  }
}
