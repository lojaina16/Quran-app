import 'dart:convert';
import 'package:quran_app/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/model/usersResponse.dart';

class ApiManager {
  static Future<List<UsersResponse>> getUsers() async {
    Uri url = Uri.https(ApiConstants.baseUrl, ApiConstants.userApi);

    try {
      var response = await http.get(url);

      // Check if the response is successful
      if (response.statusCode == 200) {
        // Decode the response body as a list
        var jsonList = jsonDecode(response.body) as List;

        // Map the list of JSON objects to a list of UsersResponse objects
        return jsonList.map((json) => UsersResponse.fromJson(json)).toList();
      } else {
        // Throw an exception if the response is not successful
        throw Exception('Failed to load users: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the request
      throw Exception('Error occurred while fetching users: $e');
    }
  }
}
