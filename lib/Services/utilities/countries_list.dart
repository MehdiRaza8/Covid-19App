import 'dart:convert';

import 'package:covid19app/Model/countries_list.dart';
import 'package:covid19app/Views.dart/countries.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<CountriesModel> countries = [];
Future<List<CountriesModel>> countriesApi() async {
  final response =
      await http.get(Uri.parse('https://disease.sh/v3/covid-19/countries'));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    for (var i in data) {
      countries.add(CountriesModel.fromJson(i));
    }
    return countries;
  } else {
    return countries;
  }
}
