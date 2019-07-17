//
//  ViewController.swift
//  Holo
//
//  Created by noppefoxwolf on 07/17/2019.
//  Copyright (c) 2019 noppefoxwolf. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
  private let displayLayer: AVSampleBufferDisplayLayer = .init()
  private lazy var device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .front)!
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
