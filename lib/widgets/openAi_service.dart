import 'dart:convert';
import 'package:http/http.dart' as http;

class OpenaiService {
  static const String _baseUrl = 'https://api.openai.com/v1';
  
  // API key will be loaded from environment or config file
  static String? _apiKey;
  
  // Initialize API key (call this in your app startup)
  static void initialize(String apiKey) {
    _apiKey = apiKey;
  }
  
  Future<String> generateResponse(String prompt) async {
    if (_apiKey == null || _apiKey!.isEmpty) {
      throw Exception('OpenAI API key not configured. Please set your API key.');
    }
    
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $_apiKey',
        },
        body: jsonEncode({
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content': prompt,
            },
          ],
          'max_tokens': 150,
          'temperature': 0.7,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['choices'][0]['message']['content'].toString().trim();
      } else {
        throw Exception('Failed to generate response: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error communicating with OpenAI: $e');
    }
  }
}