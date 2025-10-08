import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

// Models
import 'package:voice_assistent/models/chat_message.dart';
import 'package:voice_assistent/models/quick_action.dart';

// Services
import 'package:voice_assistent/services/ai_assistant_service.dart';

// Config & Constants
import 'package:voice_assistent/color_palete.dart';
import 'package:voice_assistent/config/app_constants.dart';

// Widgets
import 'package:voice_assistent/widgets/animated_avatar.dart';
import 'package:voice_assistent/widgets/bottom_input_bar.dart';
import 'package:voice_assistent/widgets/chat_section.dart';
import 'package:voice_assistent/widgets/quick_action_grid.dart';

/// Main screen for the AI Voice Assistant
/// Handles state management and coordinates between UI components and services
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  // Animation Controllers
  late AnimationController _pulseController;
  late AnimationController _listeningController;
  late AnimationController _typingController;
  
  // Animations
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _waveAnimation;
  
  // State Variables
  bool _isListening = false;
  bool _isDarkMode = false;
  bool _isTyping = false;
  
  // Data
  final List<ChatMessage> _messages = [];
  final List<QuickAction> _quickActions = QuickActionData.getDefaultActions();
  
  // Controllers
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  
  // Services
  final AiAssistantService _aiAssistantService = AiAssistantService();
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _initializeServices();
  }

  @override
  void dispose() {
    _disposeControllers();
    _disposeServices();
    super.dispose();
  }

  // ==================== INITIALIZATION ====================

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: AppConstants.pulseAnimationDuration,
      vsync: this,
    )..repeat(reverse: true);
    
    _listeningController = AnimationController(
      duration: AppConstants.listeningAnimationDuration,
      vsync: this,
    );
    
    _typingController = AnimationController(
      duration: AppConstants.typingAnimationDuration,
      vsync: this,
    )..repeat();
    
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.1)
        .animate(CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut));
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.15)
        .animate(CurvedAnimation(parent: _listeningController, curve: Curves.elasticOut));
    
    _waveAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _typingController, curve: Curves.easeInOut));
  }

  Future<void> _initializeServices() async {
    await _initializeSpeechToText();
    await _initializeTextToSpeech();
  }

  Future<void> _initializeSpeechToText() async {
    await _speechToText.initialize();
    setState(() {});
  }

  Future<void> _initializeTextToSpeech() async {
    await _flutterTts.setSharedInstance(true);
    await _flutterTts.setLanguage(AppConstants.defaultTtsLanguage);
    await _flutterTts.setSpeechRate(AppConstants.defaultTtsSpeechRate);
    await _flutterTts.setVolume(AppConstants.defaultTtsVolume);
    await _flutterTts.setPitch(AppConstants.defaultTtsPitch);
    setState(() {});
  }

  void _disposeControllers() {
    _pulseController.dispose();
    _listeningController.dispose();
    _typingController.dispose();
    _textController.dispose();
    _scrollController.dispose();
  }

  void _disposeServices() {
    _speechToText.stop();
    _flutterTts.stop();
  }

  // ==================== SPEECH RECOGNITION ====================

  Future<void> _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() => _isListening = true);
    _listeningController.forward();
  }

  Future<void> _stopListening() async {
    await _speechToText.stop();
    setState(() => _isListening = false);
    _listeningController.reverse();
  }

  void _toggleListening() async {
    if (!_speechToText.isListening) {
      if (_speechToText.isAvailable) {
        await _startListening();
      } else {
        await _initializeSpeechToText();
        if (_speechToText.isAvailable) {
          await _startListening();
        } else {
          _showPermissionError();
        }
      }
    } else {
      await _stopListening();
    }
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    final lastWords = result.recognizedWords;
    if (lastWords.isNotEmpty && result.finalResult) {
      _stopListening();
      _processUserInput(lastWords);
    }
  }

  void _showPermissionError() {
    final errorMessage = ChatMessage(
      text: AppConstants.speechPermissionError,
      isUser: false,
      timestamp: DateTime.now(),
      type: MessageType.error,
    );
    setState(() => _messages.add(errorMessage));
  }

  // ==================== TEXT-TO-SPEECH ====================

  Future<void> _speak(String content) async {
    await _flutterTts.speak(content);
  }

  // ==================== MESSAGE PROCESSING ====================

  void _sendTextMessage() {
    final text = _textController.text.trim();
    if (text.isNotEmpty) {
      _processUserInput(text);
      _textController.clear();
    }
  }

  Future<void> _processUserInput(String input) async {
    try {
      // Add user message
      final userMessage = ChatMessage(
        text: input,
        isUser: true,
        timestamp: DateTime.now(),
      );
      
      setState(() {
        _messages.add(userMessage);
        _isTyping = true;
      });

      // Process through AI service
      final response = await _aiAssistantService.processRecognizedWords(input);
      
      // Create AI response message
      final aiMessage = ChatMessage(
        text: response['content'],
        isUser: false,
        timestamp: DateTime.now(),
        imageUrl: response['imageUrl'],
        type: _getMessageType(response['type']),
      );

      setState(() {
        _isTyping = false;
        _messages.add(aiMessage);
      });

      // Speak the response if successful
      if (response['success'] == true && response['content'] != null) {
        await _speak(response['content']);
      }

      _scrollToBottom();

    } catch (e) {
      print('Error processing input: $e');
      final errorMessage = ChatMessage(
        text: 'Sorry, I encountered an error: $e',
        isUser: false,
        timestamp: DateTime.now(),
        type: MessageType.error,
      );
      
      setState(() {
        _isTyping = false;
        _messages.add(errorMessage);
      });
    }
  }

  MessageType _getMessageType(String? type) {
    switch (type) {
      case 'image':
        return MessageType.image;
      case 'error':
        return MessageType.error;
      default:
        return MessageType.text;
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: AppConstants.scrollAnimationDuration,
        curve: Curves.easeOut,
      );
    }
  }

  // ==================== QUICK ACTIONS ====================

  void _onQuickActionTapped(QuickAction action) {
    _speak(action.title);
    _processUserInput(action.message);
  }

  // ==================== UI BUILDERS ====================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : ColorPalette.whiteColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // Animated Avatar Section
          AnimatedAvatar(
            pulseAnimation: _pulseAnimation,
            scaleAnimation: _scaleAnimation,
            waveAnimation: _waveAnimation,
            isListening: _isListening,
            isDarkMode: _isDarkMode,
          ),
          
          // Main Content Area
          Expanded(
            child: _messages.isEmpty 
                ? QuickActionGrid(
                    actions: _quickActions,
                    isDarkMode: _isDarkMode,
                    onActionTapped: _onQuickActionTapped,
                  )
                : ChatSection(
                    messages: _messages,
                    isTyping: _isTyping,
                    isDarkMode: _isDarkMode,
                    scrollController: _scrollController,
                    typingAnimation: _waveAnimation,
                    onMessageSpeak: _speak,
                  ),
          ),
          
          // Bottom Input Bar
          BottomInputBar(
            textController: _textController,
            isDarkMode: _isDarkMode,
            isListening: _isListening,
            onSendMessage: _sendTextMessage,
            onToggleListening: _toggleListening,
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _isDarkMode ? const Color(0xFF2A2A2A) : ColorPalette.whiteColor,
      elevation: 0,
      title: Text(
        AppConstants.appTitle,
        style: TextStyle(
          color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
          fontWeight: FontWeight.bold,
          fontSize: AppConstants.appBarTitleSize,
        ),
      ),
      leading: Icon(
        Icons.menu,
        color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() => _isDarkMode = !_isDarkMode);
          },
          icon: Icon(
            _isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
          ),
        ),
        IconButton(
          onPressed: () {
            // TODO: Implement settings functionality
          },
          icon: Icon(
            Icons.settings,
            color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
          ),
        ),
      ],
      centerTitle: true,
    );
  }
}