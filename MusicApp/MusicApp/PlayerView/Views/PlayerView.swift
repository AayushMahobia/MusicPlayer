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
                    HStack{
                        Image(systemName: "chevron.down")
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
                    VStack {
                        WebImage(url: URL(string: album.albumThumbnail))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 380)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            .foregroundStyle(.white)
            .padding()
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
