//
//  PlayerViewModel.swift
//  MusicApp
//
//  Created by Admin on 24/01/25.
//

import Foundation

class PlayerViewModel: ObservableObject {
    
    @Published var currentTime: Double = 150
    @Published var duration: Double = 300
    @Published var isLiked: Bool = false
    @Published var isPlaying: Bool = false
    @Published var showFullLyrics: Bool = false
    
    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
