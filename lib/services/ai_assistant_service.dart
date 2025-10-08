import 'package:voice_assistent/widgets/openAi_service.dart';

class AiAssistantService {
  final OpenaiService _openaiService = OpenaiService();

  /// Process the recognized words through OpenAI service
  Future<Map<String, dynamic>> processRecognizedWords(String lastWords) async {
    try {
      print('Processing speech input: $lastWords'); // Debug output
      
      // Check if the prompt is asking for art/image generation
      print('Calling isArtPromtApi...'); // Debug output
      String isArtResponse = await _openaiService.isArtPromtApi(lastWords);
      print('isArtPromtApi response: $isArtResponse'); // Debug output
      
      // Process based on whether it's an art request or not
      if (isArtResponse.toLowerCase().contains('yes')) {
        print('Detected art request - calling DALL-E'); // Debug output
        // It's an art request - call DALL-E
        String imageUrl = await _generateImage(lastWords);
        return {
          'success': true,
          'type': 'image',
          'content': 'I generated an image for you: $imageUrl',
          'imageUrl': imageUrl,
        };
      } else {
        print('Detected chat request - calling ChatGPT'); // Debug output
        // It's a regular chat request - call ChatGPT
        String textResponse = await _generateTextResponse(lastWords);
        return {
          'success': true,
          'type': 'text',
          'content': textResponse,
        };
      }
    } catch (e) {
      print('Error processing speech: $e');
      return {
        'success': false,
        'type': 'error',
        'content': 'Sorry, I encountered an error processing your request: $e',
      };
    }
  }

  /// Generate image using DALL-E API
  Future<String> _generateImage(String prompt) async {
    try {
      String imageUrl = await _openaiService.DallEApi(prompt);
      return imageUrl;
    } catch (e) {
      throw Exception('Sorry, I couldn\'t generate an image right now. Error: $e');
    }
  }

  /// Generate text response using ChatGPT API
  Future<String> _generateTextResponse(String prompt) async {
    try {
      String response = await _openaiService.ChatGPTApi(prompt);
      return response;
    } catch (e) {
      throw Exception('Sorry, I couldn\'t process your request right now. Error: $e');
    }
  }

  /// Process text message (for typed input)
  Future<Map<String, dynamic>> processTextMessage(String text) async {
    // Use the same processing logic for both voice and text input
    return await processRecognizedWords(text);
  }

  /// Check if a message is requesting art/image generation
  Future<bool> isArtRequest(String prompt) async {
    try {
      String response = await _openaiService.isArtPromtApi(prompt);
      return response.toLowerCase().contains('yes');
    } catch (e) {
      print('Error checking if art request: $e');
      return false;
    }
  }

  /// Generate only text response (for when you specifically want text)
  Future<String> generateTextOnly(String prompt) async {
    return await _generateTextResponse(prompt);
  }

  /// Generate only image (for when you specifically want image)
  Future<String> generateImageOnly(String prompt) async {
    return await _generateImage(prompt);
  }
}