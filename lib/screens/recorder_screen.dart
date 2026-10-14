import 'package:flutter/material.dart';

import '../services/recording_service.dart';
import '../widgets/record_button.dart';

class RecorderScreen extends StatefulWidget {
  const RecorderScreen({super.key});

  @override
  State<RecorderScreen> createState() => _RecorderScreenState();
}

class _RecorderScreenState extends State<RecorderScreen> {
  final RecordingService _recordingService = RecordingService();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Capture voice clips and review recordings.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 24),
          RecordButton(
            isRecording: _recordingService.isRecording,
            onPressed: () async {
              await _recordingService.toggle();
              if (!mounted) return;
              setState(() {});
            },
          ),
          const SizedBox(height: 20),
          Text(
            _recordingService.isRecording ? 'Recording in progress' : 'Ready to record',
            style: TextStyle(
              color: _recordingService.isRecording ? Colors.redAccent : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
