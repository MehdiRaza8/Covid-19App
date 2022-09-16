import 'dart:convert';

import 'package:covid19app/Model/countries_list.dart';
import 'package:covid19app/Views.dart/countries.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<dynamic>> countriesApi() async {
  var data;
  final response =
      await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
  data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    return data;
  } else {
    throw Exception('Error');
  }
}
