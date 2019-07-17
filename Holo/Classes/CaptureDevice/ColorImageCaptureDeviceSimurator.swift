//
//  ColorImageCaptureDeviceSimurator.swift
//  Holo
//
//  Created by Tomoya Hirano on 2019/07/17.
//

import UIKit

class ColorImageCaptureDeviceSimurator: CaptureDeviceSimurator {
  let image: UIImage
  
  init(color: UIColor, size: CGSize) {
    UIGraphicsBeginImageContext(size)
    let rect = CGRect(origin: .zero, size: size)
    let context = UIGraphicsGetCurrentContext()
    context?.setFillColor(color.cgColor)
    context?.fill(rect)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.image = image!
  }
  
  override func _push() {
    _delegate?.didCaptured(sampleBuffer: image.cmSampleBuffer)
  }
}

import CoreImage
import CoreVideo
import CoreMedia

extension UIImage {
  fileprivate var cvPixelBuffer: CVPixelBuffer? {
    var pixelBuffer: CVPixelBuffer? = nil
    let options: [NSObject: Any] = [
      kCVPixelBufferCGImageCompatibilityKey: false,
      kCVPixelBufferCGBitmapContextCompatibilityKey: false,
    ]
    let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32BGRA, options as CFDictionary, &pixelBuffer)
    CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
    let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
    let rgbColorSpace = cgImage!.colorSpace!
    let bitmapInfo: UInt32 = cgImage!.bitmapInfo.rawValue
    
    let context = CGContext(data: pixelData, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo)
    context?.draw(cgImage!, in: CGRect(origin: .zero, size: size))
    CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
    return pixelBuffer
  }
  
  fileprivate var cmSampleBuffer: CMSampleBuffer {
    let pixelBuffer = cvPixelBuffer
    var newSampleBuffer: CMSampleBuffer? = nil
    var timimgInfo: CMSampleTimingInfo = .init(duration: .zero, presentationTimeStamp: .zero, decodeTimeStamp: .zero)
    var videoInfo: CMVideoFormatDescription? = nil
    CMVideoFormatDescriptionCreateForImageBuffer(allocator: nil, imageBuffer: pixelBuffer!, formatDescriptionOut: &videoInfo)
    CMSampleBufferCreateForImageBuffer(allocator: kCFAllocatorDefault, imageBuffer: pixelBuffer!, dataReady: true, makeDataReadyCallback: nil, refcon: nil, formatDescription: videoInfo!, sampleTiming: &timimgInfo, sampleBufferOut: &newSampleBuffer)
    return newSampleBuffer!
  }
}
