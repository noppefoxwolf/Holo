//
//  AnyCaptureDevice.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AVFoundation

internal protocol CaptureDeviceSimuratorDelegate: class {
  func didCaptured(sampleBuffer: CMSampleBuffer)
}

class CaptureDeviceSimurator {
  internal weak var _delegate: CaptureDeviceSimuratorDelegate? = nil
  internal func _push() {
    
  }
}

public class AnyCaptureDevice {
  enum Source {
    case simurator(CaptureDeviceSimurator)
    case device(AVFoundation.AVCaptureDevice)
  }
  internal let source: Source
  
  @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use AVCaptureDeviceDiscoverySession instead.")
  open class func devices() -> [AnyCaptureDevice] {
    return AVFoundation.AVCaptureDevice.devices().compactMap({ AnyCaptureDevice(captureDevice: $0) })
  }
  
  @available(iOS, introduced: 4.0, deprecated: 10.0, message: "Use AVCaptureDeviceDiscoverySession instead.")
  open class func devices(for mediaType: AVMediaType) -> [AnyCaptureDevice] {
    return AVFoundation.AVCaptureDevice.devices(for: mediaType).compactMap({ AnyCaptureDevice(captureDevice: $0) })
  }
  
  open class func `default`(for mediaType: AVMediaType) -> AnyCaptureDevice? {
    switch mediaType {
    case .video:
      switch HoloSettings.shared.mode {
      case .video(let url):
        return AnyCaptureDevice(captureDevice: MovieCaptureDeviceSimurator(url: url))
      case .image(let image):
        return AnyCaptureDevice(captureDevice: ImageCaptureDeviceSimurator(image: image))
      case .color(let color, let size):
        return AnyCaptureDevice(captureDevice: ColorImageCaptureDeviceSimurator(color: color, size: size))
      }
    default:
      return AnyCaptureDevice(captureDevice: AVFoundation.AVCaptureDevice.default(for: mediaType))
    }
  }
  
  @available(iOS 10.0, *)
  open class func `default`(_ deviceType: AVFoundation.AVCaptureDevice.DeviceType, for mediaType: AVMediaType?, position: AVFoundation.AVCaptureDevice.Position) -> AnyCaptureDevice? {
    guard let mediaType = mediaType else { return nil }
    return AnyCaptureDevice.default(for: mediaType)
  }
  
  public convenience init?(uniqueID deviceUniqueID: String) {
    self.init(captureDevice: AVFoundation.AVCaptureDevice.init(uniqueID: deviceUniqueID))
  }
  
  open var uniqueID: String {
    switch source {
    case .simurator:
      return ""
    case .device(let device):
      return device.uniqueID
    }
  }
  
  open var modelID: String {
    switch source {
    case .simurator:
      return ""
    case .device(let device):
      return device.modelID
    }
  }
  
  open var localizedName: String {
    switch source {
    case .simurator:
      return ""
    case .device(let device):
      return device.localizedName
    }
  }
  
  open func hasMediaType(_ mediaType: AVMediaType) -> Bool {
    switch source {
    case .simurator:
      return false
    case .device(let device):
      return device.hasMediaType(mediaType)
    }
  }
  
  open func lockForConfiguration() throws {
    switch source {
    case .simurator:
      break
    case .device(let device):
      try device.lockForConfiguration()
    }
  }
  
  open func unlockForConfiguration() {
    switch source {
    case .simurator:
      break
    case .device(let device):
      device.unlockForConfiguration()
    }
  }
  
  open func supportsSessionPreset(_ preset: AVFoundation.AVCaptureSession.Preset) -> Bool {
    switch source {
    case .simurator:
      return false
    case .device(let device):
      return device.supportsSessionPreset(preset)
    }
  }
  
  open var isConnected: Bool {
    switch source {
    case .simurator:
      return false
    case .device(let device):
      return device.isConnected
    }
  }
  
  @available(iOS 7.0, *)
  open var formats: [AVFoundation.AVCaptureDevice.Format] {
    switch source {
    case .simurator:
      return []
    case .device(let device):
      return device.formats
    }
  }
  
  @available(iOS 7.0, *)
  open var activeFormat: AVFoundation.AVCaptureDevice.Format {
    switch source {
    case .simurator:
      preconditionFailure()
    case .device(let device):
      return device.activeFormat
    }
  }
  
  @available(iOS 7.0, *)
  open var activeVideoMinFrameDuration: CMTime {
    get {
      switch source {
      case .simurator:
        return .zero
      case .device(let device):
        return device.activeVideoMinFrameDuration
      }
    }
    set {
      switch source {
      case .simurator:
        break
      case .device(let device):
        device.activeVideoMinFrameDuration = newValue
      }
    }
  }
  
  @available(iOS 7.0, *)
  open var activeVideoMaxFrameDuration: CMTime {
    get {
      switch source {
      case .simurator:
        return .zero
      case .device(let device):
        return device.activeVideoMaxFrameDuration
      }
    }
    set {
      switch source {
      case .simurator:
        break
      case .device(let device):
        device.activeVideoMaxFrameDuration = newValue
      }
    }
  }
  
  init(captureDevice: CaptureDeviceSimurator) {
    source = .simurator(captureDevice)
  }
  
  init?(captureDevice: AVFoundation.AVCaptureDevice?) {
    guard let captureDevice = captureDevice else { return nil }
    source = .device(captureDevice)
  }
}
