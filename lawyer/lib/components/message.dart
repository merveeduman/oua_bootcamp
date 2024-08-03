import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lawyer/utils/config.dart';


class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.text,
    required this.isFromUser,
  });

  final String text;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children:<Widget> [
        Flexible(
            child: Container(
              padding:  const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 15
              ),
              margin: const EdgeInsets.only(bottom: 8),
              constraints: const BoxConstraints(maxWidth: 520),

              decoration: BoxDecoration(
                color: isFromUser
                    ?Colors.grey.shade200
                    :Colors.green.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                children: [
                  MarkdownBody(data: text),

                ],
              ),
            ))
      ],
    );
  }
}
