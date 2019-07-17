//
//  AnyCaptureOutput.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AVFoundation

class CaptureOutputSimurator {
  
}

public class AnyCaptureOutput {
  enum Source {
    case simurator(CaptureOutputSimurator)
    case output(AVFoundation.AVCaptureOutput)
  }
  internal let source: Source
  
  init(source: Source) {
    self.source = source
  }
}
