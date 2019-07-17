//
//  AnyCaptureDeviceInput.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AVFoundation

class CaptureDeviceInputSimurator: CaptureInputSimurator {
  let device: CaptureDeviceSimurator
  
  init(device: CaptureDeviceSimurator) {
    self.device = device
    super.init()
    device._delegate = self
  }
  
  override func _push() {
    device._push()
  }
}

extension CaptureDeviceInputSimurator: CaptureDeviceSimuratorDelegate {
  func didCaptured(sampleBuffer: CMSampleBuffer) {
    _delegate?.didCaptured(input: self, sampleBuffer: sampleBuffer)
  }
}

public class AnyCaptureDeviceInput: AnyCaptureInput {
  public init(device: AnyCaptureDevice) throws {
    switch device.source {
    case .simurator(let device):
      super.init(source: .simurator(CaptureDeviceInputSimurator(device: device)))
    case .device(let device):
      let input = try AVFoundation.AVCaptureDeviceInput(device: device)
      super.init(source: .input(input))
    }
  }
}

