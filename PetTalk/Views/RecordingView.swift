//
//  MicrophoneView.swift
//  PetTalk
//
//  Created by Rita on 08.02.2025.
//

import UIKit

class RecordingView: UIView {
    
    private let micImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let gifImageView = UIImageView()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configured(by state: RecordingState) {
        label.text = state.text
        
        guard let content = state.content else {
            micImageView.image = nil
            return
        }
        
        switch content {
        case .image(let name):
            micImageView.image = UIImage(named: name)
            gifImageView.image = nil
        case .gif(let name):
            gifImageView.loadGif(named: name)
            micImageView.image = nil
        }
    }
    
    private func setupView() {
        backgroundColor = UIColor.white
        layer.cornerRadius = 16
        translatesAutoresizingMaskIntoConstraints = false
        gifImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(micImageView)
        addSubview(gifImageView)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalToConstant: 178),
            heightAnchor.constraint(equalToConstant: 178),
            micImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            gifImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: micImageView.bottomAnchor, constant: 24),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        setupImageConstraint()
        setupGifConstraint()
    }
    
    private func setupImageConstraint() {
        NSLayoutConstraint.activate([
            micImageView.widthAnchor.constraint(equalToConstant: 70),
            micImageView.heightAnchor.constraint(equalToConstant: 70),
            micImageView.topAnchor.constraint(equalTo: topAnchor, constant: 44)
        ])
    }
    
    private func setupGifConstraint() {
        NSLayoutConstraint.activate([
            gifImageView.widthAnchor.constraint(equalToConstant: 163),
            gifImageView.heightAnchor.constraint(equalToConstant: 95),
            gifImageView.topAnchor.constraint(equalTo: topAnchor, constant: 19)
        ])
    }
}
