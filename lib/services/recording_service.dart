class RecordingService {
  bool isRecording = false;

  Future<void> start() async {
    isRecording = true;
  }

  Future<void> stop() async {
    isRecording = false;
  }

  Future<void> toggle() async {
    if (isRecording) {
      await stop();
    } else {
      await start();
    }
  }
}
