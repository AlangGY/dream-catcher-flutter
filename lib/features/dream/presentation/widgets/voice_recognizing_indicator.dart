import 'package:flutter/material.dart';

class VoiceRecognizingIndicator extends StatelessWidget {
  const VoiceRecognizingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mic, color: Theme.of(context).primaryColor),
          const SizedBox(width: 8),
          Text(
            '음성을 인식하는 중...',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ],
      ),
    );
  }
}
