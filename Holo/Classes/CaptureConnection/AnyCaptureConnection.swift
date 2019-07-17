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
}
