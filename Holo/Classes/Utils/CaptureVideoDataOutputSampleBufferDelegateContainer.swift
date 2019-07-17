//
//  CaptureVideoDataOutputSampleBufferDelegateContainer.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AVFoundation

public protocol AnyCaptureVideoDataOutputSampleBufferDelegate: class {
  func captureOutput(_ output: AnyCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AnyCaptureConnection)
  func captureOutput(_ output: AnyCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AnyCaptureConnection)
}

protocol SimuratedCaptureVideoDataOutputSampleBufferDelegate: class {
  func captureOutput(_ output: CaptureOutputSimurator, didDrop sampleBuffer: CMSampleBuffer, from connection: CaptureConnectionSimurator)
  func captureOutput(_ output: CaptureOutputSimurator, didOutput sampleBuffer: CMSampleBuffer, from connection: CaptureConnectionSimurator)
}

class CaptureVideoDataOutputSampleBufferDelegateContainer: NSObject {
  weak var delegate: AnyCaptureVideoDataOutputSampleBufferDelegate? = nil
  
  init?(delegate: AnyCaptureVideoDataOutputSampleBufferDelegate?) {
    guard let delegate = delegate else { return }
    self.delegate = delegate
  }
}

extension CaptureVideoDataOutputSampleBufferDelegateContainer: AVFoundation.AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVFoundation.AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVFoundation.AVCaptureConnection) {
    delegate?.captureOutput(AnyCaptureOutput(source: .output(output)), didDrop: sampleBuffer, from: AnyCaptureConnection(source: .connection(connection)))
  }
  
  func captureOutput(_ output: AVFoundation.AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVFoundation.AVCaptureConnection) {
    delegate?.captureOutput(AnyCaptureOutput(source: .output(output)), didOutput: sampleBuffer, from: AnyCaptureConnection(source: .connection(connection)))
  }
}

extension CaptureVideoDataOutputSampleBufferDelegateContainer: SimuratedCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: CaptureOutputSimurator, didDrop sampleBuffer: CMSampleBuffer, from connection: CaptureConnectionSimurator) {
    delegate?.captureOutput(AnyCaptureOutput(source: .simurator(output)), didDrop: sampleBuffer, from: AnyCaptureConnection(source: .simurator(connection)))
  }
  
  func captureOutput(_ output: CaptureOutputSimurator, didOutput sampleBuffer: CMSampleBuffer, from connection: CaptureConnectionSimurator) {
    delegate?.captureOutput(AnyCaptureOutput(source: .simurator(output)), didOutput: sampleBuffer, from: AnyCaptureConnection(source: .simurator(connection)))
  }
}

