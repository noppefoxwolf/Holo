//
//  AnyCaptureVideoDataOutput.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AVFoundation

class CaptureVideoDataOutputSimurator: CaptureOutputSimurator {
  weak var sampleBufferDelegate: SimuratedCaptureVideoDataOutputSampleBufferDelegate? = nil
  var sampleBufferCallbackQueue: DispatchQueue? = nil
  
  open func setSampleBufferDelegate(_ sampleBufferDelegate: SimuratedCaptureVideoDataOutputSampleBufferDelegate?, queue sampleBufferCallbackQueue: DispatchQueue?) {
    self.sampleBufferDelegate = sampleBufferDelegate
    self.sampleBufferCallbackQueue = sampleBufferCallbackQueue
  }
}

public class AnyCaptureVideoDataOutput: AnyCaptureOutput {
  private var _delegateContainer: CaptureVideoDataOutputSampleBufferDelegateContainer? = nil
  
  public init() {
    super.init(source: .simurator(CaptureVideoDataOutputSimurator()))
  }
  
  open func setSampleBufferDelegate(_ sampleBufferDelegate: AnyCaptureVideoDataOutputSampleBufferDelegate?, queue sampleBufferCallbackQueue: DispatchQueue?) {
    switch source {
    case .simurator(let output):
      guard let output = output as? CaptureVideoDataOutputSimurator else { return }
      let delegateContainer = CaptureVideoDataOutputSampleBufferDelegateContainer(delegate: sampleBufferDelegate)
      _delegateContainer = delegateContainer
      output.setSampleBufferDelegate(delegateContainer, queue: sampleBufferCallbackQueue)
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return }
      let delegateContainer = CaptureVideoDataOutputSampleBufferDelegateContainer(delegate: sampleBufferDelegate)
      _delegateContainer = delegateContainer
      output.setSampleBufferDelegate(delegateContainer, queue: sampleBufferCallbackQueue)
    }
    if sampleBufferDelegate == nil {
      _delegateContainer = nil
    }
  }
  
  open var sampleBufferDelegate: AnyCaptureVideoDataOutputSampleBufferDelegate? {
    return _delegateContainer?.delegate
  }
  
  open var sampleBufferCallbackQueue: DispatchQueue? {
    switch source {
    case .simurator(let output):
      guard let output = output as? CaptureVideoDataOutputSimurator else { return nil }
      return output.sampleBufferCallbackQueue
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return nil }
      return output.sampleBufferCallbackQueue
    }
  }
  
  open var videoSettings: [String : Any]! {
    switch source {
    case .simurator:
      return nil
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return nil }
      return output.videoSettings
    }
  }
  
  @available(iOS 7.0, *)
  open func recommendedVideoSettingsForAssetWriter(writingTo outputFileType: AVFileType) -> [String : Any]? {
    switch source {
    case .simurator:
      return nil
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return nil }
      return output.recommendedVideoSettingsForAssetWriter(writingTo: outputFileType)
    }
  }
  
  @available(iOS 11.0, *)
  open func availableVideoCodecTypesForAssetWriter(writingTo outputFileType: AVFileType) -> [AVVideoCodecType] {
    switch source {
    case .simurator:
      return []
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return [] }
      return output.availableVideoCodecTypesForAssetWriter(writingTo: outputFileType)
    }
  }
  
  @available(iOS 11.0, *)
  open func recommendedVideoSettings(forVideoCodecType videoCodecType: AVVideoCodecType, assetWriterOutputFileType outputFileType: AVFileType) -> [AnyHashable : Any]? {
    switch source {
    case .simurator:
      return nil
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return nil }
      return output.recommendedVideoSettings(forVideoCodecType: videoCodecType, assetWriterOutputFileType: outputFileType)
    }
  }
  
  @available(iOS 5.0, *)
  open var availableVideoCodecTypes: [AVVideoCodecType] {
    switch source {
    case .simurator:
      return []
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return [] }
      return output.availableVideoCodecTypes
    }
  }
  
  open var alwaysDiscardsLateVideoFrames: Bool {
    switch source {
    case .simurator:
      return false
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return false }
      return output.alwaysDiscardsLateVideoFrames
    }
  }
  
  @available(iOS 13.0, *)
  open var automaticallyConfiguresOutputBufferDimensions: Bool {
    switch source {
    case .simurator:
      return false
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return false }
      return output.automaticallyConfiguresOutputBufferDimensions
    }
  }
  
  @available(iOS 13.0, *)
  open var deliversPreviewSizedOutputBuffers: Bool {
    switch source {
    case .simurator:
      return false
    case .output(let output):
      guard let output = output as? AVFoundation.AVCaptureVideoDataOutput else { return false }
      return output.deliversPreviewSizedOutputBuffers
    }
  }
}
