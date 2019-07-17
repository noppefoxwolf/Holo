![](https://github.com/noppefoxwolf/Holo/blob/master/.github/Logo.png)

## Usage 

It's easy to use.

Add these lines to your project code.

These works for replacing the implementation at the time of simulator execution.

```swift
#if targetEnvironment(simulator)
import Holo
typealias AVCaptureDevice = AnyCaptureDevice
typealias AVCaptureDeviceInput = AnyCaptureDeviceInput
typealias AVCaptureSession = AnyCaptureSessionContainer
typealias AVCaptureVideoDataOutput = AnyCaptureVideoDataOutput
typealias AVCaptureConnection = AnyCaptureConnection
typealias AVCaptureVideoDataOutputSampleBufferDelegate = AnyCaptureVideoDataOutputSampleBufferDelegate
typealias AVCaptureOutput = AnyCaptureOutput
#endif
```

You can decide dummy camera contents.

```swift
#if targetEnvironment(simulator)
HoloSettings.shared.mode = .video(Bundle.main.url(forResource: "video", withExtension: "mp4")!)
#endif
```

## Screenshots

**Before**

![](https://github.com/noppefoxwolf/Holo/blob/master/.github/1.gif)

**After**

![](https://github.com/noppefoxwolf/Holo/blob/master/.github/2.gif)

## Requirements

## Installation

Holo is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Holo'
```

## Author

noppefoxwolf, noppelabs@gmail.com

## License

Holo is available under the MIT license. See the LICENSE file for more info.

## Thanks

Example Video from [File Example](https://file-examples.com/index.php).
