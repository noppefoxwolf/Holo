//
//  HoloSettings.swift
//  Holo
//
//  Created by Tomoya Hirano on 2019/07/17.
//

import UIKit

public class HoloSettings {
  public static let shared: HoloSettings = HoloSettings()
  
  public enum SimurateMode {
    case color(UIColor, CGSize)
    case image(UIImage)
    case video(URL)
  }
  
  private init() {}
  
  public var mode: SimurateMode = .color(.red, CGSize(width: 1280, height: 720))
}
