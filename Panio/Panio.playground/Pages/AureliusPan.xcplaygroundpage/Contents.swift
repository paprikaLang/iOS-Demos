import PlaygroundSupport
import AudioKit

let file = try AKAudioFile(readFileName: "sound.wav", baseDir: .resources)
let player = try AKAudioPlayer(file: file)
player.looping = false

let delay = AKDelay(player)
delay.time = 0.1
delay.dryWetMix = 1

let leftPan = AKPanner(player, pan: -1)
let rightPan = AKPanner(delay, pan: 1)

let mix = AKMixer(leftPan, rightPan)
AudioKit.output = mix

AudioKit.output = mix
AudioKit.start()

player.play()

PlaygroundPage.current.needsIndefiniteExecution = true

