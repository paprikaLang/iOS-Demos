## Panio-AudioKit

振荡子之于声音,就像像素之于图像.AKOscillator发出正弦波经过AudioKit处理传入耳麦,振荡子以同样的振幅和频率震荡,压缩空气成为声音.

### Theremin

特雷门琴,通过平滑改变(rampTime)振荡器的频率或振幅(AKPlaygroundLoop每 0.5 秒从 500Hz 到 100 Hz切换一次),发出独特的声音.

### Polyphony

当乐器演奏一个音符(频率固定),**音量**(振幅)是会变化的.修改ADSR(振幅的上升-下行-维持-松开)的值,尝试不同的**声音效果**(例如:钢琴和小提琴).

而一系列振荡器合并一起演奏同一音符,能模拟更加真实的乐器.声音的"**音色**"在于它产生的声谱,声谱就是一个单音符发出时所组成的频率范围.
```py
let frequencies = (1...5).map{$0 * 261.63}
let oscillators = frequencies.map{
   createAndStartOscillators(frequencies: $0)
}
let mixer = AKMiker()
oscillators.forEach { mixer.connect($0)}
```
以上就是中音C的加法合成.

#### Playground

加法合成后,为每个振荡器创建一个AKPropertySlider,在Playground的liveView中可视化地改变振荡器的频率,创作不同的**音质**,就像改变每个像素点周围的RGBA值得到不同画质一样.

```pyt
PlaygroundPage.current.liveView = PlaygroundView()
```
通过创建多个振荡器,每个振荡器发出不同的音符并用mixer播放出来,可以制造出 **复音**. 
用AKKeyboardView创建一个键盘,当音符的上行和另一个音符的下行混在一起就会发出美妙的 **和声**.
```pyt
keyboard.polyphonicMode = true//复音模式
```

### BitCrusher

声音如何收集取样?
对于一段流畅的光滑波形,只能在固定的时间间隔内记录其震动的状态.
**Bit depth** 和 **Sample rate**这两个属性在取样中直接影响到拟真度.AKBitCrusher可以模拟低位深低取样率的复古效果.

#### AureliusPan

在左右扬声器之间制造立体声延迟效果.
```pyt
let leftPan = AKPanner(player, pan: -1)
let rightPan = AKPanner(delay, pan: 1)
```


