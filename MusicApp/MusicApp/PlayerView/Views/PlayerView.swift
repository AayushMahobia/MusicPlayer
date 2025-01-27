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
    
    @StateObject var playerViewModel: PlayerViewModel = PlayerViewModel()
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(edges: .all)
            ScrollView{
                VStack(spacing: 40){
                    navBar()
                    VStack(alignment: .leading, spacing: 20) {
                        songDetails(album: album, playerViewModel: playerViewModel)
                        playerControls(playerViewModel: playerViewModel)
                    }
                    lyricsSection(playerViewModel: playerViewModel)
                }
            }
            .foregroundStyle(.white)
            .padding()
            .scrollIndicators(.hidden)
        }
    }
}


struct navBar: View {
    
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


struct songDetails: View {
    
    let album: AlbumModel
    @ObservedObject var playerViewModel: PlayerViewModel
    
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
                    playerViewModel.isLiked.toggle()
                } label: {
                    Image(systemName: playerViewModel.isLiked ? "heart.fill" : "heart")
                        .foregroundStyle(playerViewModel.isLiked ? .red : .white)
                        .font(.title)
                }
            }
        }
    }
}


struct playerControls: View {
    
    @ObservedObject var playerViewModel: PlayerViewModel
    
    var body: some View {
        VStack(spacing: 20){
            VStack(spacing: 8) {
                Slider(value: $playerViewModel.currentTime, in: 0...playerViewModel.duration, step: 1) {
                    Text(playerViewModel.formatTime(playerViewModel.currentTime))
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .tint(.purple)
                HStack{
                    Text(playerViewModel.formatTime(playerViewModel.currentTime))
                    Spacer()
                    Text("-\(playerViewModel.formatTime(playerViewModel.duration - playerViewModel.currentTime))")
                }
                .font(.caption)
                .foregroundStyle(.white)
            }
            HStack{
                Image(systemName: "shuffle")
                Spacer()
                Image(systemName: "backward.end.fill")
                Spacer()
                Button {
                    playerViewModel.isPlaying.toggle()
                } label: {
                    Image(systemName: playerViewModel.isPlaying ? "play.fill" : "pause.fill")
                        .background(
                            Circle()
                                .frame(width: 45, height: 45)
                                .foregroundStyle(.purple)
                        )
                }
                Spacer()
                Image(systemName: "forward.end.fill")
                Spacer()
                Image(systemName: "repeat")
            }
            .font(.title3)
        }
    }
}


struct lyricsSection: View {
    
    @ObservedObject var playerViewModel: PlayerViewModel
    
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
                        playerViewModel.showFullLyrics.toggle()
                    } label: {
                        Image(systemName: "arrow.down.left.and.arrow.up.right")
                    }
                }
                .font(.title3)
            }
            .padding()
            .foregroundStyle(.white)
            .fullScreenCover(isPresented: $playerViewModel.showFullLyrics) {
                fullLyrics(playerViewModel: playerViewModel)
            }
        }
    }
}

struct fullLyrics: View {
    
    @ObservedObject var playerViewModel: PlayerViewModel
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
