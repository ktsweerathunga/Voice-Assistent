import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Service class for handling OpenAI API interactions
/// Handles ChatGPT, DALL-E, and art prompt detection
class OpenaiService {
  // Get API key from environment variables
  String get openaiApiKey => dotenv.env['API_KEY'] ?? '';

  /// Store chat messages for conversation context
  final List<Map<String, dynamic>> messages = [];

  /// Determines if a prompt is requesting image generation
  /// Returns the appropriate response based on the prompt type
  Future<String> isArtPromtApi(String prompt) async {
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
      
      print('Art detection response: ${res.body}');

      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        
        if (content.toLowerCase().contains("yes")) {
          final res = await DallEApi(prompt);
          return res;
        } else if (content.toLowerCase().contains("no")) {
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

  /// Generates text responses using ChatGPT API
  Future<String> ChatGPTApi(String prompt) async {
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

      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        
        messages.add({
          "role": "assistant",
          "content": content,
        });

        return content;
      } else {
        return "Error: ${res.statusCode}";
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// Generates images using DALL-E API
  /// Note: This implementation needs to be updated to use the correct DALL-E endpoint
  Future<String> DallEApi(String prompt) async {
    messages.add({
      "role": "user",
      "content": prompt,
    });

    try {
      // TODO: Update this to use the correct DALL-E endpoint
      // Current implementation is using ChatGPT endpoint which won't work for image generation
      final res = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $openaiApiKey",
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
          'size': '256x256',
          'response_format': 'url',
        }),
      );

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();
        
        messages.add({
          "role": "assistant",
          "content": imageUrl,
        });

        return imageUrl;
      } else {
        return "Error: ${res.statusCode}";
      }
    } catch (e) {
      return e.toString();
    }
  }

  /// Clears the conversation history
  void clearMessages() {
    messages.clear();
  }

  /// Gets the current conversation context
  List<Map<String, dynamic>> getMessages() {
    return List.from(messages);
  }
}