//
//  GifExtension.swift
//  PetTalk
//
//  Created by Rita on 09.02.2025.
//

import UIKit
import ImageIO

extension UIImageView {
    func loadGif(named name: String) {
        guard let asset = NSDataAsset(name: name) else { return }
        let data = asset.data
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return }
        
        var frames: [UIImage] = []
        let frameCount = CGImageSourceGetCount(source)
        
        for i in 0..<frameCount {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                frames.append(UIImage(cgImage: cgImage))
            }
        }
        
        self.image = UIImage.animatedImage(with: frames, duration: 1.0)
    }
}
