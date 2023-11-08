import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final borderRadius;

  const ChatBubble({super.key, required this.message,required this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.blueGrey[700],
      ),
      child: Text(
        message,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
