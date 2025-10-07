import 'dart:convert';

import 'package:http/http.dart' as http;

class OpenaiService {

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
              "content": "Does this message want to generate an AI picture, image, art, or anything similar? $prompt . Simply answer with a yes or no."}
          ]
        });
    } catch (e) {
      return e.toString();
    }
  }

  Future <String> ChatGPTApi(String prompt) {
  
  }

   Future <String> DallEApi(String prompt) {
  
  }
}