//
//  SettingsViewModel.swift
//  PetTalk
//
//  Created by Rita on 11.02.2025.
//

import Foundation

class SettingsViewModel {
    
    private lazy var settingsData = [
        "Rate Us", "Share App", "Contact Us", "Restore Purchases", "Privacy Policy", "Terms of Use"
    ]
    
    func getSettingsCount() -> Int {
        settingsData.count
    }
    
    func getSetting(by indexPath: IndexPath) -> String {
        settingsData[indexPath.row]
    }
}
