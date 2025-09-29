import 'package:flutter/material.dart';import 'package:flutter/material.dart';impclass HomeScreen extends StatefulWidget {

import 'package:voice_assistent/color_palete.dart';

import 'package:voice_assistent/color_palete.dart';  const HomeScreen({super.key});

class HomeScreen extends StatefulWidget {

  const HomeScreen({super.key});



  @overrideclass HomeScreen extends StatefulWidget {  @override

  State<HomeScreen> createState() => _HomeScreenState();

}  const HomeScreen({super.key});  State<HomeScreen> createState() => _HomeScreenState();



class _HomeScreenState extends State<HomeScreen>}

    with TickerProviderStateMixin {

  late AnimationController _pulseController;  @override

  late AnimationController _listeningController;

  late AnimationController _typingController;  State<HomeScreen> createState() => _HomeScreenState();class _HomeScreenState extends State<HomeScreen>

  late Animation<double> _pulseAnimation;

  late Animation<double> _scaleAnimation;}    with TickerProviderStateMixin {

  late Animation<double> _waveAnimation;

    late AnimationController _pulseController;

  bool _isListening = false;

  bool _isDarkMode = false;class _HomeScreenState extends State<HomeScreen>  late AnimationController _listeningController;

  bool _isTyping = false;

  List<Map<String, dynamic>> _messages = [];    with TickerProviderStateMixin {  late Animation<double> _pulseAnimation;

  final TextEditingController _textController = TextEditingController();

  final ScrollController _scrollController = ScrollController();  late AnimationController _pulseController;  late Animation<double> _scaleAnimation;



  @override  late AnimationController _listeningController;  

  void initState() {

    super.initState();  late Animation<double> _pulseAnimation;  bool _isListening = false;

    _initializeAnimations();

  }  late Animation<double> _scaleAnimation;  List<Map<String, dynamic>> _messages = [];



  void _initializeAnimations() {    final TextEditingController _textController = TextEditingController();

    _pulseController = AnimationController(

      duration: const Duration(seconds: 2),  bool _isListening = false;

      vsync: this,

    )..repeat(reverse: true);  List<Map<String, dynamic>> _messages = [];  @override

    

    _listeningController = AnimationController(  final TextEditingController _textController = TextEditingController();  void initState() {

      duration: const Duration(milliseconds: 300),

      vsync: this,    super.initState();

    );

      @override    _pulseController = AnimationController(

    _typingController = AnimationController(

      duration: const Duration(milliseconds: 1500),  void initState() {      duration: const Duration(seconds: 2),

      vsync: this,

    )..repeat();    super.initState();      vsync: this,

    

    _pulseAnimation = Tween<double>(    _pulseController = AnimationController(    )..repeat(reverse: true);

      begin: 0.9,

      end: 1.1,      duration: const Duration(seconds: 2),    

    ).animate(CurvedAnimation(

      parent: _pulseController,      vsync: this,    _listeningController = AnimationController(

      curve: Curves.easeInOut,

    ));    )..repeat(reverse: true);      duration: const Duration(milliseconds: 200),

    

    _scaleAnimation = Tween<double>(          vsync: this,

      begin: 1.0,

      end: 1.15,    _listeningController = AnimationController(    );

    ).animate(CurvedAnimation(

      parent: _listeningController,      duration: const Duration(milliseconds: 200),    

      curve: Curves.elasticOut,

    ));      vsync: this,    _pulseAnimation = Tween<double>(

    

    _waveAnimation = Tween<double>(    );      begin: 0.8,

      begin: 0.0,

      end: 1.0,          end: 1.2,

    ).animate(CurvedAnimation(

      parent: _typingController,    _pulseAnimation = Tween<double>(    ).animate(CurvedAnimation(

      curve: Curves.easeInOut,

    ));      begin: 0.8,      parent: _pulseController,

  }

      end: 1.2,      curve: Curves.easeInOut,

  @override

  void dispose() {    ).animate(CurvedAnimation(    ));

    _pulseController.dispose();

    _listeningController.dispose();      parent: _pulseController,    

    _typingController.dispose();

    _textController.dispose();      curve: Curves.easeInOut,    _scaleAnimation = Tween<double>(

    _scrollController.dispose();

    super.dispose();    ));      begin: 1.0,

  }

          end: 1.1,

  void _toggleListening() {

    setState(() {    _scaleAnimation = Tween<double>(    ).animate(CurvedAnimation(

      _isListening = !_isListening;

    });      begin: 1.0,      parent: _listeningController,

    

    if (_isListening) {      end: 1.1,      curve: Curves.elasticOut,

      _listeningController.forward();

    } else {    ).animate(CurvedAnimation(    ));

      _listeningController.reverse();

    }      parent: _listeningController,  }

  }

      curve: Curves.elasticOut,

  void _toggleTheme() {

    setState(() {    ));  @override

      _isDarkMode = !_isDarkMode;

    });  }  void dispose() {

  }

    _pulseController.dispose();

  void _sendMessage(String message) {

    if (message.trim().isEmpty) return;  @override    _listeningController.dispose();

    

    setState(() {  void dispose() {    _textController.dispose();

      _messages.add({

        'text': message,    _pulseController.dispose();    super.dispose();

        'isUser': true,

        'timestamp': DateTime.now(),    _listeningController.dispose();  }

      });

      _isTyping = true;    _textController.dispose();

    });

        super.dispose();  void _toggleListening() {

    _textController.clear();

    _scrollToBottom();  }    setState(() {

    

    // Simulate AI thinking and response      _isListening = !_isListening;

    Future.delayed(const Duration(milliseconds: 1500), () {

      setState(() {  void _toggleListening() {    });

        _isTyping = false;

        _messages.add({    setState(() {    

          'text': _generateAIResponse(message),

          'isUser': false,      _isListening = !_isListening;    if (_isListening) {

          'timestamp': DateTime.now(),

        });    });      _listeningController.forward();

      });

      _scrollToBottom();        } else {

    });

  }    if (_isListening) {      _listeningController.reverse();



  String _generateAIResponse(String userMessage) {      _listeningController.forward();    }

    final responses = {

      'weather': 'The weather today is sunny with a temperature of 24°C. Perfect for outdoor activities! ☀️',    } else {  }

      'reminder': 'I\'ve set a reminder for tomorrow. I\'ll make sure to notify you at the right time! ⏰',

      'joke': 'Why don\'t scientists trust atoms? Because they make up everything! 😄',      _listeningController.reverse();

      'music': 'Playing your favorite playlist now. Enjoy the music! 🎵',

      'news': 'Here are today\'s top headlines: Technology stocks are rising, and there\'s exciting news in AI development! 📰',    }  void _sendMessage(String message) {

      'help': 'I can help you with weather, reminders, jokes, music, news, and much more! What would you like to know?',

    };  }    if (message.trim().isEmpty) return;

    

    String lowerMessage = userMessage.toLowerCase();    

    for (String key in responses.keys) {

      if (lowerMessage.contains(key)) {  void _sendMessage(String message) {    setState(() {

        return responses[key]!;

      }    if (message.trim().isEmpty) return;      _messages.add({

    }

                'text': message,

    return 'That\'s interesting! I\'m still learning, but I\'d love to help you with that. Could you tell me more about what you need? 🤖';

  }    setState(() {        'isUser': true,



  void _scrollToBottom() {      _messages.add({        'timestamp': DateTime.now(),

    Future.delayed(const Duration(milliseconds: 100), () {

      if (_scrollController.hasClients) {        'text': message,      });

        _scrollController.animateTo(

          _scrollController.position.maxScrollExtent,        'isUser': true,      

          duration: const Duration(milliseconds: 300),

          curve: Curves.easeOut,        'timestamp': DateTime.now(),      // Simulate AI response

        );

      }      });      Future.delayed(const Duration(milliseconds: 1000), () {

    });

  }              setState(() {



  @override      // Simulate AI response          _messages.add({

  Widget build(BuildContext context) {

    return Scaffold(      Future.delayed(const Duration(milliseconds: 1000), () {            'text': 'I received your message: "$message". How can I help you further?',

      backgroundColor: _isDarkMode ? const Color(0xFF1A1A1A) : ColorPalette.whiteColor,

      appBar: _buildAppBar(),        setState(() {            'isUser': false,

      body: Column(

        children: [          _messages.add({            'timestamp': DateTime.now(),

          // AI Avatar Section

          _buildAvatarSection(),            'text': 'I received your message: "$message". How can I help you further?',          });

          

          // Quick Actions or Chat Messages            'isUser': false,        });

          Expanded(

            child: _messages.isEmpty ? _buildQuickActions() : _buildChatSection(),            'timestamp': DateTime.now(),      });

          ),

                    });    });

          // Input Section

          _buildInputSection(),        });    

        ],

      ),      });    _textController.clear();

    );

  }    });  }



  PreferredSizeWidget _buildAppBar() {    

    return AppBar(

      backgroundColor: _isDarkMode ? const Color(0xFF2A2A2A) : ColorPalette.whiteColor,    _textController.clear();  @override

      elevation: 0,

      title: Text(  }  Widget build(BuildContext context) {package:flutter/material.dart';

        'AI Assistant',

        style: TextStyle(import 'package:voice_assistent/color_palete.dart';

          color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,

          fontWeight: FontWeight.bold,  @override

          fontSize: 20,

        ),  Widget build(BuildContext context) {class HomeScreen extends StatefulWidget {

      ),

      leading: Icon(    return Scaffold(  const HomeScreen({super.key});

        Icons.menu,

        color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,      appBar: AppBar(

      ),

      actions: [        title: const Text(  @override

        IconButton(

          onPressed: _toggleTheme,          'AI Assistant',  Widget build(BuildContext context) {

          icon: Icon(

            _isDarkMode ? Icons.light_mode : Icons.dark_mode,          style: TextStyle(    return Scaffold(

            color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,

          ),            color: ColorPalette.mainFontColor,      appBar: AppBar(

        ),

        IconButton(            fontWeight: FontWeight.bold,        title: const Text(

          onPressed: () {

            // Settings action          ),          'AI Assistant',

          },

          icon: Icon(        ),          style: TextStyle(

            Icons.settings,

            color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,        leading: const Icon(            color: ColorPalette.mainFontColor,

          ),

        ),          Icons.menu,            fontWeight: FontWeight.bold,

      ],

      centerTitle: true,          color: ColorPalette.mainFontColor,          ),

    );

  }        ),        ),



  Widget _buildAvatarSection() {        centerTitle: true,        leading: const Icon(

    return Container(

      height: 200,        elevation: 0,          Icons.menu,

      width: double.infinity,

      decoration: BoxDecoration(      ),          color: ColorPalette.mainFontColor,

        gradient: LinearGradient(

          begin: Alignment.topCenter,      body: Column(        ),

          end: Alignment.bottomCenter,

          colors: _isDarkMode        children: [        centerTitle: true,

              ? [

                  const Color(0xFF2A2A2A),          // AI Avatar Section        elevation: 0,

                  const Color(0xFF1A1A1A),

                ]          Container(      ),

              : [

                  ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),            height: 200,      body: Column(

                  ColorPalette.whiteColor,

                ],            width: double.infinity,        children: [

        ),

      ),            decoration: BoxDecoration(          // AI Avatar Section

      child: Center(

        child: AnimatedBuilder(              gradient: LinearGradient(          Container(

          animation: _pulseAnimation,

          builder: (context, child) {                begin: Alignment.topCenter,            height: 200,

            return Transform.scale(

              scale: _pulseAnimation.value,                end: Alignment.bottomCenter,            width: double.infinity,

              child: AnimatedBuilder(

                animation: _scaleAnimation,                colors: [            decoration: BoxDecoration(

                builder: (context, child) {

                  return Transform.scale(                  ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),              gradient: LinearGradient(

                    scale: _scaleAnimation.value,

                    child: Stack(                  ColorPalette.whiteColor,                begin: Alignment.topCenter,

                      alignment: Alignment.center,

                      children: [                ],                end: Alignment.bottomCenter,

                        // Outer glow effect

                        Container(              ),                colors: [

                          height: 140,

                          width: 140,            ),                  ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),

                          decoration: BoxDecoration(

                            shape: BoxShape.circle,            child: Center(                  ColorPalette.whiteColor,

                            boxShadow: [

                              BoxShadow(              child: AnimatedBuilder(                ],

                                color: (_isListening 

                                    ? ColorPalette.thirdSuggestionBoxColor                 animation: _pulseAnimation,              ),

                                    : ColorPalette.assistentCircleColor).withOpacity(0.4),

                                blurRadius: 30,                builder: (context, child) {            ),

                                spreadRadius: 10,

                              ),                  return Transform.scale(            child: Center(

                            ],

                          ),                    scale: _pulseAnimation.value,              child: AnimatedBuilder(

                        ),

                        // Main avatar                    child: AnimatedBuilder(                animation: _pulseAnimation,

                        Container(

                          height: 120,                      animation: _scaleAnimation,                builder: (context, child) {

                          width: 120,

                          decoration: BoxDecoration(                      builder: (context, child) {                  return Transform.scale(

                            gradient: LinearGradient(

                              colors: _isListening                        return Transform.scale(                    scale: _pulseAnimation.value,

                                  ? [

                                      ColorPalette.thirdSuggestionBoxColor,                          scale: _scaleAnimation.value,                    child: AnimatedBuilder(

                                      ColorPalette.secondSuggestionBoxColor,

                                    ]                          child: Container(                      animation: _scaleAnimation,

                                  : [

                                      ColorPalette.assistentCircleColor,                            height: 120,                      builder: (context, child) {

                                      ColorPalette.firstSuggestionBoxColor,

                                    ],                            width: 120,                        return Transform.scale(

                            ),

                            shape: BoxShape.circle,                            decoration: BoxDecoration(                          scale: _scaleAnimation.value,

                          ),

                          child: Icon(                              gradient: LinearGradient(                          child: Container(

                            _isListening ? Icons.mic : Icons.smart_toy,

                            size: 50,                                colors: _isListening                            height: 120,

                            color: ColorPalette.mainFontColor,

                          ),                                    ? [                            width: 120,

                        ),

                        // Wave animation when listening                                        ColorPalette.thirdSuggestionBoxColor,                            decoration: BoxDecoration(

                        if (_isListening) _buildWaveAnimation(),

                      ],                                        ColorPalette.secondSuggestionBoxColor,                              gradient: LinearGradient(

                    ),

                  );                                      ]                                colors: _isListening

                },

              ),                                    : [                                    ? [

            );

          },                                        ColorPalette.assistentCircleColor,                                        ColorPalette.thirdSuggestionBoxColor,

        ),

      ),                                        ColorPalette.firstSuggestionBoxColor,                                        ColorPalette.secondSuggestionBoxColor,

    );

  }                                      ],                                      ]



  Widget _buildWaveAnimation() {                              ),                                    : [

    return AnimatedBuilder(

      animation: _waveAnimation,                              shape: BoxShape.circle,                                        ColorPalette.assistentCircleColor,

      builder: (context, child) {

        return Container(                              boxShadow: [                                        ColorPalette.firstSuggestionBoxColor,

          height: 160,

          width: 160,                                BoxShadow(                                      ],

          decoration: BoxDecoration(

            shape: BoxShape.circle,                                  color: ColorPalette.assistentCircleColor.withOpacity(0.3),                              ),

            border: Border.all(

              color: ColorPalette.thirdSuggestionBoxColor.withOpacity(                                  blurRadius: 20,                              shape: BoxShape.circle,

                (1 - _waveAnimation.value) * 0.5,

              ),                                  spreadRadius: 5,                              boxShadow: [

              width: 2,

            ),                                ),                                BoxShadow(

          ),

        );                              ],                                  color: ColorPalette.assistentCircleColor.withOpacity(0.3),

      },

    );                            ),                                  blurRadius: 20,

  }

                            child: Icon(                                  spreadRadius: 5,

  Widget _buildQuickActions() {

    final actions = [                              _isListening ? Icons.mic : Icons.mic_none,                                ),

      {

        'title': 'Ask about Weather',                              size: 50,                              ],

        'subtitle': 'Get current weather info',

        'icon': Icons.wb_sunny,                              color: ColorPalette.mainFontColor,                            ),

        'color': ColorPalette.firstSuggestionBoxColor,

        'message': 'What\'s the weather like today?',                            ),                            child: Icon(

        'gradient': [ColorPalette.firstSuggestionBoxColor, const Color(0xFFB3E5FC)],

      },                          ),                              _isListening ? Icons.mic : Icons.mic_none,

      {

        'title': 'Set Reminder',                        );                              size: 50,

        'subtitle': 'Create a new reminder',

        'icon': Icons.alarm,                      },                              color: ColorPalette.mainFontColor,

        'color': ColorPalette.secondSuggestionBoxColor,

        'message': 'Set a reminder for tomorrow',                    ),                            ),

        'gradient': [ColorPalette.secondSuggestionBoxColor, const Color(0xFF81C784)],

      },                  );                          ),

      {

        'title': 'Tell me a Joke',                },                        );

        'subtitle': 'Brighten your day',

        'icon': Icons.sentiment_very_satisfied,              ),                      },

        'color': ColorPalette.thirdSuggestionBoxColor,

        'message': 'Tell me a funny joke',            ),                    ),

        'gradient': [ColorPalette.thirdSuggestionBoxColor, const Color(0xFFFFB74D)],

      },          ),                  );

      {

        'title': 'Play Music',                          },

        'subtitle': 'Start your playlist',

        'icon': Icons.music_note,          // Quick Actions              ),

        'color': const Color(0xFFE1BEE7),

        'message': 'Play my favorite music',          if (_messages.isEmpty) ..._buildQuickActions(),            ),

        'gradient': [const Color(0xFFE1BEE7), const Color(0xFFCE93D8)],

      },                    ),

      {

        'title': 'Get News',          // Chat Messages          

        'subtitle': 'Latest headlines',

        'icon': Icons.newspaper,          if (_messages.isNotEmpty)          // Quick Actions

        'color': const Color(0xFFFFCDD2),

        'message': 'Show me today\'s news',            Expanded(          if (_messages.isEmpty) ..._buildQuickActions(),

        'gradient': [const Color(0xFFFFCDD2), const Color(0xFFEF9A9A)],

      },              child: ListView.builder(          

      {

        'title': 'Help & Support',                padding: const EdgeInsets.all(16),          // Chat Messages

        'subtitle': 'Learn what I can do',

        'icon': Icons.help_outline,                itemCount: _messages.length,          if (_messages.isNotEmpty)

        'color': const Color(0xFFDCEDC8),

        'message': 'What can you help me with?',                itemBuilder: (context, index) {            Expanded(

        'gradient': [const Color(0xFFDCEDC8), const Color(0xFFC8E6C9)],

      },                  final message = _messages[index];              child: ListView.builder(

    ];

                  return _buildMessageBubble(                padding: const EdgeInsets.all(16),

    return Column(

      children: [                    message['text'],                itemCount: _messages.length,

        Padding(

          padding: const EdgeInsets.all(16),                    message['isUser'],                itemBuilder: (context, index) {

          child: Text(

            'How can I help you today?',                  );                  final message = _messages[index];

            style: TextStyle(

              fontSize: 24,                },                  return _buildMessageBubble(

              fontWeight: FontWeight.bold,

              color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,              ),                    message['text'],

            ),

            textAlign: TextAlign.center,            ),                    message['isUser'],

          ),

        ),                            );

        Expanded(

          child: GridView.builder(          // Input Section                },

            padding: const EdgeInsets.symmetric(horizontal: 16),

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(          _buildInputSection(),              ),

              crossAxisCount: 2,

              crossAxisSpacing: 12,        ],            ),

              mainAxisSpacing: 12,

              childAspectRatio: 1.2,      ),          

            ),

            itemCount: actions.length,    );          // Input Section

            itemBuilder: (context, index) {

              final action = actions[index];  }          _buildInputSection(),

              return Container(

                decoration: BoxDecoration(        ],

                  gradient: LinearGradient(

                    colors: _isDarkMode  List<Widget> _buildQuickActions() {      ),

                        ? [const Color(0xFF3A3A3A), const Color(0xFF2A2A2A)]

                        : action['gradient'] as List<Color>,    final actions = [    );

                    begin: Alignment.topLeft,

                    end: Alignment.bottomRight,      {  }

                  ),

                  borderRadius: BorderRadius.circular(20),        'title': 'Ask about Weather',

                  boxShadow: [

                    BoxShadow(        'subtitle': 'Get current weather info',  List<Widget> _buildQuickActions() {

                      color: (action['color'] as Color).withOpacity(0.3),

                      blurRadius: 8,        'icon': Icons.wb_sunny,    final actions = [

                      offset: const Offset(0, 4),

                    ),        'color': ColorPalette.firstSuggestionBoxColor,      {

                  ],

                ),        'message': 'What\'s the weather like today?'        'title': 'Ask about Weather',

                child: Material(

                  color: Colors.transparent,      },        'subtitle': 'Get current weather info',

                  child: InkWell(

                    borderRadius: BorderRadius.circular(20),      {        'icon': Icons.wb_sunny,

                    onTap: () => _sendMessage(action['message'] as String),

                    child: Padding(        'title': 'Set Reminder',        'color': ColorPalette.firstSuggestionBoxColor,

                      padding: const EdgeInsets.all(16),

                      child: Column(        'subtitle': 'Create a new reminder',        'message': 'What\'s the weather like today?'

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [        'icon': Icons.alarm,      },

                          Container(

                            padding: const EdgeInsets.all(12),        'color': ColorPalette.secondSuggestionBoxColor,      {

                            decoration: BoxDecoration(

                              color: ColorPalette.whiteColor.withOpacity(0.9),        'message': 'Set a reminder for tomorrow'        'title': 'Set Reminder',

                              borderRadius: BorderRadius.circular(12),

                            ),      },        'subtitle': 'Create a new reminder',

                            child: Icon(

                              action['icon'] as IconData,      {        'icon': Icons.alarm,

                              color: ColorPalette.mainFontColor,

                              size: 28,        'title': 'Tell me a Joke',        'color': ColorPalette.secondSuggestionBoxColor,

                            ),

                          ),        'subtitle': 'Brighten your day',        'message': 'Set a reminder for tomorrow'

                          const SizedBox(height: 12),

                          Text(        'icon': Icons.sentiment_very_satisfied,      },

                            action['title'] as String,

                            style: TextStyle(        'color': ColorPalette.thirdSuggestionBoxColor,      {

                              fontSize: 14,

                              fontWeight: FontWeight.bold,        'message': 'Tell me a funny joke'        'title': 'Tell me a Joke',

                              color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,

                            ),      },        'subtitle': 'Brighten your day',

                            textAlign: TextAlign.center,

                          ),    ];        'icon': Icons.sentiment_very_satisfied,

                          const SizedBox(height: 4),

                          Text(        'color': ColorPalette.thirdSuggestionBoxColor,

                            action['subtitle'] as String,

                            style: TextStyle(    return [        'message': 'Tell me a funny joke'

                              fontSize: 11,

                              color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.7),      const Padding(      },

                            ),

                            textAlign: TextAlign.center,        padding: EdgeInsets.all(16),    ];

                          ),

                        ],        child: Text(

                      ),

                    ),          'How can I help you today?',    return [

                  ),

                ),          style: TextStyle(      const Padding(

              );

            },            fontSize: 24,        padding: EdgeInsets.all(16),

          ),

        ),            fontWeight: FontWeight.bold,        child: Text(

      ],

    );            color: ColorPalette.mainFontColor,          'How can I help you today?',

  }

          ),          style: TextStyle(

  Widget _buildChatSection() {

    return Column(          textAlign: TextAlign.center,            fontSize: 24,

      children: [

        Expanded(        ),            fontWeight: FontWeight.bold,

          child: ListView.builder(

            controller: _scrollController,      ),            color: ColorPalette.mainFontColor,

            padding: const EdgeInsets.all(16),

            itemCount: _messages.length + (_isTyping ? 1 : 0),      Expanded(          ),

            itemBuilder: (context, index) {

              if (index == _messages.length && _isTyping) {        child: ListView.builder(          textAlign: TextAlign.center,

                return _buildTypingIndicator();

              }          padding: const EdgeInsets.symmetric(horizontal: 16),        ),

              final message = _messages[index];

              return _buildMessageBubble(          itemCount: actions.length,      ),

                message['text'],

                message['isUser'],          itemBuilder: (context, index) {      Expanded(

                message['timestamp'],

              );            final action = actions[index];        child: ListView.builder(

            },

          ),            return Container(          padding: const EdgeInsets.symmetric(horizontal: 16),

        ),

        _buildQuickReplies(),              margin: const EdgeInsets.only(bottom: 12),          itemCount: actions.length,

      ],

    );              child: Material(          itemBuilder: (context, index) {

  }

                color: action['color'] as Color,            final action = actions[index];

  Widget _buildMessageBubble(String message, bool isUser, DateTime timestamp) {

    return Container(                borderRadius: BorderRadius.circular(16),            return Container(

      margin: const EdgeInsets.only(bottom: 16),

      child: Row(                child: InkWell(              margin: const EdgeInsets.only(bottom: 12),

        mainAxisAlignment:

            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,                  borderRadius: BorderRadius.circular(16),              child: Material(

        crossAxisAlignment: CrossAxisAlignment.end,

        children: [                  onTap: () => _sendMessage(action['message'] as String),                color: action['color'] as Color,

          if (!isUser) _buildAvatar(false),

          const SizedBox(width: 8),                  child: Padding(                borderRadius: BorderRadius.circular(16),

          Flexible(

            child: Column(                    padding: const EdgeInsets.all(16),                child: InkWell(

              crossAxisAlignment:

                  isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,                    child: Row(                  borderRadius: BorderRadius.circular(16),

              children: [

                Container(                      children: [                  onTap: () => _sendMessage(action['message'] as String),

                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

                  decoration: BoxDecoration(                        Container(                  child: Padding(

                    gradient: isUser

                        ? LinearGradient(                          padding: const EdgeInsets.all(12),                    padding: const EdgeInsets.all(16),

                            colors: [

                              ColorPalette.mainFontColor,                          decoration: BoxDecoration(                    child: Row(

                              ColorPalette.mainFontColor.withOpacity(0.8),

                            ],                            color: ColorPalette.whiteColor.withOpacity(0.8),                      children: [

                          )

                        : LinearGradient(                            borderRadius: BorderRadius.circular(12),                        Container(

                            colors: _isDarkMode

                                ? [const Color(0xFF3A3A3A), const Color(0xFF4A4A4A)]                          ),                          padding: const EdgeInsets.all(12),

                                : [ColorPalette.firstSuggestionBoxColor, ColorPalette.firstSuggestionBoxColor.withOpacity(0.7)],

                          ),                          child: Icon(                          decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20),

                    boxShadow: [                            action['icon'] as IconData,                            color: ColorPalette.whiteColor.withOpacity(0.8),

                      BoxShadow(

                        color: Colors.black.withOpacity(0.1),                            color: ColorPalette.mainFontColor,                            borderRadius: BorderRadius.circular(12),

                        blurRadius: 5,

                        offset: const Offset(0, 2),                            size: 24,                          ),

                      ),

                    ],                          ),                          child: Icon(

                  ),

                  child: Text(                        ),                            action['icon'] as IconData,

                    message,

                    style: TextStyle(                        const SizedBox(width: 16),                            color: ColorPalette.mainFontColor,

                      color: isUser

                          ? ColorPalette.whiteColor                        Expanded(                            size: 24,

                          : (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor),

                      fontSize: 16,                          child: Column(                          ),

                    ),

                  ),                            crossAxisAlignment: CrossAxisAlignment.start,                        ),

                ),

                const SizedBox(height: 4),                            children: [                        const SizedBox(width: 16),

                Text(

                  '${timestamp.hour}:${timestamp.minute.toString().padLeft(2, '0')}',                              Text(                        Expanded(

                  style: TextStyle(

                    fontSize: 12,                                action['title'] as String,                          child: Column(

                    color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.5),

                  ),                                style: const TextStyle(                            crossAxisAlignment: CrossAxisAlignment.start,

                ),

              ],                                  fontSize: 16,                            children: [

            ),

          ),                                  fontWeight: FontWeight.bold,                              Text(

          const SizedBox(width: 8),

          if (isUser) _buildAvatar(true),                                  color: ColorPalette.mainFontColor,                                action['title'] as String,

        ],

      ),                                ),                                style: const TextStyle(

    );

  }                              ),                                  fontSize: 16,



  Widget _buildAvatar(bool isUser) {                              Text(                                  fontWeight: FontWeight.bold,

    return Container(

      padding: const EdgeInsets.all(8),                                action['subtitle'] as String,                                  color: ColorPalette.mainFontColor,

      decoration: BoxDecoration(

        color: isUser                                 style: TextStyle(                                ),

            ? ColorPalette.mainFontColor 

            : (_isDarkMode ? const Color(0xFF3A3A3A) : ColorPalette.assistentCircleColor),                                  fontSize: 14,                              ),

        borderRadius: BorderRadius.circular(20),

      ),                                  color: ColorPalette.mainFontColor.withOpacity(0.7),                              Text(

      child: Icon(

        isUser ? Icons.person : Icons.smart_toy,                                ),                                action['subtitle'] as String,

        color: isUser 

            ? ColorPalette.whiteColor                               ),                                style: TextStyle(

            : (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor),

        size: 20,                            ],                                  fontSize: 14,

      ),

    );                          ),                                  color: ColorPalette.mainFontColor.withOpacity(0.7),

  }

                        ),                                ),

  Widget _buildTypingIndicator() {

    return Container(                        Icon(                              ),

      margin: const EdgeInsets.only(bottom: 16),

      child: Row(                          Icons.arrow_forward_ios,                            ],

        children: [

          _buildAvatar(false),                          color: ColorPalette.mainFontColor.withOpacity(0.5),                          ),

          const SizedBox(width: 8),

          Container(                          size: 16,                        ),

            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(                        ),                        Icon(

              color: _isDarkMode ? const Color(0xFF3A3A3A) : ColorPalette.firstSuggestionBoxColor,

              borderRadius: BorderRadius.circular(20),                      ],                          Icons.arrow_forward_ios,

            ),

            child: Row(                    ),                          color: ColorPalette.mainFontColor.withOpacity(0.5),

              mainAxisSize: MainAxisSize.min,

              children: [                  ),                          size: 16,

                _buildDot(0),

                const SizedBox(width: 4),                ),                        ),

                _buildDot(1),

                const SizedBox(width: 4),              ),                      ],

                _buildDot(2),

              ],            );                    ),

            ),

          ),          },                  ),

        ],

      ),        ),                ),

    );

  }      ),              ),



  Widget _buildDot(int index) {    ];            );

    return AnimatedBuilder(

      animation: _typingController,  }          },

      builder: (context, child) {

        double offset = (index * 0.2) % 1.0;        ),

        double animValue = (_typingController.value + offset) % 1.0;

        return Transform.translate(  Widget _buildMessageBubble(String message, bool isUser) {      ),

          offset: Offset(0, -10 * (1 - (2 * animValue - 1).abs())),

          child: Container(    return Container(    ];

            width: 8,

            height: 8,      margin: const EdgeInsets.only(bottom: 12),  }

            decoration: BoxDecoration(

              color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,      child: Row(

              shape: BoxShape.circle,

            ),        mainAxisAlignment:  Widget _buildMessageBubble(String message, bool isUser) {

          ),

        );            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,    return Container(

      },

    );        children: [      margin: const EdgeInsets.only(bottom: 12),

  }

          if (!isUser)      child: Row(

  Widget _buildQuickReplies() {

    if (_messages.isEmpty) return const SizedBox.shrink();            Container(        mainAxisAlignment:

    

    final quickReplies = ['Thanks!', 'Tell me more', 'That\'s helpful', 'What else?'];              margin: const EdgeInsets.only(right: 8),            isUser ? MainAxisAlignment.end : MainAxisAlignment.start,

    

    return Container(              padding: const EdgeInsets.all(8),        children: [

      height: 50,

      margin: const EdgeInsets.symmetric(horizontal: 16),              decoration: BoxDecoration(          if (!isUser)

      child: ListView.builder(

        scrollDirection: Axis.horizontal,                color: ColorPalette.assistentCircleColor,            Container(

        itemCount: quickReplies.length,

        itemBuilder: (context, index) {                borderRadius: BorderRadius.circular(20),              margin: const EdgeInsets.only(right: 8),

          return Container(

            margin: const EdgeInsets.only(right: 8),              ),              padding: const EdgeInsets.all(8),

            child: Material(

              color: _isDarkMode ? const Color(0xFF3A3A3A) : ColorPalette.secondSuggestionBoxColor.withOpacity(0.3),              child: const Icon(              decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(25),

              child: InkWell(                Icons.smart_toy,                color: ColorPalette.assistentCircleColor,

                borderRadius: BorderRadius.circular(25),

                onTap: () => _sendMessage(quickReplies[index]),                color: ColorPalette.mainFontColor,                borderRadius: BorderRadius.circular(20),

                child: Padding(

                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),                size: 20,              ),

                  child: Text(

                    quickReplies[index],              ),              child: const Icon(

                    style: TextStyle(

                      color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,            ),                Icons.smart_toy,

                      fontSize: 14,

                    ),          Flexible(                color: ColorPalette.mainFontColor,

                  ),

                ),            child: Container(                size: 20,

              ),

            ),              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),              ),

          );

        },              decoration: BoxDecoration(            ),

      ),

    );                color: isUser          Flexible(

  }

                    ? ColorPalette.mainFontColor            child: Container(

  Widget _buildInputSection() {

    return Container(                    : ColorPalette.firstSuggestionBoxColor,              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(                borderRadius: BorderRadius.circular(20),              decoration: BoxDecoration(

        color: _isDarkMode ? const Color(0xFF2A2A2A) : ColorPalette.whiteColor,

        border: Border(              ),                color: isUser

          top: BorderSide(

            color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.borderColor).withOpacity(0.2),              child: Text(                    ? ColorPalette.mainFontColor

            width: 1,

          ),                message,                    : ColorPalette.firstSuggestionBoxColor,

        ),

        boxShadow: [                style: TextStyle(                borderRadius: BorderRadius.circular(20),

          BoxShadow(

            color: Colors.black.withOpacity(0.05),                  color: isUser              ),

            blurRadius: 10,

            offset: const Offset(0, -2),                      ? ColorPalette.whiteColor              child: Text(

          ),

        ],                      : ColorPalette.mainFontColor,                message,

      ),

      child: Row(                  fontSize: 16,                style: TextStyle(

        children: [

          Expanded(                ),                  color: isUser

            child: Container(

              decoration: BoxDecoration(              ),                      ? ColorPalette.whiteColor

                color: _isDarkMode 

                    ? const Color(0xFF3A3A3A)             ),                      : ColorPalette.mainFontColor,

                    : ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),

                borderRadius: BorderRadius.circular(25),          ),                  fontSize: 16,

                border: Border.all(

                  color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.borderColor).withOpacity(0.3),          if (isUser)                ),

                ),

              ),            Container(              ),

              child: TextField(

                controller: _textController,              margin: const EdgeInsets.only(left: 8),            ),

                style: TextStyle(

                  color: _isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor,              padding: const EdgeInsets.all(8),          ),

                ),

                decoration: InputDecoration(              decoration: BoxDecoration(          if (isUser)

                  hintText: 'Type your message...',

                  hintStyle: TextStyle(                color: ColorPalette.mainFontColor,            Container(

                    color: (_isDarkMode ? ColorPalette.whiteColor : ColorPalette.mainFontColor).withOpacity(0.5),

                  ),                borderRadius: BorderRadius.circular(20),              margin: const EdgeInsets.only(left: 8),

                  border: InputBorder.none,

                  contentPadding: const EdgeInsets.symmetric(              ),              padding: const EdgeInsets.all(8),

                    horizontal: 20,

                    vertical: 12,              child: const Icon(              decoration: BoxDecoration(

                  ),

                ),                Icons.person,                color: ColorPalette.mainFontColor,

                onSubmitted: _sendMessage,

              ),                color: ColorPalette.whiteColor,                borderRadius: BorderRadius.circular(20),

            ),

          ),                size: 20,              ),

          const SizedBox(width: 12),

          _buildActionButton(              ),              child: const Icon(

            onTap: _toggleListening,

            gradient: _isListening            ),                Icons.person,

                ? [ColorPalette.thirdSuggestionBoxColor, ColorPalette.secondSuggestionBoxColor]

                : [ColorPalette.mainFontColor, ColorPalette.mainFontColor.withOpacity(0.8)],        ],                color: ColorPalette.whiteColor,

            icon: _isListening ? Icons.mic : Icons.mic_none,

          ),      ),                size: 20,

          const SizedBox(width: 8),

          _buildActionButton(    );              ),

            onTap: () => _sendMessage(_textController.text),

            gradient: [ColorPalette.mainFontColor, ColorPalette.mainFontColor.withOpacity(0.8)],  }            ),

            icon: Icons.send,

          ),        ],

        ],

      ),  Widget _buildInputSection() {      ),

    );

  }    return Container(    );



  Widget _buildActionButton({      padding: const EdgeInsets.all(16),  }

    required VoidCallback onTap,

    required List<Color> gradient,      decoration: BoxDecoration(

    required IconData icon,

  }) {        color: ColorPalette.whiteColor,  Widget _buildInputSection() {

    return GestureDetector(

      onTap: onTap,        border: Border(    return Container(

      child: Container(

        padding: const EdgeInsets.all(12),          top: BorderSide(      padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(

          gradient: LinearGradient(colors: gradient),            color: ColorPalette.borderColor.withOpacity(0.3),      decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(25),

          boxShadow: [            width: 1,        color: ColorPalette.whiteColor,

            BoxShadow(

              color: gradient.first.withOpacity(0.3),          ),        border: Border(

              blurRadius: 8,

              offset: const Offset(0, 2),        ),          top: BorderSide(

            ),

          ],      ),            color: ColorPalette.borderColor.withOpacity(0.3),

        ),

        child: Icon(      child: Row(            width: 1,

          icon,

          color: ColorPalette.whiteColor,        children: [          ),

          size: 24,

        ),          Expanded(        ),

      ),

    );            child: Container(      ),

  }

}              decoration: BoxDecoration(      child: Row(

                color: ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),        children: [

                borderRadius: BorderRadius.circular(25),          Expanded(

                border: Border.all(            child: Container(

                  color: ColorPalette.borderColor.withOpacity(0.3),              decoration: BoxDecoration(

                ),                color: ColorPalette.firstSuggestionBoxColor.withOpacity(0.3),

              ),                borderRadius: BorderRadius.circular(25),

              child: TextField(                border: Border.all(

                controller: _textController,                  color: ColorPalette.borderColor.withOpacity(0.3),

                decoration: const InputDecoration(                ),

                  hintText: 'Type your message...',              ),

                  hintStyle: TextStyle(color: ColorPalette.mainFontColor),              child: TextField(

                  border: InputBorder.none,                controller: _textController,

                  contentPadding: EdgeInsets.symmetric(                decoration: const InputDecoration(

                    horizontal: 20,                  hintText: 'Type your message...',

                    vertical: 12,                  hintStyle: TextStyle(color: ColorPalette.mainFontColor),

                  ),                  border: InputBorder.none,

                ),                  contentPadding: EdgeInsets.symmetric(

                onSubmitted: _sendMessage,                    horizontal: 20,

              ),                    vertical: 12,

            ),                  ),

          ),                ),

          const SizedBox(width: 12),                onSubmitted: _sendMessage,

          GestureDetector(              ),

            onTap: _toggleListening,            ),

            child: Container(          ),

              padding: const EdgeInsets.all(12),          const SizedBox(width: 12),

              decoration: BoxDecoration(          GestureDetector(

                gradient: LinearGradient(            onTap: _toggleListening,

                  colors: _isListening            child: Container(

                      ? [              padding: const EdgeInsets.all(12),

                          ColorPalette.thirdSuggestionBoxColor,              decoration: BoxDecoration(

                          ColorPalette.secondSuggestionBoxColor,                gradient: LinearGradient(

                        ]                  colors: _isListening

                      : [                      ? [

                          ColorPalette.mainFontColor,                          ColorPalette.thirdSuggestionBoxColor,

                          ColorPalette.mainFontColor.withOpacity(0.8),                          ColorPalette.secondSuggestionBoxColor,

                        ],                        ]

                ),                      : [

                borderRadius: BorderRadius.circular(25),                          ColorPalette.mainFontColor,

              ),                          ColorPalette.mainFontColor.withOpacity(0.8),

              child: Icon(                        ],

                _isListening ? Icons.mic : Icons.mic_none,                ),

                color: ColorPalette.whiteColor,                borderRadius: BorderRadius.circular(25),

                size: 24,              ),

              ),              child: Icon(

            ),                _isListening ? Icons.mic : Icons.mic_none,

          ),                color: ColorPalette.whiteColor,

          const SizedBox(width: 8),                size: 24,

          GestureDetector(              ),

            onTap: () => _sendMessage(_textController.text),            ),

            child: Container(          ),

              padding: const EdgeInsets.all(12),          const SizedBox(width: 8),

              decoration: BoxDecoration(          GestureDetector(

                color: ColorPalette.mainFontColor,            onTap: () => _sendMessage(_textController.text),

                borderRadius: BorderRadius.circular(25),            child: Container(

              ),              padding: const EdgeInsets.all(12),

              child: const Icon(              decoration: BoxDecoration(

                Icons.send,                color: ColorPalette.mainFontColor,

                color: ColorPalette.whiteColor,                borderRadius: BorderRadius.circular(25),

                size: 24,              ),

              ),              child: const Icon(

            ),                Icons.send,

          ),                color: ColorPalette.whiteColor,

        ],                size: 24,

      ),              ),

    );            ),

  }          ),

}        ],
      ),
    );
  }
}