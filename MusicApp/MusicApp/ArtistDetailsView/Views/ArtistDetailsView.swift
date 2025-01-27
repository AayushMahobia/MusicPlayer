//
//  ArtistDetails.swift
//  MusicApp
//
//  Created by Admin on 22/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct ArtistDetailsView: View {
    
    let artistModel: ArtistModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading, spacing: 20) {
                ArtistDetailsSection(artistModel: artistModel)
                NewReleaseSection(artistModel: artistModel)
                TopSongsSection(artistModel: artistModel)
            }
        }
        .ignoresSafeArea(edges: .top)
        .toolbar(.hidden, for: .tabBar)
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                }
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack(spacing: 3){
                    Image(systemName: "circle.fill")
                    Image(systemName: "circle.fill")
                    Image(systemName: "circle.fill")
                }
                .font(.system(size: 4))
                .foregroundStyle(.purple)
            }
        }
        .tint(.purple)
    }
}


struct ArtistDetailsSection: View {
    
    let artistModel: ArtistModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // background
            WebImage(url: URL(string: artistModel.artistThumbnail))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 400)
                .clipShape(Rectangle())
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black.opacity(0), colorScheme == .light ? .white : .black]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                )
            // foreground
            HStack(spacing: 20){
                VStack(alignment: .leading, spacing: 10){
                    HStack(spacing: 10) {
                        Text(artistModel.artistName)
                            .font(.title)
                            .fontWeight(.bold)
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(.purple)
                            .font(.title2)
                    }
                    Text(artistModel.artistDescription)
                        .foregroundStyle(.gray)
                }
                Spacer()
                VStack{
                    Text("# \(artistModel.artistRank)")
                        .font(.title2)
                    Text("in the world")
                        .font(.caption2)
                }
                .foregroundStyle(.white)
                .padding(9)
                .frame(width: 80, height: 80)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding(.horizontal)
        }
    }
}


struct NewReleaseSection: View {
    
    let artistModel: ArtistModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            Text("New Release")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.horizontal)
            ForEach(artistModel.albums) { album in
                AlbumCardView(album: album)
            }
        }
    }
}


struct TopSongsSection: View {
    
    let artistModel: ArtistModel
    @State var selectedAlbum: AlbumModel?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 17) {
            HStack {
                Text("Top Songs")
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
                Text("View All")
                    .foregroundStyle(.secondary)
            }
            .padding(.horizontal)
            ForEach(artistModel.albums.indices, id: \.self) { index in
                HStack(spacing: 15) {
                    Text("\(index+1)")
                        .font(.headline)
                        .padding(.leading, 20)
                    Button {
                        selectedAlbum = artistModel.albums[index]
                    } label: {
                        SongCardView(album: artistModel.albums[index])
                    }
                    .tint(.primary)
                }
            }
            .fullScreenCover(item: $selectedAlbum) { album in
                PlayerView(album: album)
            }
        }
    }
}


#Preview {
    let initialAlbumArijit = [
        AlbumModel(
            artistName: "Arijit Singh",
            albumName: "Arjit Album 1",
            albumThumbnail: "https://images.pexels.com/photos/1173648/pexels-photo-1173648.jpeg?auto=compress&cs=tinysrgb&w=800",
            dateReleased: "2021",
            songs: ["Apna Bana Le"]
        ),
        AlbumModel(
            artistName: "Arijit Singh",
            albumName: "Arjit Album 2",
            albumThumbnail: "https://images.pexels.com/photos/1181789/pexels-photo-1181789.jpeg?auto=compress&cs=tinysrgb&w=800",
            dateReleased: "2020",
            songs: ["Tujhe Kitna Chahne Lage"]
        ),
        AlbumModel(
            artistName: "Arijit Singh",
            albumName: "Arjit Album 3",
            albumThumbnail: "https://images.pexels.com/photos/5699509/pexels-photo-5699509.jpeg?auto=compress&cs=tinysrgb&w=800",
            dateReleased: "2019",
            songs: ["Tum Hi Ho"]
        )
    ]
    
    
    ArtistDetailsView(
        artistModel:
            ArtistModel(
                artistName: "Arijit Singh",
                artistThumbnail: "https://images.pexels.com/photos/6670752/pexels-photo-6670752.jpeg?auto=compress&cs=tinysrgb&w=800",
                artistDescription: "A description about Arjit Singh. He is a very good singer",
                artistRank: 1,
                albums: initialAlbumArijit
            )
    )
}
