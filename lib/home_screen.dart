import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_assistent/color_palete.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
  with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _listeningController;
  late AnimationController _typingController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _waveAnimation;
  
  bool _isListening = false;
  bool _isDarkMode = false;
  bool _isTyping = false;
  List<Map<String, dynamic>> _messages = [];
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final speechToText = SpeechToText();

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    // Initialize speech-to-text functionality here if needed
     await speechToText.initialize();
     setState(() {
       
     });
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _listeningController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
    
    _pulseAnimation = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.15,
    ).animate(CurvedAnimation(
      parent: _listeningController,
      curve: Curves.elasticOut,
    ));
    
    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _typingController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _listeningController.dispose();
    _typingController.dispose();
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
    });
    
    if (_isListening) {
      _listeningController.forward();
    } else {
      _listeningController.reverse();
    }
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _sendMessage(String message) {
    if (message.trim().isEmpty) return;
    
    setState(() {
      _messages.add({
        'text': message,
        'isUser': true,
        'timestamp': DateTime.now(),
      });
      _isTyping = true;
    });
    
    _textController.clear();
    _scrollToBottom();
    
    // Simulate AI thinking and response
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isTyping = false;
        _messages.add({
          'text': _generateAIResponse(message),
          'isUser': false,
          'timestamp': DateTime.now(),
        });
      });
      _scrollToBottom();
    });
  }

  String _generateAIResponse(String userMessage) {
    final responses = {
      'weather': 'The weather today is sunny with a temperature of 24°C. Perfect for outdoor activities! ☀️',
      'reminder': 'I have set a reminder for tomorrow. I will make sure to notify you at the right time! ⏰',
      'joke': 'Why do not scientists trust atoms? Because they make up everything! 😄',
      'music': 'Playing your favorite playlist now. Enjoy the music! 🎵',
      'news': 'Here are today top headlines: Technology stocks are rising, and there is exciting news in AI development! 📰',
      'help': 'I can help you with weather, reminders, jokes, music, news, and much more! What would you like to know?',
    };
    
    String lowerMessage = userMessage.toLowerCase();
    for (String key in responses.keys) {
      if (lowerMessage.contains(key)) {
        return responses[key]!;
      }
    }
    
    return 'That is interesting! I am still learning, but I would love to help you with that. Could you tell me more about what you need? 🤖';
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : ColorPalette.whiteColor,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          // AI Avatar Section
          _buildAvatarSection(),
          
          // Quick Actions or Chat Messages
          Expanded(
            child: _messages.isEmpty ? _buildQuickActions() : _buildChatSection(),
          ),
          
          // Input Section
          _buildInputSection(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: _isDarkMode ? const Color(0xFF2A2A2A) : ColorPalette.whiteColor,
      elevation: 0,
      title: Text(
        'AI Assistant',
        style: TextStyle(
          color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      leading: Icon(
        Icons.menu,
        color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
      ),
      actions: [
        IconButton(
          onPressed: _toggleTheme,
          icon: Icon(
            _isDarkMode ? Icons.light_mode : Icons.dark_mode,
            color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
          ),
        ),
        IconButton(
          onPressed: () {
            // Settings action
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

  Widget _buildAvatarSection() {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: _isDarkMode
              ? [
                  const Color(0xFF2A2A2A),
                  const Color(0xFF1A1A1A),
                ]
              : [
                  ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),
                  ColorPalette.whiteColor,
                ],
        ),
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _pulseAnimation.value,
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer glow effect
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: (_isListening 
                                    ? ColorPalette.thirdSuggestionBoxColor 
                                    : ColorPalette.assistentCircleColor).withOpacity(0.4),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        // Main avatar
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: _isListening
                                  ? [
                                      ColorPalette.thirdSuggestionBoxColor,
                                      ColorPalette.secondSuggestionBoxColor,
                                    ]
                                  : [
                                      ColorPalette.assistentCircleColor,
                                      ColorPalette.firstSuggestionBoxColor,
                                    ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _isListening ? Icons.mic : Icons.smart_toy,
                            size: 50,
                            color: ColorPalette.mainFontColor,
                          ),
                        ),
                        // Wave animation when listening
                        if (_isListening) _buildWaveAnimation(),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWaveAnimation() {
    return AnimatedBuilder(
      animation: _waveAnimation,
      builder: (context, child) {
        return Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorPalette.thirdSuggestionBoxColor.withOpacity(
                (1 - _waveAnimation.value) * 0.5,
              ),
              width: 2,
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {
        'title': 'Ask about Weather',
        'subtitle': 'Get current weather info',
        'icon': Icons.wb_sunny,
        'color': ColorPalette.firstSuggestionBoxColor,
        'message': 'What is the weather like today?',
        'gradient': [ColorPalette.firstSuggestionBoxColor, const Color(0xFFB3E5FC)],
      },
      {
        'title': 'Set Reminder',
        'subtitle': 'Create a new reminder',
        'icon': Icons.alarm,
        'color': ColorPalette.secondSuggestionBoxColor,
        'message': 'Set a reminder for tomorrow',
        'gradient': [ColorPalette.secondSuggestionBoxColor, const Color(0xFF81C784)],
      },
      {
        'title': 'Tell me a Joke',
        'subtitle': 'Brighten your day',
        'icon': Icons.sentiment_very_satisfied,
        'color': ColorPalette.thirdSuggestionBoxColor,
        'message': 'Tell me a funny joke',
        'gradient': [ColorPalette.thirdSuggestionBoxColor, const Color(0xFFFFB74D)],
      },
      {
        'title': 'Play Music',
        'subtitle': 'Start your playlist',
        'icon': Icons.music_note,
        'color': const Color(0xFFE1BEE7),
        'message': 'Play my favorite music',
        'gradient': [const Color(0xFFE1BEE7), const Color(0xFFCE93D8)],
      },
      {
        'title': 'Get News',
        'subtitle': 'Latest headlines',
        'icon': Icons.newspaper,
        'color': const Color(0xFFFFCDD2),
        'message': 'Show me today news',
        'gradient': [const Color(0xFFFFCDD2), const Color(0xFFEF9A9A)],
      },
      {
        'title': 'Help & Support',
        'subtitle': 'Learn what I can do',
        'icon': Icons.help_outline,
        'color': const Color(0xFFDCEDC8),
        'message': 'What can you help me with?',
        'gradient': [const Color(0xFFDCEDC8), const Color(0xFFC8E6C9)],
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'How can I help you today?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
            ),
            itemCount: actions.length,
            itemBuilder: (context, index) {
              final action = actions[index];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _isDarkMode
                        ? [const Color(0xFF3A3A3A), const Color(0xFF2A2A2A)]
                        : action['gradient'] as List<Color>,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: (action['color'] as Color).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => _sendMessage(action['message'] as String),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: ColorPalette.whiteColor.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              action['icon'] as IconData,
                              color: ColorPalette.mainFontColor,
                              size: 28,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            action['title'] as String,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            action['subtitle'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.7),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildChatSection() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: _messages.length + (_isTyping ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == _messages.length && _isTyping) {
                return _buildTypingIndicator();
              }
              final message = _messages[index];
              return _buildMessageBubble(
                message['text'],
                message['isUser'],
                message['timestamp'],
              );
            },
          ),
        ),
        _buildQuickReplies(),
      ],
    );
  }

  Widget _buildMessageBubble(String message, bool isUser, DateTime timestamp) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) _buildAvatar(false),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: isUser
                        ? LinearGradient(
                            colors: [
                              ColorPalette.mainFontColor,
                              ColorPalette.mainFontColor.withOpacity(0.8),
                            ],
                          )
                        : LinearGradient(
                            colors: _isDarkMode
                                ? [const Color(0xFF3A3A3A), const Color(0xFF4A4A4A)]
                                : [ColorPalette.firstSuggestionBoxColor, ColorPalette.firstSuggestionBoxColor.withOpacity(0.7)],
                          ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isUser
                          ? ColorPalette.whiteColor
                          : (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor),
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 12,
                    color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (isUser) _buildAvatar(true),
        ],
      ),
    );
  }

  Widget _buildAvatar(bool isUser) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isUser 
            ? ColorPalette.mainFontColor 
            : (_isDarkMode ? const Color(0xFF3A3A3A) : ColorPalette.assistentCircleColor),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        isUser ? Icons.person : Icons.smart_toy,
        color: isUser 
            ? ColorPalette.whiteColor 
            : (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor),
        size: 20,
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          _buildAvatar(false),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _isDarkMode ? const Color(0xFF3A3A3A) : ColorPalette.firstSuggestionBoxColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDot(0),
                const SizedBox(width: 4),
                _buildDot(1),
                const SizedBox(width: 4),
                _buildDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _typingController,
      builder: (context, child) {
        double offset = (index * 0.2) % 1.0;
        double animValue = (_typingController.value + offset) % 1.0;
        return Transform.translate(
          offset: Offset(0, -10 * (1 - (2 * animValue - 1).abs())),
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuickReplies() {
    if (_messages.isEmpty) return const SizedBox.shrink();
    
    final quickReplies = ['Thanks!', 'Tell me more', 'That is helpful', 'What else?'];
    
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: quickReplies.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: Material(
              color: _isDarkMode ? const Color(0xFF3A3A3A) : ColorPalette.secondSuggestionBoxColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: () => _sendMessage(quickReplies[index]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Text(
                    quickReplies[index],
                    style: TextStyle(
                      color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _isDarkMode ? const Color(0xFF2A2A2A) : ColorPalette.whiteColor,
        border: Border(
          top: BorderSide(
            color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.borderColor).withOpacity(0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: _isDarkMode 
                    ? const Color(0xFF3A3A3A) 
                    : ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.borderColor).withOpacity(0.3),
                ),
              ),
              child: TextField(
                controller: _textController,
                style: TextStyle(
                  color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,
                ),
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(
                    color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 12),
          _buildActionButton(
            onTap: _toggleListening,
            gradient: _isListening
                ? [ColorPalette.thirdSuggestionBoxColor, ColorPalette.secondSuggestionBoxColor]
                : [ColorPalette.mainFontColor, ColorPalette.mainFontColor.withOpacity(0.8)],
            icon: _isListening ? Icons.mic : Icons.mic_none,
          ),
          const SizedBox(width: 8),
          _buildActionButton(
            onTap: () => _sendMessage(_textController.text),
            gradient: [ColorPalette.mainFontColor, ColorPalette.mainFontColor.withOpacity(0.8)],
            icon: Icons.send,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required VoidCallback onTap,
    required List<Color> gradient,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: gradient),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: gradient.first.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: ColorPalette.whiteColor,
          size: 24,
        ),
      ),
    );
  }
}
