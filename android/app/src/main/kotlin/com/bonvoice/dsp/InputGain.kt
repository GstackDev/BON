package com.bonvoice.dsp

class InputGain {
    fun apply(sample: Float, gain: Float): Float = sample * gain
}
