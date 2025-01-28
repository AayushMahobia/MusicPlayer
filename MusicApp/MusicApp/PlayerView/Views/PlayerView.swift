//
//  PlayerView.swift
//  MusicApp
//
//  Created by Admin on 24/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct PlayerView: View {
    
    let album: AlbumModel
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(edges: .all)
            ScrollView{
                VStack(spacing: 40){
                    NavBar()
                    VStack(alignment: .leading, spacing: 20) {
                        SongDetails(album: album)
                        PlayerControls()
                    }
                    LyricsSection()
                }
            }
            .foregroundStyle(.white)
            .padding()
            .scrollIndicators(.hidden)
        }
    }
}


struct NavBar: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        HStack{
            Button {
                dismiss()
            } label: {
                Image(systemName: "chevron.down")
            }
            Spacer()
            Text("Recently Played")
            Spacer()
            HStack(spacing: 3){
                Image(systemName: "circle.fill")
                Image(systemName: "circle.fill")
                Image(systemName: "circle.fill")
            }
            .font(.system(size: 4))
        }
        .font(.headline)
    }
}


struct SongDetails: View {
    
    let album: AlbumModel
    @ObservedObject var playerManager: PlayerManager = PlayerManager.shared
    
    var body: some View {
        VStack(spacing: 25){
            WebImage(url: URL(string: album.albumThumbnail))
                .resizable()
                .frame(height: 360)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            HStack{
                VStack(alignment: .leading, spacing: 10){
                    Text(album.songs[0])
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(album.artistName)
                        .foregroundStyle(.secondary)
                }
                Spacer()
                Button {
                    playerManager.isLiked.toggle()
                } label: {
                    Image(systemName: playerManager.isLiked ? "heart.fill" : "heart")
                        .foregroundStyle(playerManager.isLiked ? .red : .white)
                        .font(.title)
                }
            }
        }
    }
}


struct PlayerControls: View {
    
    @ObservedObject var playerManager: PlayerManager = PlayerManager.shared
    
    var body: some View {
        VStack(spacing: 20){
            
            // Seek Bar
            VStack(spacing: 8) {
                GeometryReader { geometry in
                    Slider(
                        value: Binding(
                            get: { playerManager.currentTime },
                            set: { newTime in
                                playerManager.seek(to: newTime)
                            }
                        ),
                        in: 0...playerManager.duration,
                        step: 1
                    )
                    .tint(.purple)
                    .onTapGesture { location in
                        let sliderWidth = geometry.size.width
                        let tapLocation = location.x
                        let newTime = Double(tapLocation / sliderWidth) * playerManager.duration
                        playerManager.currentTime = newTime
                        playerManager.seek(to: newTime)
                    }
                }
                .frame(height: 40) // Adjust the frame size for GeometryReader
                HStack{
                    Text(playerManager.formatTime(playerManager.currentTime))
                    Spacer()
                    Text("-\(playerManager.formatTime(playerManager.duration - playerManager.currentTime))")
                }
                .font(.caption)
                .foregroundStyle(.white)
            }
            
            // 1st Row of buttons
            HStack{
                Image(systemName: "backward.end.fill")
                Spacer()
                HStack {
                    Spacer()
                    
                    Button {
                        playerManager.backward10Sec()
                    } label: {
                        Image(systemName: "10.arrow.trianglehead.counterclockwise")
                    }
                    
                    Spacer()
                    
                    Button {
                        playerManager.togglePlayPause()
                    } label: {
                        Image(systemName: playerManager.isPlaying ? "pause.fill" : "play.fill")
                            .background(
                                Circle()
                                    .frame(width: 55, height: 55)
                                    .foregroundStyle(.purple)
                            )
                    }
                    
                    Spacer()
                    
                    Button {
                        playerManager.forward10Sec()
                    } label: {
                        Image(systemName: "10.arrow.trianglehead.clockwise")
                    }
                    
                    Spacer()
                }
                .font(.title)
                Spacer()
                Image(systemName: "forward.end.fill")
            }
            .font(.title2)
            .padding(.horizontal, 30)
            
            // 2nd Row of buttons
            HStack{
                Button {
                    playerManager.showSpeedSelector.toggle()
                } label: {
                    HStack {
                        Image(systemName: "barometer")
                        Text("\(playerManager.speed)x")
                    }
                }
                .sheet(isPresented: $playerManager.showSpeedSelector) {
                    SpeedSelector()
                        .presentationDetents([.fraction(0.6)])
                }
                Spacer()
                Button {
                    playerManager.showSleepTimer.toggle()
                } label: {
                    Image(systemName: playerManager.sleepTimer == 0 ? "moon" : "moon.fill")
                }
                .sheet(isPresented: $playerManager.showSleepTimer) {
                    SleepTimerSelector()
                        .presentationDetents([.fraction(0.6)])
                }
            }
            .font(.title2)
            .padding(.top, 10)
        }
        .onAppear() {
            playerManager.loadSampleSong()
        }
        .fontWeight(.semibold)
    }
}

struct SpeedSelector: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var playerManager: PlayerManager = PlayerManager.shared
    
    var body: some View {
        ZStack(alignment: .top){
            Color(UIColor.darkGray)
                .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 40){
                Image(systemName: "minus")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                VStack(spacing: 20) {
                    Image(systemName: "barometer")
                        .font(.largeTitle)
                    Text("Set Playback Speed")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                VStack(spacing: 30) {
                    ForEach(playerManager.speedOptions, id: \.self) { speed in
                        Button {
                            playerManager.changeSpeed(to: speed)
                            dismiss()
                        } label: {
                            HStack {
                                Text("\(speed == "1" ? "\(speed)x - Normal" : "\(speed)x")")
                                Spacer()
                                Image(systemName: speed == playerManager.speed ? "record.circle" : "circle")
                            }
                            .font(.title3)
                        }
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
}


struct SleepTimerSelector: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var playerManager: PlayerManager = PlayerManager.shared
    
    var body: some View {
        ZStack(alignment: .top){
            Color(UIColor.darkGray)
                .ignoresSafeArea(edges: .bottom)
            
            VStack(spacing: 40){
                Image(systemName: "minus")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                VStack(spacing: 20) {
                    Image(systemName: "moon")
                        .font(.largeTitle)
                    Text("Set Sleep Timer")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
                VStack(spacing: 30) {
                    ForEach(playerManager.sleepTimerOptions, id: \.self) { timer in
                        Button {
                            playerManager.sleepTimer = timer
                            dismiss()
                        } label: {
                            HStack {
                                Text("\(timer == 0 ? "Off" : "\(timer) minutes")")
                                Spacer()
                                Image(systemName: timer == playerManager.sleepTimer ? "record.circle" : "circle")
                            }
                            .font(.title3)
                        }
                    }
                    Button {
                        playerManager.sleepTimer = Int(playerManager.duration - playerManager.currentTime)
                        dismiss()
                    } label: {
                        HStack {
                            Text("End of the song")
                            Spacer()
                            Image(systemName: (playerManager.sleepTimer == Int(playerManager.duration - playerManager.currentTime)) ? "record.circle" : "circle")
                        }
                        .font(.title3)
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
        }
    }
}


struct LyricsSection: View {
    
    @ObservedObject var playerManager: PlayerManager = PlayerManager.shared
    
    var body: some View {
        ZStack(alignment: .top){
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(UIColor.darkGray))
                .frame(height: 400)
            HStack{
                Text("Lyrics")
                    .font(.headline)
                Spacer()
                HStack(spacing: 15) {
                    Image(systemName: "square.and.arrow.up")
                    Button {
                        playerManager.showFullLyrics.toggle()
                    } label: {
                        Image(systemName: "arrow.down.left.and.arrow.up.right")
                    }
                }
                .font(.title3)
            }
            .padding()
            .foregroundStyle(.white)
            .fullScreenCover(isPresented: $playerManager.showFullLyrics) {
                FullLyrics()
            }
        }
    }
}

struct FullLyrics: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .top){
            Color(UIColor.darkGray)
                .ignoresSafeArea(edges: .all)
            HStack{
                Text("Lyrics")
                    .font(.headline)
                Spacer()
                HStack(spacing: 15) {
                    Image(systemName: "square.and.arrow.up")
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.up.right.and.arrow.down.left")
                    }
                }
                .font(.title3)
            }
            .padding()
            .foregroundStyle(.white)
        }
    }
}


#Preview {
    let album: AlbumModel = .init(
        artistName: "Arijit Singh",
        albumName: "Arjit Album 1",
        albumThumbnail: "https://images.pexels.com/photos/1173648/pexels-photo-1173648.jpeg?auto=compress&cs=tinysrgb&w=800",
        dateReleased: "2021",
        songs: ["Apna Bana Le"]
    )
    PlayerView(album: album)
}
