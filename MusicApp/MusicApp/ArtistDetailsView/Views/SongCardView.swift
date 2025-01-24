//
//  SongCardView.swift
//  MusicApp
//
//  Created by Admin on 23/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SongCardView: View {
    
    let album: AlbumModel
    
    var body: some View {
        HStack{
            HStack(spacing: 18){
                WebImage(url: URL(string: album.albumThumbnail))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                VStack(alignment: .leading, spacing: 10){
                    Text(album.songs[0].prefix(17))
                    HStack{
                        Text("\(album.artistName)")
                        Image(systemName: "circle.fill")
                            .font(.system(size: 7))
                        Text("\(album.albumName)")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            Spacer()
            Image(systemName: "play.circle")
                .font(.title2)
            .padding(.trailing, 10)
        }
        .padding(.horizontal)
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
    SongCardView(album: album)
}
