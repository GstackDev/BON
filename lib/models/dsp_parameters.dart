class DspParameters {
  final double inputGain;
  final double mix;
  final double pitch;
  final double formant;
  final double compressor;

  const DspParameters({
    this.inputGain = 0.0,
    this.mix = 0.5,
    this.pitch = 0.0,
    this.formant = 0.0,
    this.compressor = 0.5,
  });
}
