//
//  AnyCaptureSession.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/17.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AVFoundation

class CaptureSessionSimurator {
  private lazy var displayLink: CADisplayLink = .init(target: self, selector: #selector(update))
  private(set) var inputs: [CaptureInputSimurator] = []
  private(set) var outputs: [CaptureOutputSimurator] = []
  private lazy var thread: Thread = .init(target: self, selector: #selector(internalStartRunning), object: nil)
  
  @objc private func update(_ displayLink: CADisplayLink) {
    inputs.forEach({ $0._push() })
  }
  
  open func addInput(_ input: CaptureInputSimurator) {
    input._delegate = self
    inputs.append(input)
  }
  
  open func removeInput(_ input: CaptureInputSimurator) {
    preconditionFailure()
  }
  
  open func addOutput(_ output: CaptureOutputSimurator) {
    outputs.append(output)
  }
  
  open func removeOutput(_ output: CaptureOutputSimurator) {
    preconditionFailure()
  }
  
  open func addInputWithNoConnections(_ input: CaptureInputSimurator) {
    inputs.append(input)
  }
  
  open func addOutputWithNoConnections(_ output: CaptureOutputSimurator) {
    outputs.append(output)
  }
  
  open func startRunning() {
    thread.start()
  }
  
  @objc private func internalStartRunning() {
    displayLink.add(to: .current, forMode: .default)
  }
  
  open func stopRunning() {
    thread.cancel()
//    displayLink.remove(from: .current, forMode: .default)
  }
}

extension CaptureSessionSimurator: CaptureInputSimuratorDelegate {
  func didCaptured(input: CaptureInputSimurator, sampleBuffer: CMSampleBuffer) {
    outputs.forEach({ (output) in
      switch output {
      case let output as CaptureVideoDataOutputSimurator:
        output.sampleBufferCallbackQueue?.async {
          output.sampleBufferDelegate?.captureOutput(output, didOutput: sampleBuffer, from: CaptureConnectionSimurator())
        }
      default: break
      }
    })
  }
}

public class AnyCaptureSessionContainer {
  internal let simurator: CaptureSessionSimurator
  internal let session: AVFoundation.AVCaptureSession
  
  public init() {
    simurator = CaptureSessionSimurator()
    session = AVFoundation.AVCaptureSession()
  }
  
  open func canSetSessionPreset(_ preset: AVFoundation.AVCaptureSession.Preset) -> Bool {
    return session.canSetSessionPreset(preset)
  }
  
  open var sessionPreset: AVFoundation.AVCaptureSession.Preset {
    get { return session.sessionPreset }
    set { session.sessionPreset = newValue }
  }
  
  open var inputs: [AnyCaptureInput] {
    return session.inputs.map({ AnyCaptureInput(source: .input($0)) }) + simurator.inputs.map({ AnyCaptureInput(source: .simurator($0)) })
  }
  
  open func canAddInput(_ input: AnyCaptureInput) -> Bool {
    switch input.source {
    case .simurator:
      return true
    case .input(let input):
      return session.canAddInput(input)
    }
  }
  
  open func addInput(_ input: AnyCaptureInput) {
    switch input.source {
    case .simurator(let input):
      simurator.addInput(input)
    case .input(let input):
      session.addInput(input)
    }
  }
  
  open func removeInput(_ input: AnyCaptureInput) {
    switch input.source {
    case .simurator(let input):
      simurator.removeInput(input)
    case .input(let input):
      session.removeInput(input)
    }
  }
  
  open var outputs: [AnyCaptureOutput] {
    return session.outputs.map({ AnyCaptureOutput(source: .output($0)) }) + simurator.outputs.map({ AnyCaptureOutput(source: .simurator($0)) })
  }
  
  open func canAddOutput(_ output: AnyCaptureOutput) -> Bool {
    switch output.source {
    case .simurator:
      return true
    case .output(let output):
      return session.canAddOutput(output)
    }
  }
  
  open func addOutput(_ output: AnyCaptureOutput) {
    switch output.source {
    case .simurator(let output):
      simurator.addOutput(output)
    case .output(let output):
      session.addOutput(output)
    }
  }
  
  open func removeOutput(_ output: AnyCaptureOutput) {
    switch output.source {
    case .simurator(let output):
      simurator.removeOutput(output)
    case .output(let output):
      session.removeOutput(output)
    }
  }
  
  @available(iOS 8.0, *)
  open func addInputWithNoConnections(_ input: AnyCaptureInput) {
    switch input.source {
    case .simurator(let input):
      simurator.addInputWithNoConnections(input)
    case .input(let input):
      session.addInputWithNoConnections(input)
    }
  }
  
  @available(iOS 8.0, *)
  open func addOutputWithNoConnections(_ output: AnyCaptureOutput) {
    switch output.source {
    case .simurator(let output):
      simurator.addOutputWithNoConnections(output)
    case .output(let output):
      session.addOutputWithNoConnections(output)
    }
  }
  
  #if swift(>=5.1)
  @available(iOS 13.0, *)
  open var connections: [AnyCaptureConnection] {
    return session.connections.map({ AnyCaptureConnection(source: .connection($0)) })
  }
  #endif
  
  @available(iOS 8.0, *)
  open func canAddConnection(_ connection: AnyCaptureConnection) -> Bool {
    switch connection.source {
    case .simurator:
      return false
    case .connection(let connection):
      return session.canAddConnection(connection)
    }
  }
  
  @available(iOS 8.0, *)
  open func addConnection(_ connection: AnyCaptureConnection) {
    switch connection.source {
    case .simurator:
      break
    case .connection(let connection):
      session.addConnection(connection)
    }
  }
  
  @available(iOS 8.0, *)
  open func removeConnection(_ connection: AnyCaptureConnection) {
    switch connection.source {
    case .simurator:
      break
    case .connection(let connection):
      session.removeConnection(connection)
    }
  }
  
  open func beginConfiguration() {
    session.beginConfiguration()
  }
  
  open func commitConfiguration() {
    session.commitConfiguration()
  }
  
  open var isRunning: Bool {
    return session.isRunning
  }
  
  @available(iOS 4.0, *)
  open var isInterrupted: Bool {
    return session.isInterrupted
  }
  
  @available(iOS 7.0, *)
  open var usesApplicationAudioSession: Bool {
    return session.usesApplicationAudioSession
  }
  
  @available(iOS 7.0, *)
  open var automaticallyConfiguresApplicationAudioSession: Bool {
    return session.automaticallyConfiguresApplicationAudioSession
  }
  
  @available(iOS 10.0, *)
  open var automaticallyConfiguresCaptureDeviceForWideColor: Bool {
    return session.automaticallyConfiguresCaptureDeviceForWideColor
  }
  
  open func startRunning() {
    session.startRunning()
    simurator.startRunning()
  }
  
  open func stopRunning() {
    session.stopRunning()
    simurator.stopRunning()
  }
  
  @available(iOS 7.0, *)
  open var masterClock: CMClock? {
    return session.masterClock
  }
}

extension AnyCaptureSessionContainer {
  public typealias Preset = AVCaptureSession.Preset
}
