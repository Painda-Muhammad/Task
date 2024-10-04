// repositories/event_repository.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/hospital_model.dart';

class EventRepository {
  final String apiUrl = 'https://mocki.io/v1/186e671a-5d4b-41e9-8f5d-9c84f41b1d8c'; // Replace with actual API

  Future<List<HospitalModel>> fetchHospitalsInfo() async {
    final response = await http.get(Uri.parse(apiUrl));
    print('API response $response');

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => HospitalModel.fromJson(json)).toList();
    } else {
      // Handle error or use local sample data
      throw Exception('Failed to load events');
    }
  }

  Future<HospitalModel> fetchEventDetails(String eventId) async {
    // Replace with actual API endpoint
    final response = await http.get(Uri.parse('$apiUrl/$eventId'));

    if (response.statusCode == 200) {
      return HospitalModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch event details');
    }
  }
}
