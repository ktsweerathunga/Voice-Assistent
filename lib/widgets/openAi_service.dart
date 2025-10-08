import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenaiService {
  // Get API key from environment variables
  String get openaiApiKey => dotenv.env['API_KEY'] ?? '';

  /// Store chat messages
  final List<Map<String, dynamic>> messages = [];

  Future <String> isArtPromtApi(String prompt) async{
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openaiApiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user", 
              "content": "Does this message want to generate an AI picture, image, art, or anything similar? $prompt . Simply answer with a yes or no."
            }
          ]
        }),
      );
      print (res.body);

      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content.trim();
        if (content.toLowerCase().contains("yes")) {
          final res = await DallEApi(prompt);
          return res;
        }else if (content.toLowerCase().contains("no")) {
          final res = await ChatGPTApi(prompt);
          return res;
        } else {
          return "Error: Unexpected response content";
        }
        
      } else {
        return "Error: ${res.statusCode}";
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future <String> ChatGPTApi(String prompt) async {

    messages.add({
      "role": "user",
      "content": prompt,
    });

    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openaiApiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages
        }),
      );
      print (res.body);
      
      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content.trim();
        if (content.toLowerCase().contains("yes")) {
          final res = await DallEApi(prompt);
          return res;
        }else if (content.toLowerCase().contains("no")) {
          final res = await ChatGPTApi(prompt);
          return res;
        } else {
          return "Error: Unexpected response content";
        }
        
      } else {
        return "Error: ${res.statusCode}";
      }
    } catch (e) {
      return e.toString();
    }
  }

   Future <String> DallEApi(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openaiApiKey",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              "role": "user", 
              "content": "Does this message want to generate an AI picture, image, art, or anything similar? $prompt . Simply answer with a yes or no."
            }
          ]
        }),
      );
      print (res.body);
      
      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content.trim();
        if (content.toLowerCase().contains("yes")) {
          final res = await DallEApi(prompt);
          return res;
        }else if (content.toLowerCase().contains("no")) {
          final res = await ChatGPTApi(prompt);
          return res;
        } else {
          return "Error: Unexpected response content";
        }
        
      } else {
        return "Error: ${res.statusCode}";
      }
    } catch (e) {
      return e.toString();
    }
  }
}