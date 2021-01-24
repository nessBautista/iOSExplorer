//
//  File.swift
//  
//
//  Created by Nestor Hernandez on 20/01/21.
//

import Foundation

struct ImageDownSizer {
    static func downSizeImage(data: Data, frameSize: CGSize, scale: CGFloat = 0.5) -> Data? {
        let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
        guard let imageSource = CGImageSourceCreateWithData(data as CFData, imageSourceOptions) else {
            return nil
        }
        let downSizeOptions = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true,
            kCGImageSourceThumbnailMaxPixelSize: max(frameSize.width, frameSize.height) * scale
        ] as CFDictionary
        guard let image = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downSizeOptions) else {
            return nil
        }
        return image.png
    }
}

func resizedImage(at data: Data, for size: CGSize) -> Data? {
    precondition(size != .zero)
    let options: [CFString: Any] = [
        kCGImageSourceThumbnailMaxPixelSize: max(size.width, size.height),
        kCGImageSourceCreateThumbnailFromImageAlways: true,
        kCGImageSourceCreateThumbnailWithTransform: true,
    ]
    guard let imageSource = CGImageSourceCreateWithData(data as CFData, nil),
        let image = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, options as CFDictionary)
    else {
        return nil
    }
    return image.png
}
