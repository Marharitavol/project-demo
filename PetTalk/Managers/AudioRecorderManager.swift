//
//  Untitled.swift
//  PetTalk
//
//  Created by Rita on 08.02.2025.
//

import AVFoundation
import UIKit

class AudioRecorderManager {
    
    private var audioEngine = AVAudioEngine()
    private var isRecording = false
    
    func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
        if #available(iOS 17.0, *) {
            AVAudioApplication.requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        completion(true)
                    } else {
                        self.showMicrophoneAccessAlert()
                        completion(false)
                    }
                }
            }
        } else {
            AVAudioSession.sharedInstance().requestRecordPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        completion(true)
                    } else {
                        self.showMicrophoneAccessAlert()
                        completion(false)
                    }
                }
            }
        }
    }
    
    func startRecording() {
        requestMicrophonePermission { [weak self] granted in
            guard let self else { return }
            
            if granted {
                self.startAudioEngine()
            } else {
                print("❌ Microphone access denied.")
            }
        }
    }
    
    private func startAudioEngine() {
        if isRecording { return }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: [])
            try audioSession.setActive(true, options: [])
            
            let sampleRate = audioSession.sampleRate
            let inputNode = audioEngine.inputNode
            let format = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: sampleRate, channels: 1, interleaved: false)
            
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: format) { (buffer, time) in
                
            }
            
            try audioEngine.start()
            isRecording = true
            print("🔴 Recording started...")
        } catch {
            print("Ошибка при настройке AVAudioSession или старте аудио движка: \(error.localizedDescription)")
        }
    }
    
    
    func stopRecording() {
        if !isRecording { return }
        
        audioEngine.stop()
        audioEngine.inputNode.removeTap(onBus: 0)
        isRecording = false
        print("🛑 Recording stopped.")
    }
    
    func isRecordingActive() -> Bool {
        return isRecording
    }
    
    private func showMicrophoneAccessAlert() {
        guard let topViewController = getTopViewController() else { return }
        
        let alert = UIAlertController(
            title: "Enable Microphone Access",
            message: "Please allow access to your microphone to use the app's features",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }))
        
        topViewController.present(alert, animated: true, completion: nil)
    }
    
    private func getTopViewController() -> UIViewController? {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first(where: { $0.isKeyWindow }) else {
            return nil
        }
        return window.rootViewController?.topMostViewController()
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        if let navigationController = self as? UINavigationController {
            return navigationController.visibleViewController?.topMostViewController() ?? navigationController
        }
        if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.topMostViewController() ?? tabBarController
        }
        return self
    }
}
