class AudioState {
  final double inputGain;
  final double outputGain;
  final bool isRecording;

  const AudioState({
    this.inputGain = 0.0,
    this.outputGain = 0.0,
    this.isRecording = false,
  });

  AudioState copyWith({double? inputGain, double? outputGain, bool? isRecording}) {
    return AudioState(
      inputGain: inputGain ?? this.inputGain,
      outputGain: outputGain ?? this.outputGain,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}
