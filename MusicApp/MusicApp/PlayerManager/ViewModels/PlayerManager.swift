//
//  PlayerManager.swift
//  MusicApp
//
//  Created by Admin on 27/01/25.
//

import Foundation
import AVFoundation

class PlayerManager: ObservableObject {
    static let shared = PlayerManager()
    
    @Published var currentTime: Double = 0
    @Published var duration: Double = 300
    
    @Published var speed: String = "1"
    @Published var showSpeedSelector: Bool = false
    var speedOptions: [String] = ["1", "1.25", "1.5", "1.75", "2"]
    
    @Published var sleepTimer: Int = 0
    @Published var showSleepTimer: Bool = false
    var sleepTimerOptions: [Int] = [0, 10, 20, 30]     // for 5th option use (duration-currentTime) while selecting
    
    @Published var isLiked: Bool = false
    @Published var isPlaying: Bool = false
    @Published var showFullLyrics: Bool = false
    
    var audioPlayer: AVAudioPlayer?
    private var displayLink: CADisplayLink?
    
//    private init() {
//         loadSampleSong()
//    }

    func formatTime(_ time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func loadSampleSong() {
        guard let fileURL = Bundle.main.url(forResource: "ApnaBanaLe", withExtension: "mp3") else {
            print("Sample song not found")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: fileURL)
            audioPlayer?.prepareToPlay()
            duration = audioPlayer?.duration ?? 300
        } catch {
            print("Failed to load audio: \(error)")
        }
    }
    
    func togglePlayPause() {
        guard let player = audioPlayer else { return }

        if player.isPlaying {
            player.pause()
            stopDisplayLink()
            isPlaying = false
        } else {
            player.play()
            startDisplayLink()
            isPlaying = true
        }
    }
    
    private func startDisplayLink() {
        stopDisplayLink()
        displayLink = CADisplayLink(target: self, selector: #selector(updateCurrentTime))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    private func stopDisplayLink() {
        displayLink?.invalidate()
        displayLink = nil
    }
    
    @objc private func updateCurrentTime() {
        guard let player = audioPlayer else { return }
        currentTime = player.currentTime
    }

    func seek(to time: Double) {
        guard let player = audioPlayer else { return }
        player.currentTime = time
        currentTime = time
    }

    deinit {
        stopDisplayLink()
    }
    
    // Forward by 10 seconds
    func forward10Sec() {
        guard let player = audioPlayer else { return }
        
        let targetTime = min(player.currentTime + 10, player.duration)
        player.currentTime = targetTime
        currentTime = targetTime
    }
        
    // Backward by 10 seconds
    func backward10Sec() {
        guard let player = audioPlayer else { return }
        
        let targetTime = max(player.currentTime - 10, 0)
        player.currentTime = targetTime
        currentTime = targetTime
    }
        
    // Change playback speed
    func changeSpeed(to newSpeed: String) {
        guard let speedValue = Float(newSpeed), let player = audioPlayer else { return }
        player.enableRate = true
        player.rate = speedValue
        speed = newSpeed
        player.currentTime = player.currentTime
        //print("Changed speed to: \(newSpeed), rate is now: \(player.rate), current time: \(player.currentTime)")
    }

}

