//
//  AnyCaptureInput.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AVFoundation

internal protocol CaptureInputSimuratorDelegate: class {
  func didCaptured(input: CaptureInputSimurator, sampleBuffer: CMSampleBuffer)
}

class CaptureInputSimurator {
  internal weak var _delegate: CaptureInputSimuratorDelegate? = nil
  
  func _push() {
    
  }
}

public class AnyCaptureInput {
  enum Source {
    case simurator(CaptureInputSimurator)
    case input(AVFoundation.AVCaptureInput)
  }
  internal let source: Source
  
  init(source: Source) {
    self.source = source
  }
  
  open var ports: [AVCaptureInput.Port] {
    switch source {
    case .input(let input):
      return input.ports
    case .simurator(let input):
      return []
    }
  }
}

