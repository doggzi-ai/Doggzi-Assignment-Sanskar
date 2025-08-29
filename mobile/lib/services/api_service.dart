import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/pet.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8000';

  static Map<String, String> getHeaders({String? token}) {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }

  // Auth endpoints
  static Future<Map<String, dynamic>> register(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: getHeaders(),
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Registration failed');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: getHeaders(),
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  // Pet endpoints
  static Future<List<Pet>> getPets(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/pets'),
        headers: getHeaders(token: token),
      );

      if (response.statusCode == 200) {
        final List<dynamic> petsJson = jsonDecode(response.body);
        return petsJson.map((json) => Pet.fromJson(json)).toList();
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Failed to load pets');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<Pet> addPet(String token, Pet pet) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/pets'),
        headers: getHeaders(token: token),
        body: jsonEncode(pet.toJson()),
      );

      if (response.statusCode == 200) {
        return Pet.fromJson(jsonDecode(response.body));
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Failed to add pet');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  static Future<void> deletePet(String token, String petId) async {
    try {
      final response = await http.delete(
        Uri.parse('$baseUrl/pets/$petId'),
        headers: getHeaders(token: token),
      );

      if (response.statusCode != 200) {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Failed to delete pet');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}
