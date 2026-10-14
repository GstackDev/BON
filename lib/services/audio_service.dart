import '../models/audio_state.dart';

class AudioService {
  AudioState _state = const AudioState();

  AudioState get state => _state;
  bool get isEngineRunning => _state.inputGain > 0 || _state.outputGain > 0;

  void startEngine() {
    _state = _state.copyWith(
      inputGain: _state.inputGain <= 0 ? 0.5 : _state.inputGain,
      outputGain: _state.outputGain <= 0 ? 0.6 : _state.outputGain,
    );
  }

  void stopEngine() {
    _state = _state.copyWith(inputGain: 0.0, outputGain: 0.0);
  }

  void toggleEngine() {
    if (isEngineRunning) {
      stopEngine();
    } else {
      startEngine();
    }
  }

  void setInputGain(double value) {
    _state = _state.copyWith(inputGain: value.clamp(0.0, 1.0));
  }

  void setOutputGain(double value) {
    _state = _state.copyWith(outputGain: value.clamp(0.0, 1.0));
  }

  void setRecording(bool value) {
    _state = _state.copyWith(isRecording: value);
  }
}
