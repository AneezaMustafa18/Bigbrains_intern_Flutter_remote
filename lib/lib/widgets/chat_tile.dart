import 'package:bigbrains_day3/screens/day6/chat_screen.dart';
import 'package:flutter/material.dart';


class ChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String imagePath;

  const ChatTile({
    super.key,
    required this.name,
    required this.message,
    required this.time,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              name: name,
              imagePath: imagePath,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Row(
          children: [
            // Profile Image
            Stack(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(imagePath),
                ),

                // Online Indicator
                Positioned(
                  right: 1,
                  bottom: 1,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(width: 14),

            // Name + Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // Time + Arrow
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 7),

                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}