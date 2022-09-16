import 'dart:convert';

import 'package:covid19app/Model/world._states.dart';

import 'package:covid19app/Views.dart/world_states.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<WorldModelsState> fetchApi() async {
  final response =
      await http.get(Uri.parse('https://disease.sh/v3/covid-19/all'));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return WorldModelsState.fromJson(data);
  } else {
    return WorldModelsState.fromJson(data);
  }
}
