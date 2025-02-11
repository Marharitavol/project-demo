//
//  RecordState.swift
//  PetTalk
//
//  Created by Rita on 09.02.2025.
//

enum RecordingState {
    case waiting
    case recording
    case processing
    
    enum contentType {
        case image(String), gif(String)
    }
    
    var content: contentType? {
        switch self {
        case .waiting:
            return .image("microphone")
        case .recording:
            return .gif("gif")
        case .processing:
            return nil
        }
    }
    
    var text: String {
        switch self {
        case .waiting:
            "Start Speak"
        case .recording:
            "Recording..."
        case .processing:
            ""
        }
    }
    
    var title: String {
        switch self {
        case .waiting, .recording:
            "Translator"
        case .processing:
            ""
        }
    }
    
    mutating func next() {
        switch self {
        case .waiting:
            self = .recording
        case .recording:
            self = .processing
        case .processing:
            self = .waiting
        }
    }
}
