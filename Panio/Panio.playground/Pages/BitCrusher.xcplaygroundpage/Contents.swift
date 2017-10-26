import PlaygroundSupport
import AudioKit

let file = try AKAudioFile(readFileName: "sound.wav", baseDir: .resources)
let player = try AKAudioPlayer(file: file)
player.looping = false

var bitcrusher = AKBitCrusher(player)
bitcrusher.bitDepth = 8
bitcrusher.sampleRate = 5000

AudioKit.output = bitcrusher
AudioKit.start()

player.play()

PlaygroundPage.current.needsIndefiniteExecution = true

