package com.bonvoice.dsp

class Limiter {
    fun limit(sample: Float, ceiling: Float): Float = sample.coerceIn(-ceiling, ceiling)
}
