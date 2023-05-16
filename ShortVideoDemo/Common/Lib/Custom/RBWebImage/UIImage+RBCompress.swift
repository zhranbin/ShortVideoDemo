//
//  UIImage+RBCompress.swift
//  RBAppDemo
//
//  Created by 冉彬 on 2023/4/6.
//

import Foundation
import UIKit
import ImageIO


extension UIImage {
    
    
    func computeSize() -> Int {
        var srcWidth = Int(self.size.width)
        var srcHeight = Int(self.size.height)
        srcWidth = srcWidth % 2 == 1 ? srcWidth + 1 : srcWidth
        srcHeight = srcHeight % 2 == 1 ? srcHeight + 1 : srcHeight

        let longSide = max(srcWidth, srcHeight)
        let shortSide = min(srcWidth, srcHeight)

        let scale = Float(shortSide) / Float(longSide)
        if scale <= 1 && scale > 0.5625 {
            if longSide < 1664 {
                return 1
            } else if longSide < 4990 {
                return 2
            } else if longSide > 4990 && longSide < 10240 {
                return 4
            } else {
                return longSide / 1280 == 0 ? 1 : longSide / 1280
            }
        } else if scale <= 0.5625 && scale > 0.5 {
            return longSide / 1280 == 0 ? 1 : longSide / 1280
        } else {
            return Int(ceil(Double(longSide) / (1280.0 / Double(scale))))
        }
    }
    
    
    func luban_compressedData(focusAlpha: Bool = false) -> Data? {
        
        guard cgImage != nil else { return nil }
        
        let options: [CFString: Any] = [
            kCGImageSourceShouldCache: false,
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height),
            kCGImageSourceCreateThumbnailWithTransform: true
        ]
        
        guard let imageData = pngData() ?? jpegData(compressionQuality: 1.0) else { return nil }
        
        guard let source = CGImageSourceCreateWithData(imageData as CFData, options as CFDictionary) else { return nil }
        
        guard let thumbnail = CGImageSourceCreateThumbnailAtIndex(source, 0, options as CFDictionary) else {
            return nil
        }
        
        let image = UIImage(cgImage: thumbnail)
        let compressionQuality: CGFloat = focusAlpha ? 1.0 : 0.6
        
        let cData = image.jpegData(compressionQuality: compressionQuality)
        print("swift鲁班压缩后: \(cData?.count)")
        
        return cData
    }
}


//extension UIImage {
//
//    private static var isCustomImage: Int8 = 0
//    private static var customImageName: Int8 = 0
//
//
//    public static func lubanCompressImage(_ image: UIImage) -> Data? {
//        return lubanCompressImage(image: image, withMask: nil)
//    }
//
//    public static func lubanCompressImage(image: UIImage, withMask maskName: String?) -> Data? {
//
//        var size: Double = 0.0
//        let imageData = image.jpegData(compressionQuality: 1)
//        printLog("Luban压缩前\(Double(imageData?.count ?? 0)/1024.0)")
//        let fixelW = Int(image.size.width)
//        let fixelH = Int(image.size.height)
//        var thumbW = fixelW % 2 == 1 ? fixelW + 1 : fixelW
//        var thumbH = fixelH % 2 == 1 ? fixelH + 1 : fixelH
//
//        let scale = Double(fixelW) / Double(fixelH)
//
//        if scale <= 1 && scale > 0.5625 {// [1, 0.5625) 即图片处于 [1:1 ~ 9:16) 比例范围内
//            if fixelH < 1664 {
//                if let imageDataCount = imageData?.count, imageDataCount / 1024 < 150 {
//                    return imageData
//                }
//                size = Double(fixelW * fixelH) / pow(1664, 2) * 150
//                size = size < 60 ? 60 : size
//            }
//            else if fixelH >= 1664 && fixelH < 4990 {
//                thumbW = fixelW / 2
//                thumbH = fixelH / 2
//                size = Double(thumbH * thumbW) / pow(2495, 2) * 300
//                size = size < 60 ? 60 : size
//            }
//            else if fixelH >= 4990 && fixelH < 10240 {
//                thumbW = fixelW / 4
//                thumbH = fixelH / 4
//                size = Double(thumbW * thumbH) / pow(2560, 2) * 300
//                size = size < 100 ? 100 : size
//            }
//            else {
//                let multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280
//                thumbW = fixelW / multiple
//                thumbH = fixelH / multiple
//                size = Double(thumbW * thumbH) / pow(2560, 2) * 300
//                size = size < 100 ? 100 : size
//            }
//        }
//        else if scale <= 0.5625 && scale > 0.5 {// [0.5625, 0.5) 即图片处于 [9:16 ~ 1:2) 比例范围内
//            if fixelH < 1280 && imageData?.count ?? 0 / 1024 < 200 {
//                return imageData
//            }
//            let multiple = fixelH / 1280 == 0 ? 1 : fixelH / 1280
//            thumbW = fixelW / multiple
//            thumbH = fixelH / multiple
//            size = Double(thumbW * thumbH) / (1440.0 * 2560.0) * 400
//            size = size < 100 ? 100 : size
//        }
//        else {
//            let multiple = Int(ceil(Double(fixelH) / (1280.0 / scale)))
//            thumbW = fixelW / multiple
//            thumbH = fixelH / multiple
//            size = Double(thumbW * thumbH) / (1280.0 * (1280 / scale)) * 500
//            size = size < 100 ? 100 : size
//        }
//        return compressImage(image, thumbWidth: thumbW, thumbHeight: thumbH, size: size, withMask: maskName)
//
//    }
//
//
//    static func lubanCompressImage(_ image: UIImage, withCustomImage imageName: String?) -> Data? {
//        if let imageName = imageName {
//            objc_setAssociatedObject(self, &isCustomImage, NSNumber(value: 1), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            objc_setAssociatedObject(self, &customImageName, imageName as NSString, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        return self.lubanCompressImage(image: image, withMask: nil)
//    }
//
//    private static func compressImage(_ image: UIImage, thumbWidth width: Int, thumbHeight height: Int, size: Double, withMask maskName: String?) -> Data? {
//        var thumbImage = image//image.fixOrientation()
////        thumbImage = thumbImage.resizeImage(thumbImage, thumbWidth: width, thumbHeight: height, withMask: maskName) ?? UIImage()
//
//        var qualityCompress: Float = 0.0
//        var imageData = thumbImage.jpegData(compressionQuality: CGFloat(qualityCompress))
//
//        var length = imageData?.count ?? 0
//        while length / 1024 > Int(size) && qualityCompress <= (1-0.06) {
//            qualityCompress += 0.06
//            let intCompress = Int(qualityCompress*100)
//            qualityCompress = Float(intCompress)/100.0
//            imageData = thumbImage.jpegData(compressionQuality: CGFloat(qualityCompress))
//            length = imageData?.count ?? 0
//            thumbImage = UIImage(data: imageData!)!
//        }
////        print("Luban-iOS image data size after compressed ==%f kb", Double(imageData!.count)/1024.0)
//        printLog("Luban压缩后\(Double(imageData?.count ?? 0)/1024.0)")
//
//        return imageData
//    }
//
//
//
////    // 指定大小
////    private func resizeImage(_ image: UIImage, thumbWidth width: Int, thumbHeight height: Int, withMask maskName: String?) -> UIImage? {
////        var outW = Int(image.size.width)
////        var outH = Int(image.size.height)
////
////        var inSampleSize = 1
////
////        if outW > width || outH > height {
////            var halfW = outW / 2
////            var halfH = outH / 2
////
////            while halfH / inSampleSize > height && halfW / inSampleSize > width {
////                inSampleSize *= 2
////            }
////        }
////        // 保留一位小数
////        let outWith = Int(Float(outW) / Float(width) * 10)
////        let outHeiht = Int(Float(outH) / Float(height) * 10)
////        let heightRatio = Float(outHeiht) / 10.0
////        let widthRatio = Float(outWith) / 10.0
////
////        if heightRatio > 1 || widthRatio > 1 {
////            inSampleSize = Int(max(heightRatio, widthRatio))
////        }
////        let thumbSize = CGSize(width: CGFloat(outW / inSampleSize), height: CGFloat(outH / inSampleSize))
////
////        UIGraphicsBeginImageContext(thumbSize)
////        guard let context = UIGraphicsGetCurrentContext() else {
////            return nil
////        }
////
////        image.draw(in: CGRect(x: 0, y: 0, width: thumbSize.width, height: thumbSize.height))
////
////        if let maskName = maskName {
////            context.translateBy(x: thumbSize.width / 2, y: thumbSize.height / 2)
////            context.scaleBy(x: 1, y: -1)
////            drawMask(with: maskName, context: context, radius: 0, angle: 0, colour: UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5), font: UIFont.systemFont(ofSize: 38.0), slantAngle: CGFloat(Double.pi / 6), size: thumbSize)
////        } else {
////            if let iscustom = objc_getAssociatedObject(self, &UIImage.isCustomImage) as? NSNumber,
////               iscustom.boolValue,
////               let imageName = objc_getAssociatedObject(self, &UIImage.customImageName) as? String,
////               let imageMask = UIImage(named: imageName) {
////                imageMask.draw(in: CGRect(x: 0, y: 0, width: thumbSize.width, height: thumbSize.height))
////            }
////        }
////
////        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
////        UIGraphicsEndImageContext()
////
////        objc_setAssociatedObject(self, &UIImage.isCustomImage, NSNumber(value: false), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
////
////        return resultImage
////    }
////
////
////    private func fixOrientation() -> UIImage {
////        guard self.imageOrientation != .up else { return self }
////        var transform = CGAffineTransform.identity
////
////        switch self.imageOrientation {
////        case .down, .downMirrored:
////            transform = transform.translatedBy(x: self.size.width, y: self.size.height)
////            transform = transform.rotated(by: CGFloat.pi)
////
////        case .left, .leftMirrored:
////            transform = transform.translatedBy(x: self.size.width, y: 0)
////            transform = transform.rotated(by: CGFloat.pi / 2)
////
////        case .right, .rightMirrored:
////            transform = transform.translatedBy(x: 0, y: self.size.height)
////            transform = transform.rotated(by: -CGFloat.pi / 2)
////
////        case .up, .upMirrored:
////            break
////        @unknown default:
////            break
////        }
////
////        switch self.imageOrientation {
////        case .upMirrored, .downMirrored:
////            transform = transform.translatedBy(x: self.size.width, y: 0)
////            transform = transform.scaledBy(x: -1, y: 1)
////
////        case .leftMirrored, .rightMirrored:
////            transform = transform.translatedBy(x: self.size.height, y: 0)
////            transform = transform.scaledBy(x: -1, y: 1)
////
////        case .up, .down, .left, .right:
////            break
////        @unknown default:
////            break
////        }
////
////
////        guard let cgImage = self.cgImage,
////              let colorSpace = cgImage.colorSpace,
////              let context = CGContext(data: nil, width: Int(self.size.width), height: Int(self.size.height),
////                                      bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0,
////                                      space: colorSpace, bitmapInfo: cgImage.bitmapInfo.rawValue)
////        else { return self }
////
////        context.concatenate(transform)
////
////        switch self.imageOrientation {
////        case .left, .leftMirrored, .right, .rightMirrored:
////            // Grr...
////            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.height, height: self.size.width))
////
////        default:
////            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
////        }
////
////
////        guard let newCGImage = context.makeImage() else { return self }
////
////        let newImage = UIImage(cgImage: newCGImage)
////        return newImage
////    }
////
////    private func drawMask(with str: String, context: CGContext, radius: CGFloat, angle: CGFloat, colour: UIColor, font: UIFont, slantAngle: CGFloat, size: CGSize) {
////
////        let attributes: [NSAttributedString.Key: Any] = [.foregroundColor: colour, .font: font]
////
////        context.saveGState()
////        // Undo the inversion of the Y-axis (or the text goes backwards!)
////        context.scaleBy(x: 1, y: -1)
////        // Move the origin to the centre of the text (negating the y-axis manually)
////        context.translateBy(x: radius * cos(angle), y: -(radius * sin(angle)))
////        // Rotate the coordinate system
////        context.rotate(by: -slantAngle)
////        // Calculate the width of the text
////        let offset = str.size(withAttributes: attributes)
////        // Move the origin by half the size of the text
////        context.translateBy(x: -offset.width / 2, y: -offset.height / 2)
////        // Draw the text
////
////        let width  = Int(ceil(cos(slantAngle)*offset.width))
////        let height = Int(ceil(sin(slantAngle)*offset.width))
////
////        let row    = Int(size.height/(CGFloat(height)+100.0))
////        let coloum = Int(size.width/(CGFloat(width)+100.0)>6 ? 6 : size.width/(CGFloat(width)+100.0))
////        var xPoint = CGFloat(0)
////        var yPoint = CGFloat(0)
////        for index in 0..<row*coloum {
////
////            xPoint = CGFloat(index % coloum) * (CGFloat(width)+100.0) - UIScreen.main.bounds.size.width
////            yPoint = CGFloat(index / coloum) * (CGFloat(height)+100.0)
////            str.draw(at: CGPoint(x: xPoint, y: yPoint), withAttributes: attributes)
////            xPoint += -UIScreen.main.bounds.size.width
////            yPoint += -UIScreen.main.bounds.size.height
////            str.draw(at: CGPoint(x: xPoint, y: yPoint), withAttributes: attributes)
////        }
////
////        // Restore the context
////        context.restoreGState()
////    }
//
//
//
//
//
//
//    static func compressImage(image: UIImage, maxLength: Int) -> Data? {
//        guard var imageData = image.jpegData(compressionQuality: 1) else {
//            return nil
//        }
//
//        printLog("压缩前\(Double(imageData.count )/1024.0)")
//        let length = imageData.count
//        if length < maxLength {
//            // 如果图片已经小于最大长度，则直接返回原图数据
//            return imageData
//        }
//
//        let ratio = imageRatio(size: image.size, maxSize: 1280)
//        guard let compressedImage = compressedImage(image: image, ratio: ratio),
//              let compressedImageData = compressedImage.jpegData(compressionQuality: 0.8) else {
//            return nil
//        }
//
//        let compressedLength = compressedImageData.count
//        if compressedLength > maxLength {
//            // 如果压缩后的图片仍然大于最大长度，则使用更低的压缩质量
//            guard let lowerQualityData = compressedImage.jpegData(compressionQuality: 0.6) else {
//                return nil
//            }
//            imageData = lowerQualityData
//        } else {
//            imageData = compressedImageData
//        }
//
//        printLog("压缩后\(Double(imageData.count )/1024.0)")
//        return imageData
//    }
//
//    static func imageRatio(size: CGSize, maxSize: CGFloat) -> CGFloat {
//        let width = size.width
//        let height = size.height
//
//        if width <= maxSize && height <= maxSize {
//            return 1.0
//        }
//
//        let maxDimension = max(width, height)
//        let ratio = maxDimension / maxSize
//        return ratio
//    }
//
//    static func compressedImage(image: UIImage, ratio: CGFloat) -> UIImage? {
//        let size = CGSize(width: image.size.width / ratio, height: image.size.height / ratio)
//        UIGraphicsBeginImageContext(size)
//        image.draw(in: CGRect(origin: .zero, size: size))
//        let compressedImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return compressedImage
//    }
//
//
//}
//
//
//
