//
//  ResultViewController.swift
//  PetTalk
//
//  Created by Rita on 10.02.2025.
//

import UIKit

class ResultViewController: BaseViewController {
    
    private let animalImageView = UIImageView()
    private let talkPolygon = UIImageView()
    private let talkBubble = UIView()
    private let processingLabel = UILabel()
    private let repeatView = UIView()
    private let repeatLabel = UILabel()
    private let repeatImage = UIImageView()
    
    private let animalType: AnimalType
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyDefaultGradientBackground()
        setupCustomNavBar()
        setupAnimalImage()
        setupBubbleTalk()
        setupLabel()
        setupRepeatButton()
        showRepeatButton()
    }
    
    init(animalType: AnimalType) {
        self.animalType = animalType
        animalImageView.image = animalType.image
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.tabBarController as? TabBarViewController)?.customBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        typyingAnimation(text: animalType == .cat ? "I’m hungry, feed me!" : "What are you doing, human?")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (self.tabBarController as? TabBarViewController)?.customBar.isHidden = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCustomNavBar() {
        customNavBar.titleLabel.text = "Result"
        customNavBar.backButton.isHidden = false
    }
    
    private func setupBubbleTalk() {
        talkPolygon.translatesAutoresizingMaskIntoConstraints = false
        talkPolygon.contentMode = .scaleAspectFit
        talkPolygon.image = Images.polygon
        view.addSubview(talkPolygon)
        
        talkBubble.translatesAutoresizingMaskIntoConstraints = false
        talkBubble.backgroundColor = UIColor(red: 214/255, green: 220/255, blue: 255/255, alpha: 1)
        talkBubble.layer.shadowOpacity = 0.15
        talkBubble.layer.shadowOffset = CGSize(width: 0, height: 5)
        talkBubble.layer.shadowRadius = 4
        talkBubble.layer.cornerRadius = 16
        view.addSubview(talkBubble)
        
        NSLayoutConstraint.activate([
            talkBubble.widthAnchor.constraint(equalToConstant: 291),
            talkBubble.heightAnchor.constraint(equalToConstant: 142),
            talkBubble.bottomAnchor.constraint(equalTo: animalImageView.topAnchor, constant: -125),
            talkBubble.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            talkPolygon.topAnchor.constraint(equalTo: talkBubble.bottomAnchor, constant: -20),
            talkPolygon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 252.11),
        ])
    }
    
    private func setupLabel() {
        processingLabel.translatesAutoresizingMaskIntoConstraints = false
        processingLabel.numberOfLines = 0
        processingLabel.textAlignment = .center
        processingLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        processingLabel.text = ""
        
        talkBubble.addSubview(processingLabel)
        
        NSLayoutConstraint.activate([
            processingLabel.centerXAnchor.constraint(equalTo: talkBubble.centerXAnchor),
            processingLabel.centerYAnchor.constraint(equalTo: talkBubble.centerYAnchor),
        ])
    }
    
    private func setupAnimalImage() {
        animalImageView.contentMode = .scaleAspectFit
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animalImageView)
        
        NSLayoutConstraint.activate([
            animalImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -164),
            animalImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animalImageView.widthAnchor.constraint(equalToConstant: 184),
            animalImageView.heightAnchor.constraint(equalToConstant: 184)
        ])
    }
    
    private func setupRepeatButton() {
        repeatView.isHidden = true
        repeatLabel.isHidden = true
        repeatImage.isHidden = true
        
        repeatView.translatesAutoresizingMaskIntoConstraints = false
        repeatView.backgroundColor = UIColor(red: 214/255, green: 220/255, blue: 255/255, alpha: 1)
        repeatView.layer.shadowOpacity = 0.15
        repeatView.layer.shadowOffset = CGSize(width: 0, height: 5)
        repeatView.layer.shadowRadius = 4
        
        repeatView.layer.cornerRadius = 16
        view.addSubview(repeatView)
        
        NSLayoutConstraint.activate([
            repeatView.widthAnchor.constraint(equalToConstant: 291),
            repeatView.heightAnchor.constraint(equalToConstant: 54),
            repeatView.bottomAnchor.constraint(equalTo: animalImageView.topAnchor, constant: -125),
            repeatView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        repeatLabel.translatesAutoresizingMaskIntoConstraints = false
        repeatView.addSubview(repeatLabel)
        repeatLabel.text = "Repeat"
        repeatLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        
        NSLayoutConstraint.activate([
            repeatLabel.trailingAnchor.constraint(equalTo: repeatView.trailingAnchor, constant: -111.5),
            repeatLabel.centerYAnchor.constraint(equalTo: repeatView.centerYAnchor),
        ])
        
        repeatImage.translatesAutoresizingMaskIntoConstraints = false
        repeatView.addSubview(repeatImage)
        repeatImage.image = Images.rotate
        
        NSLayoutConstraint.activate([
            repeatImage.trailingAnchor.constraint(equalTo: repeatLabel.leadingAnchor, constant: -10),
            repeatImage.centerYAnchor.constraint(equalTo: repeatView.centerYAnchor),
        ])
        
        let reapetTapGesture = UITapGestureRecognizer(target: self, action: #selector(repeatTapped))
        repeatView.addGestureRecognizer(reapetTapGesture)
    }
    
    @objc func repeatTapped() {
        backAction()
    }
    
    private func showRepeatButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            self.repeatView.isHidden = false
            self.repeatLabel.isHidden = false
            self.repeatImage.isHidden = false
            
            self.talkPolygon.isHidden = true
            self.talkBubble.isHidden = true
            self.processingLabel.isHidden = true
        }
    }
    
    private func typyingAnimation(text: String) {
        for i in text {
            processingLabel.text! += "\(i)"
            RunLoop.current.run(until: Date() + 0.05)
        }
    }
}
