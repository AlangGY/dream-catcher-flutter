import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

class DreamChatMessage extends StatelessWidget {
  final String text;
  final bool isUserMessage;

  const DreamChatMessage({
    super.key,
    required this.text,
    required this.isUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isUserMessage) ...[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.psychology,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: CommonCard(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              backgroundColor:
                  isUserMessage ? const Color(0xFFE1E1F9) : Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Text(
                text,
                style: isUserMessage
                    ? AppTextStyles.bodyEmphasis(context)
                    : AppTextStyles.body,
              ),
            ),
          ),
          if (isUserMessage) ...[
            const SizedBox(width: 8),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
                size: 24,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
