//
//  TranslatorViewController.swift
//  PetTalk
//
//  Created by Rita on 07.02.2025.
//

import UIKit

class TranslatorViewController: BaseViewController {
    
    private let humanLabel = UILabel()
    private let petLabel = UILabel()
    private let arrowImageView = UIImageView()
    private var swapStackView = UIStackView()
    private let animalImageView = UIImageView()
    private let processing = UILabel()
    
    private let recordingView = RecordingView()
    private let audioRecorder = AudioRecorderManager()
    private lazy var animalSwitch = AnimalSwitch(delegate: self)
    
    private lazy var state: RecordingState = .waiting
    private lazy var currentAnimal: AnimalType = .cat
    private lazy var hidingUI = [humanLabel, petLabel, arrowImageView, swapStackView, recordingView, animalSwitch]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.applyDefaultGradientBackground()
        setupHumanPetSwapContainer()
        setupRecordingView()
        setupAnimalSwitch()
        setupProcessingLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        state = .waiting
        updateUI()
    }
    
    private func updateUI() {
        customNavBar.titleLabel.text = state.title
        recordingView.configured(by: state)
        hidingUI.forEach { $0.isHidden = (state == .processing) }
        processing.isHidden = (state != .processing)
        
        switch state {
        case .waiting:
            break
        case .recording:
            audioRecorder.startRecording()
        case .processing:
            audioRecorder.stopRecording()
            let resultVC = ResultViewController(animalType: currentAnimal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.navigationController?.pushViewController(resultVC, animated: true)
            }
        }
    }
    
    private func setupProcessingLabel() {
        view.addSubview(processing)
        processing.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            processing.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            processing.widthAnchor.constraint(equalToConstant: 310),
            processing.bottomAnchor.constraint(equalTo: animalImageView.topAnchor, constant: -63),
        ])
        processing.text = "Process of translation..."
        processing.textAlignment = .center
        processing.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        
    }
    
    private func setupHumanPetSwapContainer() {
        
        humanLabel.text = "HUMAN"
        humanLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        humanLabel.textAlignment = .center
        humanLabel.widthAnchor.constraint(equalToConstant: 136).isActive = true
        
        petLabel.text = "PET"
        petLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        petLabel.textAlignment = .center
        petLabel.widthAnchor.constraint(equalToConstant: 135).isActive = true
        
        arrowImageView.image = Images.arrow
        arrowImageView.tintColor = .black
        arrowImageView.contentMode = .scaleAspectFit
        arrowImageView.isUserInteractionEnabled = true
        
        swapStackView = UIStackView(arrangedSubviews: [humanLabel, arrowImageView, petLabel])
        swapStackView.axis = .horizontal
        swapStackView.alignment = .center
        swapStackView.spacing = 10
        
        view.addSubview(swapStackView)
        swapStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            swapStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swapStackView.widthAnchor.constraint(equalToConstant: 310),
            swapStackView.topAnchor.constraint(equalTo: customNavBar.bottomAnchor, constant: 12),
            
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowImageView.centerXAnchor.constraint(equalTo: swapStackView.centerXAnchor)
        ])
        
        let arrowTapGesture = UITapGestureRecognizer(target: self, action: #selector(swapLabels))
        arrowImageView.addGestureRecognizer(arrowTapGesture)
    }
    
    @objc func swapLabels() {
        let temp = humanLabel.text
        humanLabel.text = petLabel.text
        petLabel.text = temp
    }
    
    private func setupRecordingView() {
        
        view.addSubview(recordingView)
        
        NSLayoutConstraint.activate([
            recordingView.topAnchor.constraint(equalTo: swapStackView.bottomAnchor, constant: 58),
            recordingView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35)
        ])
        
        recordingView.layer.shadowOpacity = 0.25
        recordingView.layer.shadowOffset = CGSize(width: 0, height: 5)
        recordingView.layer.shadowRadius = 14.3
        
        let recordingTapGesture = UITapGestureRecognizer(target: self, action: #selector(recordingButtonTapped))
        recordingView.addGestureRecognizer(recordingTapGesture)
    }
    
    @objc func recordingButtonTapped() {
        audioRecorder.requestMicrophonePermission { [weak self] granted in
            guard let self else { return }
            
            if granted {
                state.next()
                updateUI()
            } else {
                print("Recording not started as microphone access was denied.")
            }
        }
    }
}

extension TranslatorViewController: AnimalSwitchDelegate {
    
    private func setupAnimalSwitch() {
        
        animalImageView.contentMode = .scaleAspectFit
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        animalSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(animalImageView)
        view.addSubview(animalSwitch)
        
        NSLayoutConstraint.activate([
            animalSwitch.topAnchor.constraint(equalTo: recordingView.topAnchor),
            animalSwitch.bottomAnchor.constraint(equalTo: recordingView.bottomAnchor),
            animalSwitch.leadingAnchor.constraint(equalTo: recordingView.trailingAnchor, constant: 35),
            animalSwitch.widthAnchor.constraint(equalToConstant: 107),
        ])
        
        animalSwitch.layer.shadowOpacity = 0.25
        animalSwitch.layer.shadowOffset = CGSize(width: 0, height: 5)
        animalSwitch.layer.shadowRadius = 14.3
        
        NSLayoutConstraint.activate([
            animalImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -164),
            animalImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animalImageView.widthAnchor.constraint(equalToConstant: 184),
            animalImageView.heightAnchor.constraint(equalToConstant: 184)
        ])
    }
    
    func didChangeAnimal(to type: AnimalType) {
        currentAnimal = type
        animalImageView.image = type.image
    }
}
