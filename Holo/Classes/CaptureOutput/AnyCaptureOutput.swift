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
  
  open var connections: [AnyCaptureConnection] {
    switch source {
    case .simurator(_):
      return []
    case .output(let output):
      return output.connections.map({ AnyCaptureConnection(source: .connection($0)) })
    }
  }
  
  @available(iOS 5.0, *)
  open func connection(with mediaType: AVMediaType) -> AnyCaptureConnection? {
    switch source {
    case .simurator(_):
      return nil
    case .output(let output):
      guard let connection = output.connection(with: mediaType) else { return nil }
      return AnyCaptureConnection(source: .connection(connection))
    }
  }
  
  @available(iOS 6.0, *)
  open func transformedMetadataObject(for metadataObject: AVMetadataObject, connection: AVCaptureConnection) -> AVMetadataObject? {
    switch source {
    case .simurator(_):
      return nil
    case .output(let output):
      return output.transformedMetadataObject(for: metadataObject, connection: connection)
    }
  }
  
  @available(iOS 7.0, *)
  open func metadataOutputRectConverted(fromOutputRect rectInOutputCoordinates: CGRect) -> CGRect {
    switch source {
    case .simurator(_):
      return .zero
    case .output(let output):
      return output.metadataOutputRectConverted(fromOutputRect: rectInOutputCoordinates)
    }
  }
  
  @available(iOS 7.0, *)
  open func outputRectConverted(fromMetadataOutputRect rectInMetadataOutputCoordinates: CGRect) -> CGRect {
    switch source {
    case .simurator(_):
      return .zero
    case .output(let output):
      return output.outputRectConverted(fromMetadataOutputRect: rectInMetadataOutputCoordinates)
    }
  }
}
