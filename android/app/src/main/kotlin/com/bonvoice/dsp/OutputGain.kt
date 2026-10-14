package com.bonvoice.dsp

class OutputGain {
    fun apply(sample: Float, gain: Float): Float = sample * gain
}
