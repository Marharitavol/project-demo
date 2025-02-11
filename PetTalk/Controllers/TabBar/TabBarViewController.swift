//
//  TabBarViewController.swift
//  PetTalk
//
//  Created by Rita on 07.02.2025.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private lazy var mainVC = TranslatorViewController()
    private lazy var settingsVC = SettingsViewController()
    
    private lazy var mainButton = getButton(icon: "messages", tag: 0, action: action, title: "Translator", opacity: 1)
    private lazy var settingsButton = getButton(icon: "gearshape", tag: 1, action: action, title: "Clicker")
    
    private lazy var action = UIAction { [weak self] sender in
        guard let self, let sender = sender.sender as? UIButton else { return }
        
        selectedIndex = sender.tag
        setOpacity(tag: sender.tag)
    }
    
    lazy var customBar: UIStackView = {
        let customBar = UIStackView()
        customBar.axis = .horizontal
        customBar.distribution = .equalSpacing
        customBar.alignment = .center
        customBar.backgroundColor = .white
        customBar.layer.cornerRadius = 16
        
        customBar.addArrangedSubview(UIView())
        customBar.addArrangedSubview(mainButton)
        customBar.addArrangedSubview(settingsButton)
        customBar.addArrangedSubview(UIView())
        
        customBar.layer.shadowColor = UIColor(red: 55/255, green: 62/255, blue: 125/255, alpha: 1).cgColor
        customBar.layer.shadowOpacity = 0.15
        customBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        customBar.layer.shadowRadius = 50
        customBar.layer.masksToBounds = false
        
        view.addSubview(customBar)
        customBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            customBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customBar.widthAnchor.constraint(equalToConstant: 216),
            customBar.heightAnchor.constraint(equalToConstant: 82),
        ])
        return customBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customBar)
        tabBar.isHidden = true
        configureTabs()
    }
    
    private func configureTabs() {
        let mainNav = UINavigationController(rootViewController: mainVC)
        let settingsNav = UINavigationController(rootViewController: settingsVC)
        
        setViewControllers([mainNav, settingsNav], animated: true)
    }
    
    private func getButton(icon: String, tag: Int, action: UIAction, title: String, opacity: Float = 0.5) -> UIButton {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: icon)
        config.imagePlacement = .top
        config.imagePadding = 4
        config.baseForegroundColor = .black
        config.title = title
        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attr in
            var newAttr = attr
            newAttr.font = UIFont.boldSystemFont(ofSize: 12)
            return newAttr
        }
        
        let button = UIButton(configuration: config, primaryAction: action)
        button.layer.opacity = opacity
        button.tag = tag
        return button
    }
    
    private func setOpacity(tag: Int) {
        [mainButton, settingsButton].forEach { button in
            if button.tag != tag {
                button.layer.opacity = 0.5
            } else {
                button.layer.opacity = 1
            }
        }
    }
}
