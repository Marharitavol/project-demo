//
//  AnimalType.swift
//  PetTalk
//
//  Created by Rita on 11.02.2025.
//

import UIKit

enum AnimalType {
    case cat, dog
    
    var image: UIImage? {
        switch self {
        case .cat:
            Images.cat
        case .dog:
            Images.dog
        }
    }
}
