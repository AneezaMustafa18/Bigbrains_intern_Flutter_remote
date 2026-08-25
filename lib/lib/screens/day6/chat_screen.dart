import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String imagePath;

  const ChatScreen({
    super.key,
    required this.name,
    required this.imagePath,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController messageController =
  TextEditingController();

  final List<String> messages = [
    'Hey! How are you?',
    'I am good! What about you?',
    'I am doing great 😊',
  ];

  void sendMessage() {
    if (messageController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      messages.add(messageController.text.trim());
      messageController.clear();
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,

        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(widget.imagePath),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Text(
                  'Online',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.videocam),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),

      // Chat Body
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          // Light Overlay
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.70),
            ),
          ),

          // Chat Content
          Column(
            children: [
              // Date
              const Padding(
                padding: EdgeInsets.all(12),
                child: Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              // Messages
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final bool isMe = index % 2 != 0;

                    return Align(
                      alignment: isMe
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        constraints: const BoxConstraints(
                          maxWidth: 280,
                        ),
                        decoration: BoxDecoration(
                          color: isMe
                              ? Colors.blue
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(18),
                            topRight: const Radius.circular(18),
                            bottomLeft: Radius.circular(
                              isMe ? 18 : 4,
                            ),
                            bottomRight: Radius.circular(
                              isMe ? 4 : 18,
                            ),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          messages[index],
                          style: TextStyle(
                            color: isMe
                                ? Colors.white
                                : Colors.black87,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Message Input
              Container(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  8,
                  10,
                  10,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.emoji_emotions_outlined,
                      ),
                    ),

                    Expanded(
                      child: TextField(
                        controller: messageController,
                        textInputAction: TextInputAction.send,
                        onSubmitted: (_) => sendMessage(),
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding:
                          const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    FloatingActionButton(
                      mini: true,
                      elevation: 0,
                      onPressed: sendMessage,
                      child: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}