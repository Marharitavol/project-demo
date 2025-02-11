//
//  BaseViewController.swift
//  PetTalk
//
//  Created by Rita on 11.02.2025.
//

import UIKit

class BaseViewController: UIViewController {
        
    public let customNavBar = CustomNavigationBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCustomNavBar()
    }
    
    private func setupCustomNavBar() {
        view.addSubview(customNavBar)
        customNavBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customNavBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            customNavBar.heightAnchor.constraint(equalToConstant: 148)
        ])
        
        customNavBar.backButton.isHidden = true
        customNavBar.backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    @objc public func backAction() {
        navigationController?.popViewController(animated: true)
    }
}
