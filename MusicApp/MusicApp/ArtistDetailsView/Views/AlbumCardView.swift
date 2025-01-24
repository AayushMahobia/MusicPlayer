//
//  AlbumCardView.swift
//  MusicApp
//
//  Created by Admin on 23/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct AlbumCardView: View {
    
    let album: AlbumModel
    
    var body: some View {
        HStack{
            HStack(spacing: 18){
                WebImage(url: URL(string: album.albumThumbnail))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                VStack(alignment: .leading, spacing: 10){
                    Text(album.albumName)
                    HStack{
                        Text("Album \(album.dateReleased)")
                        Image(systemName: "circle.fill")
                            .font(.system(size: 7))
                        Text("\(album.songs.count) Songs")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondary)
                }
            }
            Spacer()
            HStack(spacing: 3){
                Image(systemName: "circle.fill")
                Image(systemName: "circle.fill")
                Image(systemName: "circle.fill")
            }
            .font(.system(size: 4))
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
    AlbumCardView(album: album)
}
