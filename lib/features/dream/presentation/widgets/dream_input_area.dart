import 'package:dream_catcher/shared/common-ui/common-ui.dart';
import 'package:flutter/material.dart';

class DreamInputArea extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSubmitted;
  final bool isRecording;
  final VoidCallback onRecordPressed;

  const DreamInputArea({
    super.key,
    required this.textController,
    required this.onSubmitted,
    required this.isRecording,
    required this.onRecordPressed,
  });

  void _handleSubmit() {
    final text = textController.text.trim();
    if (text.isNotEmpty) {
      onSubmitted(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0F000000),
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: '메시지 입력...',
                hintStyle: AppTextStyles.caption,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: const Color(0xFFF2F2FF),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onEditingComplete: _handleSubmit,
              textInputAction: TextInputAction.send,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).primaryColor),
            onPressed: _handleSubmit,
          ),
          FloatingActionButton(
            mini: true,
            backgroundColor:
                isRecording ? Colors.red : Theme.of(context).primaryColor,
            elevation: 2,
            onPressed: onRecordPressed,
            child: Icon(
              isRecording ? Icons.mic : Icons.mic_none,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
