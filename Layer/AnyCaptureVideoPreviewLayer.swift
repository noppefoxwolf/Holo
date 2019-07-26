//
//  AnyCaptureVideoPreviewLayer.swift
//  Holo
//
//  Created by Tomoya Hirano on 2019/07/26.
//

import AVFoundation

@available(iOS 4.0, *)
open class AnyCaptureVideoPreviewLayer : AVSampleBufferDisplayLayer {
  private var output: AnyCaptureVideoDataOutput? = nil
  
  public convenience init(session: AnyCaptureSessionContainer) {
    self.init()
    setSession(session)
  }
  
  @available(iOS 8.0, *)
  public convenience init(sessionWithNoConnection session: AnyCaptureSessionContainer) {
    self.init()
    setSessionWithNoConnection(session)
  }
  
  open var session: AnyCaptureSessionContainer? = nil {
    didSet {
      let output = AnyCaptureVideoDataOutput()
      output.setSampleBufferDelegate(self, queue: .main)
      session?.addOutput(output)
      self.output = output
    }
  }
  
  private func setSession(_ session: AnyCaptureSessionContainer) {
    self.session = session
  }
  
  @available(iOS 8.0, *)
  open func setSessionWithNoConnection(_ session: AnyCaptureSessionContainer) {
    self.session = session
  }
  
  @available(iOS 6.0, *)
  open var connection: AnyCaptureConnection? {
    return nil
  }
  
  open override var videoGravity: AVLayerVideoGravity {
    get { return super.videoGravity }
    set { super.videoGravity = newValue }
  }
  
  @available(iOS 6.0, *)
  open func captureDevicePointConverted(fromLayerPoint pointInLayer: CGPoint) -> CGPoint {
    return .zero
  }
  
  @available(iOS 6.0, *)
  open func layerPointConverted(fromCaptureDevicePoint captureDevicePointOfInterest: CGPoint) -> CGPoint {
    return .zero
  }
  
  @available(iOS 7.0, *)
  open func metadataOutputRectConverted(fromLayerRect rectInLayerCoordinates: CGRect) -> CGRect {
    return .zero
  }
  
  @available(iOS 7.0, *)
  open func layerRectConverted(fromMetadataOutputRect rectInMetadataOutputCoordinates: CGRect) -> CGRect {
    return .zero
  }
  
  @available(iOS 6.0, *)
  open func transformedMetadataObject(for metadataObject: AVMetadataObject) -> AVMetadataObject? {
    return nil
  }
}

extension AnyCaptureVideoPreviewLayer: AnyCaptureVideoDataOutputSampleBufferDelegate {
  public func captureOutput(_ output: AnyCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AnyCaptureConnection) {
    self.enqueue(sampleBuffer)
  }
  
  public func captureOutput(_ output: AnyCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AnyCaptureConnection) {
    self.enqueue(sampleBuffer)
  }
}
