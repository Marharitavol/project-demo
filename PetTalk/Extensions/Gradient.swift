//
//  Gradient.swift
//  PetTalk
//
//  Created by Rita on 07.02.2025.
//

import UIKit

extension UIView {
    func applyDefaultGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1).cgColor ,
            UIColor(red: 201/255, green: 255/255, blue: 224/255, alpha: 1).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame = bounds
        
        layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
