import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isInitialized = false;
  bool _isPaused = false;
  String? _currentText;
  int _pauseIndex = 0;

  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      // Set up TTS configuration
      await _flutterTts.setLanguage("en-US");
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      // Set up progress handler for pause functionality (SDK 26+)
      _flutterTts.setProgressHandler((String text, int startOffset, int endOffset, String word) {
        // Store the current position for pause functionality
        if (_isPaused) {
          _pauseIndex = startOffset;
        }
      });

      // Set up completion handler
      _flutterTts.setCompletionHandler(() {
        print("TTS completed");
        _currentText = null;
        _pauseIndex = 0;
        _isPaused = false;
      });

      // Set up error handler
      _flutterTts.setErrorHandler((msg) {
        print("TTS Error: $msg");
      });

      _isInitialized = true;
      print("TTS initialized successfully");
    } catch (e) {
      print("TTS initialization error: $e");
    }
  }

  Future<void> speak(String text) async {
    if (!_isInitialized) {
      await initialize();
    }

    try {
      // If resuming from pause, use the remaining text
      String textToSpeak = text;
      if (_isPaused && _currentText != null && _pauseIndex > 0) {
        textToSpeak = _currentText!.substring(_pauseIndex);
        _isPaused = false;
        _pauseIndex = 0;
      } else {
        _currentText = text;
      }

      await _flutterTts.speak(textToSpeak);
    } catch (e) {
      print("TTS speak error: $e");
    }
  }

  Future<void> pause() async {
    try {
      // Note: Android TTS pause is a workaround using onRangeStart
      // Works on SDK 26+ due to onRangeStart method availability
      _isPaused = true;
      await _flutterTts.pause();
      print("TTS paused at index: $_pauseIndex");
    } catch (e) {
      print("TTS pause error: $e");
    }
  }

  Future<void> stop() async {
    try {
      await _flutterTts.stop();
      _currentText = null;
      _pauseIndex = 0;
      _isPaused = false;
    } catch (e) {
      print("TTS stop error: $e");
    }
  }

  Future<void> resume() async {
    if (_isPaused && _currentText != null) {
      await speak(_currentText!);
    }
  }

  // Getters for status
  bool get isPaused => _isPaused;
  bool get isInitialized => _isInitialized;

  // Configuration methods
  Future<void> setSpeechRate(double rate) async {
    await _flutterTts.setSpeechRate(rate);
  }

  Future<void> setVolume(double volume) async {
    await _flutterTts.setVolume(volume);
  }

  Future<void> setPitch(double pitch) async {
    await _flutterTts.setPitch(pitch);
  }

  Future<void> setLanguage(String language) async {
    await _flutterTts.setLanguage(language);
  }
}