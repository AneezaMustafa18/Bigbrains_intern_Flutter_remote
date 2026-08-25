import 'package:flutter/material.dart';
import 'package:bigbrains_day3/widgets/chat_tile.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final TextEditingController searchController = TextEditingController();

  String searchText = '';

  final List<Map<String, String>> chats = [
    {
      'name': 'Ali',
      'message': 'Hey! How are you?',
      'time': '10:30 AM',
      'image': 'assets/images/avatar_3_boy.jpg',
    },
    {
      'name': 'Sara',
      'message': 'See you tomorrow 😊',
      'time': '09:45 AM',
      'image': 'assets/images/avatar_1_girl.jpg',
    },
    {
      'name': 'Ahmed',
      'message': 'Did you complete the project?',
      'time': 'Yesterday',
      'image': 'assets/images/avatar_6_boy.jpg',
    },
    {
      'name': 'Ayesha',
      'message': 'That sounds great! 👍',
      'time': 'Yesterday',
      'image': 'assets/images/avatar_2_girl.jpg',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredChats = chats.where((chat) {
      return chat['name']!
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue.shade100,
        title: const Text(
          'Chats',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt_outlined),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),

      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),

          Container(
            color: Colors.white.withOpacity(0.88),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            searchText = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search Messenger',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    if (searchText.isNotEmpty)
                      IconButton(
                        onPressed: () {
                          searchController.clear();

                          setState(() {
                            searchText = '';
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                  ],
                ),
              ),

              // Favorites
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'Favorites',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 85,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  children: [
                    favoritePerson(
                      'Ali',
                      'assets/images/avatar_3_boy.jpg',
                    ),
                    favoritePerson(
                      'Sara',
                      'assets/images/avatar_1_girl.jpg',
                    ),
                    favoritePerson(
                      'Ahmed',
                      'assets/images/avatar_4_boy.jpg',
                    ),
                    favoritePerson(
                      'Ayesha',
                      'assets/images/avatar_2_girl.jpg',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 5),

              Expanded(
                child: filteredChats.isEmpty
                    ? const Center(
                  child: Text(
                    'No chats found',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                )
                    : ListView.builder(
                  itemCount: filteredChats.length,
                  itemBuilder: (context, index) {
                    return ChatTile(
                      name: filteredChats[index]['name']!,
                      message:
                      filteredChats[index]['message']!,
                      time: filteredChats[index]['time']!,
                      imagePath:
                      filteredChats[index]['image']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.edit),
      ),
    );
  }

  Widget favoritePerson(
      String name,
      String imagePath,
      ) {
    return Container(
      width: 70,
      margin: const EdgeInsets.only(
        right: 18,
      ),
      child: Column(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 5),

          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}