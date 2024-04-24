import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NoteServices {
  static Future<List?> getNoteAll() async {
    await dotenv.load(fileName: ".env");
    String url = "http://10.251.130.142:8000/api/agenda";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final agendas = json["payload"] as List;

      return agendas;
    } else {
      return null;
    }
  }

  static Future<List?> getNoteByCode(String id) async {
    await dotenv.load(fileName: ".env");
    String url = "http://10.251.130.142:8000/api/agenda/$id";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map;
      final agendas = json["payload"] as List;

      return agendas;
    } else {
      return null;
    }
  }

  static Future<bool> createNote(
      String name, String date, String time, String description) async {
    await dotenv.load(fileName: ".env");
    final body = {
      "name": name,
      "date": date,
      "time": time,
      "deskripsi": description
    };
    String url = "http://10.251.130.142:8000/api/agenda";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> updateAgenda(
      String name, String date, String time, String description, int id) async {
    await dotenv.load(fileName: ".env");
    final body = {
      "name": name,
      "date": date,
      "time": time,
      "deskripsi": description
    };

    String url = "http://10.251.130.142:8000/api/agenda/$id?_method=PUT";
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> deleteAgenda(int id) async {
    await dotenv.load(fileName: ".env");
    String url = "http://10.251.130.142:8000/api/agenda/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(
      uri,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
