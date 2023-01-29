<h1>Amplitude Modulation</h1>

<img src="images/image1.png" alt="image1" width="200" height="200"/><img src="images/image2.png" alt="image2" width="200" height="200"/><img src="images/image3.png" alt="image3" width="200" height="200"/>

<h2>Modulation</h2>
Perform modulation by multiplying the signals using these carriers:

`Carrier1 = cos ( 2*pi*fc1*t1) where fc1 = 160,000 Hz`

`Carrier2 = cos ( 2*pi*fc2*t2) where fc2 = 320,000 Hz`

`Carrier3 = sin ( 2*pi*fc2*t3) where fc2 = 320,000 Hz`

<img src="images/image4.png" alt="image4" width="200" height="200"/><img src="images/image5.png" alt="image5" width="200" height="200"/><img src="images/image6.png" alt="image6" width="200" height="200"/>

<h2>Required signal</h2>

`s(t)=x1 cos(𝜔1*t) + x2 cos(𝜔2*t) + x3 sin(𝜔2*t)`

<img src="images/image7.png" alt="image7" width="200" height="200"/>

<h2>Demodulation</h2>
Perform <b>synchronous demodulation</b> to s(t) to restore the 3 signals.

<img src="images/image8.png" alt="image8" width="200" height="200"/><img src="images/image9.png" alt="image9" width="200" height="200"/><img src="images/image10.png" alt="image10" width="200" height="200"/>

Perform demodulation with <b>phase shift</b> 10, 30, 90 degrees.

`Carrier1 = cos ( 2*pi*fc1*t1 + (phase_shift_angle* pi) / 180 )`

`Carrier2 = cos ( 2*pi*fc2*t2 + (phase_shift_angle* pi) / 180 )`

`Carrier3 = sin ( 2*pi*fc2*t3 + (phase_shift_angle* pi) / 180 )`

In phase shift 10:
Signal 1: there is very little attenuation in it ( the sound is slightly lower).
Signal 2 & 3: there is very little interference between them, but the signal with the current
corresponding carrier is the one with the higher sound.

<img src="images/image13.png" alt="image13" width="200" height="200"/><img src="images/image14.png" alt="image14" width="200" height="200"/><img src="images/image15.png" alt="image15" width="200" height="200"/>

In phase shift 30:
Signal 1: there is more attenuation in it ( the sound is lower than the previous case).
Signal 2 & 3: there is more interference between them, and the signal with the current
corresponding carrier is still a little bit with higher sound.

<img src="images/image16.png" alt="image16" width="200" height="200"/><img src="images/image17.png" alt="image17" width="200" height="200"/><img src="images/image18.png" alt="image18" width="200" height="200"/>

In phase shift 90:
Signal 1: it is completely attenuated ( there is no sound).
Signal 2 & 3: there is complete interference between them, the signals are interchanged with
each other ( when we try to get signal 2, we get signal 3 and vice versa).

<img src="images/image19.png" alt="image19" width="200" height="200"/><img src="images/image20.png" alt="image20" width="200" height="200"/><img src="images/image21.png" alt="image21" width="200" height="200"/>

Perform demodulation with a local carrier frequency that is different by 2 Hz and 10 Hz from its carrier frequency (<b>frequency shift</b>).

`Carrier1 = cos ( 2*pi*(fc1+2)*t1 )`

`Carrier1 = cos ( 2*pi*(fc1+10)*t1 )`

Different by 2Hz:
There is little attenuation and distortion in the output signal.

Different by 10Hz:
There is more attenuation and distortion in the output signal than the previous case.

<img src="images/image11.png" alt="image11" width="200" height="200"/><img src="images/image12.png" alt="image12" width="200" height="200"/>
