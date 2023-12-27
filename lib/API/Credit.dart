import 'package:http/http.dart' as http;


import 'dart:convert';
import 'package:http/http.dart' as http;

Future<double> fetchCredit(String username) async {
  final apiUrl = 'http://127.0.0.1:8000/credit';

  final response = await http.get(Uri.parse('$apiUrl?username=$username'));
  
  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    if (data.containsKey('credit')) {
      return data['credit'].toDouble();
    } else {
      throw Exception('Invalid API response: Credit key not found');
    }
  } else {
    throw Exception('Failed to fetch credit');
  }
}

