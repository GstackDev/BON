import 'package:flutter/material.dart';

class RecordButton extends StatelessWidget {
  final bool isRecording;
  final VoidCallback? onPressed;

  const RecordButton({
    this.isRecording = false,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      height: 96,
      child: FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: isRecording ? Colors.red.shade700 : Colors.redAccent,
        child: Icon(
          isRecording ? Icons.stop_rounded : Icons.fiber_manual_record,
          size: 36,
        ),
      ),
    );
  }
}
