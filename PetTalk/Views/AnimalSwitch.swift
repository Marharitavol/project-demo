//
//  AnimalSwitchView.swift
//  PetTalk
//
//  Created by Rita on 08.02.2025.
//

import UIKit

protocol AnimalSwitchDelegate: AnyObject {
    func didChangeAnimal(to type: AnimalType)
}

class AnimalSwitch: UIView {
    
    private weak var delegate: AnimalSwitchDelegate?
    
    private let selectedImageView = UIImageView()
    private let catSquare = UIView()
    private let dogSquare = UIView()
    private let catImage = UIImageView()
    private let dogImage = UIImageView()
    
    init(delegate: AnimalSwitchDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        
        backgroundColor = .white
        setupView()
        catTapped()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupView() {
        layer.cornerRadius = 16
        
        selectedImageView.contentMode = .scaleAspectFit
        selectedImageView.translatesAutoresizingMaskIntoConstraints = false
        
        catSquare.backgroundColor = UIColor(red: 209/255, green: 231/255, blue: 252/255, alpha: 1)
        catSquare.layer.cornerRadius = 8
        catImage.image = Images.cat
        
        dogSquare.backgroundColor = UIColor(red: 236/255, green: 251/255, blue: 199/255, alpha: 1)
        dogSquare.layer.cornerRadius = 8
        dogImage.image = Images.dog
        
        catSquare.translatesAutoresizingMaskIntoConstraints = false
        dogSquare.translatesAutoresizingMaskIntoConstraints = false
        catImage.translatesAutoresizingMaskIntoConstraints = false
        dogImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(catSquare)
        addSubview(dogSquare)
        addSubview(catImage)
        addSubview(dogImage)
        
        NSLayoutConstraint.activate([
            catSquare.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            catSquare.centerXAnchor.constraint(equalTo: centerXAnchor),
            catSquare.widthAnchor.constraint(equalToConstant: 70),
            catSquare.heightAnchor.constraint(equalToConstant: 70),
            
            dogSquare.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            dogSquare.widthAnchor.constraint(equalToConstant: 70),
            dogSquare.heightAnchor.constraint(equalToConstant: 70),
            dogSquare.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            catImage.widthAnchor.constraint(equalToConstant: 40),
            catImage.heightAnchor.constraint(equalToConstant: 40),
            catImage.centerXAnchor.constraint(equalTo: catSquare.centerXAnchor),
            catImage.centerYAnchor.constraint(equalTo: catSquare.centerYAnchor),
            
            
            dogImage.widthAnchor.constraint(equalToConstant: 40),
            dogImage.heightAnchor.constraint(equalToConstant: 40),
            dogImage.centerXAnchor.constraint(equalTo: dogSquare.centerXAnchor),
            dogImage.centerYAnchor.constraint(equalTo: dogSquare.centerYAnchor),
        ])
        
        let catTapGesture = UITapGestureRecognizer(target: self, action: #selector(catTapped))
        let dogTapGesture = UITapGestureRecognizer(target: self, action: #selector(dogTapped))
        catSquare.addGestureRecognizer(catTapGesture)
        dogSquare.addGestureRecognizer(dogTapGesture)
    }
    
    @objc private func catTapped() {
        selectedImageView.image = Images.cat
        delegate?.didChangeAnimal(to: .cat)
        
        catSquare.alpha = 1.0
        catImage.alpha = 1.0
        
        dogSquare.alpha = 0.5
        dogImage.alpha = 0.5
        
    }
    
    @objc private func dogTapped() {
        selectedImageView.image = Images.dog
        delegate?.didChangeAnimal(to: .dog)
        
        catSquare.alpha = 0.5
        catImage.alpha = 0.5
        
        dogSquare.alpha = 1.0
        dogImage.alpha = 1.0
    }
}
