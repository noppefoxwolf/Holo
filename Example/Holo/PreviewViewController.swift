//
//  PreviewViewController.swift
//  Holo_Example
//
//  Created by Tomoya Hirano on 2019/07/26.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import AVFoundation

class PreviewViewController: UIViewController {
  private lazy var previewLayer: AVCaptureVideoPreviewLayer = .init(session: session)
  private lazy var device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .front)!
  private lazy var input = try! AVCaptureDeviceInput(device: device)
  private lazy var session: AVCaptureSession = {
    let session = AVCaptureSession()
    if session.canAddInput(input) {
      session.addInput(input)
    }
    return session
  }()
  
  override func loadView() {
    super.loadView()
    view.layer.addSublayer(previewLayer)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    session.startRunning()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    previewLayer.frame = view.bounds
  }
}
