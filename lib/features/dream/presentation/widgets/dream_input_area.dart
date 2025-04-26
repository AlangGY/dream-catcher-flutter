import 'package:dream_catcher/shared/common-ui/common_ui.dart';
import 'package:flutter/material.dart';

class DreamInputArea extends StatelessWidget {
  final TextEditingController textController;
  final Function(String) onSubmitted;
  final bool isRecording;
  final VoidCallback onRecordPressed;
  final VoidCallback onRealTimeModePressed;

  const DreamInputArea({
    super.key,
    required this.textController,
    required this.onSubmitted,
    required this.isRecording,
    required this.onRecordPressed,
    required this.onRealTimeModePressed,
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
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 12.0,
        bottom: 36.0,
      ),
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
          IconButton(
            icon: Icon(
              isRecording ? Icons.mic : Icons.mic_none,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: onRecordPressed,
          ),
          FloatingActionButton(
            mini: true,
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: onRealTimeModePressed,
            child: Icon(
              Icons.graphic_eq,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          )
        ],
      ),
    );
  }
}
