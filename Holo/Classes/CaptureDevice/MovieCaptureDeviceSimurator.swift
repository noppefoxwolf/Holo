//
//  MovieCaptureDeviceSimurator.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation

class MovieCaptureDeviceSimurator: CaptureDeviceSimurator {
  private let outputSettings: [String : Any] = [kCVPixelBufferPixelFormatTypeKey as String : kCVPixelFormatType_32BGRA]
  let asset: AVURLAsset
  lazy var reader: AVAssetReader = { preconditionFailure() }()
  lazy var output: AVAssetReaderTrackOutput = { preconditionFailure() }()
  
  init(url: URL) {
    asset = AVURLAsset(url: url)
    super.init()
    reader = try! AVAssetReader(asset: asset)
    output = AVAssetReaderTrackOutput(track: asset.tracks(withMediaType: AVMediaType.video)[0], outputSettings: outputSettings)
    reader.add(output)
    output.alwaysCopiesSampleData = false
    reader.startReading()
  }
  
  static func make() -> MovieCaptureDeviceSimurator {
    return MovieCaptureDeviceSimurator(url: Bundle.main.url(forResource: "video", withExtension: "m4v")!)
  }
  
  override func _push() {
    guard let sampleBuffer = output.copyNextSampleBuffer() else { return }
    _delegate?.didCaptured(sampleBuffer: sampleBuffer)
  }
}
