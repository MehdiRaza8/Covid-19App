import 'dart:convert';

import 'package:covid19app/Model/world._states.dart';
import 'package:covid19app/Services/utilities/app_url.dart';
import 'package:covid19app/Views.dart/world_states.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<Worls_State> fetchWorldApi() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateList));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Worls_State.fromJson(data);
    } else {
      throw Exception('error');
    }
  }
}
