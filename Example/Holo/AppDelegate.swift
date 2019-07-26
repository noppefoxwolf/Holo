//
//  AppDelegate.swift
//  Holo
//
//  Created by noppefoxwolf on 07/17/2019.
//  Copyright (c) 2019 noppefoxwolf. All rights reserved.
//

import UIKit

#if targetEnvironment(simulator)
import Holo
typealias AVCaptureDevice = AnyCaptureDevice
typealias AVCaptureDeviceInput = AnyCaptureDeviceInput
typealias AVCaptureSession = AnyCaptureSessionContainer
typealias AVCaptureVideoDataOutput = AnyCaptureVideoDataOutput
typealias AVCaptureConnection = AnyCaptureConnection
typealias AVCaptureVideoDataOutputSampleBufferDelegate = AnyCaptureVideoDataOutputSampleBufferDelegate
typealias AVCaptureOutput = AnyCaptureOutput
typealias AVCaptureVideoPreviewLayer = AnyCaptureVideoPreviewLayer
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  lazy var window: UIWindow? = .init(frame: UIScreen.main.bounds)
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    #if targetEnvironment(simulator)
    HoloSettings.shared.mode = .video(Bundle.main.url(forResource: "video", withExtension: "mp4")!)
    #endif
    
    window?.rootViewController = UINavigationController(rootViewController: ExampleSelectionViewController())
    window?.makeKeyAndVisible()
    
    return true
  }
}


class ExampleSelectionViewController: UITableViewController {
  enum Feature: Int, CaseIterable {
    case display
    case preview
    
    var title: String {
      switch self {
      case .display: return "AVSampleBufferDisplayLayer"
      case .preview: return "AVCaptureVideoPreviewLayer"
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return Feature.allCases.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let feature = Feature(rawValue: indexPath.row)
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = feature?.title
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    switch Feature(rawValue: indexPath.row) {
    case .some(.display):
      let vc = DisplayViewController()
      navigationController?.pushViewController(vc, animated: true)
    case .some(.preview):
      let vc = PreviewViewController()
      navigationController?.pushViewController(vc, animated: true)
    default: break
    }
  }
}
