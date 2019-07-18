//
//  AnyCaptureConnection.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AVFoundation

class CaptureConnectionSimurator {
  
}

public class AnyCaptureConnection {
  enum Source {
    case simurator(CaptureConnectionSimurator)
    case connection(AVFoundation.AVCaptureConnection)
  }
  
  internal let source: Source
  
  init(source: Source) {
    self.source = source
  }
  
  @available(iOS 8.0, *)
  public init(inputPorts ports: [AnyCaptureInput.Port], output: AnyCaptureOutput) {
    switch output.source {
    case .simurator(let output):
      self.source = .simurator(CaptureConnectionSimurator())
    case .output(let output):
      self.source = .connection(AVCaptureConnection(inputPorts: ports, output: output))
    }
  }
  
  @available(iOS 8.0, *)
  public init(inputPort port: AnyCaptureInput.Port, videoPreviewLayer layer: AVCaptureVideoPreviewLayer) {
    self.source = .connection(AVCaptureConnection(inputPort: port, videoPreviewLayer: layer))
  }
  
  open var inputPorts: [AnyCaptureInput.Port] {
    switch source {
    case .simurator(let connection):
      return []
    case .connection(let connection):
      return connection.inputPorts
    }
  }
  
  open var output: AVCaptureOutput? {
    switch source {
    case .simurator(let connection):
      return nil
    case .connection(let connection):
      return connection.output
    }
  }
  
  @available(iOS 6.0, *)
  open var videoPreviewLayer: AVCaptureVideoPreviewLayer? {
    switch source {
    case .simurator(let connection):
      return nil
    case .connection(let connection):
      return connection.videoPreviewLayer
    }
  }
  
  open var isEnabled: Bool {
    get {
      switch source {
      case .simurator(let connection):
        return true
      case .connection(let connection):
        return connection.isEnabled
      }
    }
    set {
      switch source {
      case .simurator(let connection):
        break
      case .connection(let connection):
        connection.isEnabled = newValue
      }
    }
  }
  
  open var isActive: Bool {
    switch source {
    case .simurator(let connection):
      return true
    case .connection(let connection):
      return connection.isActive
    }
  }
  
  open var audioChannels: [AVCaptureAudioChannel] {
    switch source {
    case .simurator(let connection):
      return []
    case .connection(let connection):
      return connection.audioChannels
    }
  }
  
  open var isVideoMirroringSupported: Bool {
    switch source {
    case .simurator(let connection):
      return true
    case .connection(let connection):
      return connection.isVideoMirroringSupported
    }
  }
  
  open var isVideoMirrored: Bool {
    get {
      switch source {
      case .simurator(let connection):
        return true
      case .connection(let connection):
        return connection.isVideoMirrored
      }
    }
    set {
      switch source {
      case .simurator(let connection):
        break
      case .connection(let connection):
        connection.isVideoMirrored = newValue
      }
    }
  }
  
  @available(iOS 6.0, *)
  open var automaticallyAdjustsVideoMirroring: Bool {
    get {
      switch source {
      case .simurator(let connection):
        return true
      case .connection(let connection):
        return connection.automaticallyAdjustsVideoMirroring
      }
    }
    set {
      switch source {
      case .simurator(let connection):
        break
      case .connection(let connection):
        connection.automaticallyAdjustsVideoMirroring = newValue
      }
    }
  }
  
  
  /*!
   @property supportsVideoOrientation
   @abstract
   Indicates whether the connection supports setting the videoOrientation property.
   
   @discussion
   This property is only applicable to AVCaptureConnection instances involving video. In such connections, the videoOrientation property may only be set if -isVideoOrientationSupported returns YES.
   */
  open var isVideoOrientationSupported: Bool {
    switch source {
    case .simurator(let connection):
      return true
    case .connection(let connection):
      return connection.isVideoOrientationSupported
    }
  }
  
  
  /*!
   @property videoOrientation
   @abstract
   Indicates whether the video flowing through the connection should be rotated to a given orientation.
   
   @discussion
   This property is only applicable to AVCaptureConnection instances involving video. If -isVideoOrientationSupported returns YES, videoOrientation may be set to rotate the video buffers being consumed by the connection's output. Note that setting videoOrientation does not necessarily result in a physical rotation of video buffers. For instance, a video connection to an AVCaptureMovieFileOutput handles orientation using a Quicktime track matrix. In the AVCaptureStillImageOutput, orientation is handled using Exif tags.
   */
  open var videoOrientation: AVCaptureVideoOrientation {
    get {
      switch source {
      case .simurator(let connection):
        return AVCaptureVideoOrientation.portrait
      case .connection(let connection):
        return connection.videoOrientation
      }
    }
    set {
      switch source {
      case .simurator(let connection):
        break
      case .connection(let connection):
        connection.videoOrientation = newValue
      }
    }
  }
  
  @available(iOS 5.0, *)
  open var videoMaxScaleAndCropFactor: CGFloat {
    switch source {
    case .simurator(let connection):
      return 1.0
    case .connection(let connection):
      return connection.videoMaxScaleAndCropFactor
    }
  }
  
  @available(iOS 5.0, *)
  open var videoScaleAndCropFactor: CGFloat {
    get {
      switch source {
      case .simurator(let connection):
        return 1.0
      case .connection(let connection):
        return connection.videoScaleAndCropFactor
      }
    }
    set {
      switch source {
      case .simurator(let connection):
        break
      case .connection(let connection):
        connection.videoScaleAndCropFactor = newValue
      }
    }
  }
  
  @available(iOS 8.0, *)
  open var preferredVideoStabilizationMode: AVCaptureVideoStabilizationMode {
    get {
      switch source {
      case .simurator(let connection):
        return AVCaptureVideoStabilizationMode.off
      case .connection(let connection):
        return connection.preferredVideoStabilizationMode
      }
    }
    set {
      switch source {
      case .simurator(let connection):
        break
      case .connection(let connection):
        connection.preferredVideoStabilizationMode = newValue
      }
    }
  }
  
  @available(iOS 8.0, *)
  open var activeVideoStabilizationMode: AVCaptureVideoStabilizationMode {
    switch source {
    case .simurator(let connection):
      return AVCaptureVideoStabilizationMode.off
    case .connection(let connection):
      return connection.activeVideoStabilizationMode
    }
  }
  
  @available(iOS 6.0, *)
  open var isVideoStabilizationSupported: Bool {
    switch source {
    case .simurator(let connection):
      return true
    case .connection(let connection):
      return connection.isVideoStabilizationSupported
    }
  }
  
  @available(iOS, introduced: 6.0, deprecated: 8.0, message: "Use activeVideoStabilizationMode instead.")
  open var isVideoStabilizationEnabled: Bool {
    switch source {
    case .simurator(let connection):
      return false
    case .connection(let connection):
      return connection.isVideoStabilizationEnabled
    }
  }
  
  @available(iOS, introduced: 6.0, deprecated: 8.0, message: "Use preferredVideoStabilizationMode instead.")
  open var enablesVideoStabilizationWhenAvailable: Bool {
    switch source {
    case .simurator(let connection):
      return false
    case .connection(let connection):
      return connection.enablesVideoStabilizationWhenAvailable
    }
  }
  
  @available(iOS 11.0, *)
  open var isCameraIntrinsicMatrixDeliverySupported: Bool {
    switch source {
    case .simurator(let connection):
      return false
    case .connection(let connection):
      return connection.isCameraIntrinsicMatrixDeliverySupported
    }
  }
  
  @available(iOS 11.0, *)
  open var isCameraIntrinsicMatrixDeliveryEnabled: Bool {
    switch source {
    case .simurator(let connection):
      return false
    case .connection(let connection):
      return connection.isCameraIntrinsicMatrixDeliveryEnabled
    }
  }
}
