package com.bonvoice.dsp

class WetDryMixer {
    fun mix(wet: Float, dry: Float, ratio: Float): Float = dry + (wet - dry) * ratio
}
