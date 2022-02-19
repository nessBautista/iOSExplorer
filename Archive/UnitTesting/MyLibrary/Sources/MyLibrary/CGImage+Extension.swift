//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 20/01/21.
//

import Foundation
import ImageIO
public enum UniformTypeIdentifier: String {
    case png = "public.png"
    case jpeg = "public.jpeg"
    case html = "public.html"
    case text = "public.text"
    case plainText = "public.plain-text"
}
public extension CGImage {
    var png: Data? {        
        guard let mutableData = CFDataCreateMutable(nil, 0),
              let destination = CGImageDestinationCreateWithData(mutableData, UniformTypeIdentifier.png.rawValue as CFString, 1, nil)
        else { return nil }
        CGImageDestinationAddImage(destination, self, nil)
        guard CGImageDestinationFinalize(destination) else { return nil }
        
        return mutableData as Data
    }
}

public extension Data {
    func resizedImage(width: Double, height: Double) -> Data? {
        let size = CGSize(width: width, height: height)
        precondition(size != .zero)

        let options: [CFString: Any] = [
            kCGImageSourceThumbnailMaxPixelSize: Swift.max(size.width, size.height),
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
        ]

        guard let imageSource = CGImageSourceCreateWithData(self as CFData, nil),
            let image = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
        else {
            return nil
        }
        return image.png
    }
    
    func downSizeImage(width: Double, height: Double, scale: CGFloat = 0.5) -> Data? {
            let frameSize = CGSize(width: width, height: height)
            let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
            guard let imageSource = CGImageSourceCreateWithData(self as CFData, imageSourceOptions) else {
                return nil
            }
            let downSizeOptions = [
                kCGImageSourceCreateThumbnailFromImageAlways: true,
                kCGImageSourceCreateThumbnailWithTransform: true,
                kCGImageSourceShouldCacheImmediately: true,
                kCGImageSourceThumbnailMaxPixelSize: Swift.max(frameSize.width, frameSize.height) * scale
            ] as CFDictionary
            guard let image = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSizeOptions) else {
                return nil
            }
        
        return image.png
        
    }

}
