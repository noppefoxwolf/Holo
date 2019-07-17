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
#endif

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    #if targetEnvironment(simulator)
    HoloSettings.shared.mode = .video(Bundle.main.url(forResource: "video", withExtension: "mp4")!)
    #endif
    
    return true
  }
}


