import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {

  static const apiKey = "AIzaSyD7-xmGYylHe26OyWSemMbUa5KUkoYWgNo";

  static Future<String> askAI(String prompt) async {

    final url = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$apiKey"
    );

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]
          }
        ]
      }),
    );

    final data = jsonDecode(response.body);

    return data["candidates"][0]["content"]["parts"][0]["text"];
  }
}
