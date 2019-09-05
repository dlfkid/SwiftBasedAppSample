//
//  UIImagePlugin.swift
//  NewProjectDemo
//
//  Created by LeonDeng on 2019/9/5.
//  Copyright © 2019 LeonDeng. All rights reserved.
//

import UIKit
import Accelerate
import AVFoundation.AVAsset
import CoreVideo.CVPixelBuffer

extension UIImage {
    
    /// 获取像素流
    var pixelBuffer: CVPixelBuffer? {
        guard let cgImage = cgImage else { return nil }
        
        var pixelBuffer: CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32BGRA, nil, &pixelBuffer)
        
        guard status == kCVReturnSuccess else { return nil }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags.init(rawValue: 0))
        let data = CVPixelBufferGetBaseAddress(pixelBuffer!)
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
        let context = CGContext(data: data, width: Int(size.width), height: Int(size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: bitmapInfo.rawValue)
        
        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        
        return pixelBuffer
    }
    
    /// 获取视频封面图
    ///
    /// - Parameter url: 视频Url
    /// - Returns: 封面图
    static func thumbnail(OfVideoURL url: URL) -> UIImage? {
        let asset = AVAsset(url: url)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        //Can set this to improve performance if target size is known before hand
        //assetImgGenerate.maximumSize = CGSize(width,height)
        let time = CMTimeMakeWithSeconds(1.0, preferredTimescale: 600)
        do {
            let img = try assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            let thumbnail = UIImage(cgImage: img)
            return thumbnail
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
    
    /// 拉伸或压缩图片
    ///
    /// - Parameter fitSize: 需要的大小
    /// - Returns: 拉伸后的图片
    func scaled(toFit fitSize: CGSize) -> UIImage? {
        // Create a vImage_Buffer from the CGImage
        guard let sourceRef = cgImage else { return nil }
        
        var srcBuffer = vImage_Buffer()
        var format = vImage_CGImageFormat(bitsPerComponent: 8,
                                          bitsPerPixel: 32,
                                          colorSpace: nil,
                                          bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
                                          version: 0,
                                          decode: nil,
                                          renderingIntent: .defaultIntent)
        var ret = vImageBuffer_InitWithCGImage(&srcBuffer, &format, nil, sourceRef, vImage_Flags(kvImageNoFlags))
        
        guard ret == kvImageNoError else {
            free(srcBuffer.data)
            return nil
        }
        
        // Create dest buffer
        let scale = UIScreen.main.scale
        let dstWidth = Int(fitSize.width * scale)
        let dstHeight = Int(fitSize.height * scale)
        let bytesPerPixel: Int = 4
        let dstBytesPerRow: Int = bytesPerPixel * dstWidth
        let dstData = UnsafeMutablePointer<UInt8>.allocate(capacity: dstHeight * dstWidth * bytesPerPixel)
        
        var dstBuffer = vImage_Buffer(data: dstData,
                                      height: vImagePixelCount(dstHeight),
                                      width: vImagePixelCount(dstWidth),
                                      rowBytes: dstBytesPerRow)
        
        // Scale
        ret = vImageScale_ARGB8888(&srcBuffer, &dstBuffer, nil, vImage_Flags(kvImageHighQualityResampling))
        free(srcBuffer.data)
        
        guard ret == kvImageNoError else { return nil }
        
        // Create CGImage from vImage_Buffer
        ret = kvImageNoError
        guard let destRef = vImageCreateCGImageFromBuffer(&dstBuffer, &format, nil, nil, vImage_Flags(kvImageNoAllocate), &ret)?.takeRetainedValue() else {
            return nil
        }
        
        guard ret == kvImageNoError else { return nil }
        
        // Create UIImage
        return UIImage(cgImage: destRef, scale: 0.0, orientation: imageOrientation)
    }
}
