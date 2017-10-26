import AudioKit
import PlaygroundSupport

let oscillator = AKOscillator()

oscillator.frequency = 500
oscillator.amplitude = 0.5

AudioKit.output = oscillator
AudioKit.start()

oscillator.rampTime = 0.2
oscillator.frequency = 500
AKPlaygroundLoop(every: 0.5) {
    oscillator.frequency =
        oscillator.frequency == 500 ? 100 : 500
}

oscillator.start()

PlaygroundPage.current.needsIndefiniteExecution = true
