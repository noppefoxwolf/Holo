//
//  ViewController.swift
//  Holo
//
//  Created by tomoya.hirano on 07/17/2019.
//  Copyright (c) 2019 tomoya.hirano. All rights reserved.
//

import UIKit
import AVFoundation

#if targetEnvironment(simulator)
import Holo
typealias AVCaptureDevice = AnyCaptureDevice
typealias AVCaptureDeviceInput = AnyCaptureDeviceInput
typealias AVCaptureSession = AnyCaptureSessionContainer
typealias AVCaptureVideoDataOutput = AnyCaptureVideoDataOutput
typealias AVCaptureConnection = AnyCaptureConnection
typealias AVCaptureVideoDataOutputSampleBufferDelegate = AnyCaptureVideoDataOutputSampleBufferDelegate
typealias AVCaptureOutput = AnyCaptureOutput
#endif

class ViewController: UIViewController {
  private let displayLayer: AVSampleBufferDisplayLayer = .init()
  private let device = AVCaptureDevice.default(for: .video)!
  private lazy var input = try! AVCaptureDeviceInput(device: device)
  private lazy var output: AVCaptureVideoDataOutput = {
    let output = AVCaptureVideoDataOutput()
    output.setSampleBufferDelegate(self, queue: .main)
    return output
  }()
  private lazy var session: AVCaptureSession = {
    let session = AVCaptureSession()
    if session.canAddInput(input) {
      session.addInput(input)
    }
    if session.canAddOutput(output) {
      session.addOutput(output)
    }
    return session
  }()
  
  override func loadView() {
    super.loadView()
    view.layer.addSublayer(displayLayer)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    session.startRunning()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    displayLayer.frame = view.bounds
  }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
  func captureOutput(_ output: AVCaptureOutput, didDrop sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    displayLayer.enqueue(sampleBuffer)
  }
  
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    displayLayer.enqueue(sampleBuffer)
  }
}
