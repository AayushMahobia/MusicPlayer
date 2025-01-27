//
//  HomeView.swift
//  MusicApp
//
//  Created by Admin on 20/01/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
    
    @StateObject var homeViewModel: HomeViewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(
                alignment: homeViewModel.isLoading ? .center : .leading,
                spacing: 35
            ){
                navBar
                if homeViewModel.isLoading{
                    Spacer()
                    ProgressView()
                    Spacer()
                }else{
                    ScrollView{
                        VStack(alignment: .leading, spacing: 25){
                            topArtistSection
                            newAlbumSection
                            recentlyPlayedSection
                            
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
            }
            .padding(.horizontal)
            .onAppear{
                homeViewModel.getAllArtistData()
            }
            .navigationDestination(for: ArtistModel.self) { artistModel in
                ArtistDetailsView(artistModel: artistModel)
            }
        }
    }
    
    var navBar: some View {
        HStack(spacing: 0){
            HStack(spacing: 4) {
                Image(systemName: "headphones")
                    .foregroundStyle(.purple)
                Text("Luister")
                    .fontWeight(.semibold)
            }
            
            Spacer()
            HStack (spacing: 8){
                Image(systemName: "bell.circle")
                WebImage(url: URL(string: "https://images.pexels.com/photos/839011/pexels-photo-839011.jpeg?auto=compress&cs=tinysrgb&w=800"))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())

            }
                    }
        .font(.title)
    }
    
    var topArtistSection: some View {
        VStack(alignment: .leading, spacing: 18){
            Text(homeViewModel.allArtistData?.headerTitle ?? "")
                .font(.title)
                .fontWeight(.medium)
            ScrollView(.horizontal){
                HStack{
                    if let content = homeViewModel.allArtistData?.artists{
                        ForEach(content) { artist in
                            NavigationLink(value: artist) {
                                VStack{
                                    WebImage(url: URL(string: artist.artistThumbnail))
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 81, height: 81)
                                        .clipShape(Circle())
                                    Text(artist.artistName)
                                        .foregroundStyle(.secondary)
                                        .font(.caption)
                                        .tint(.secondary)
                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    var newAlbumSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("New Album")
                .font(.title)
                .fontWeight(.medium)
            ZStack(alignment: .bottom){
                WebImage(url: URL(string: "https://images.pexels.com/photos/1652353/pexels-photo-1652353.jpeg?auto=compress&cs=tinysrgb&w=800"))
                    .resizable()
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                
                HStack{
                    VStack(alignment: .leading, spacing: 10){
                        Text("Listen to the best music today")
                        Text("12.00-14.00 WIB")
                            .font(.caption)
                    }
                    .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "play.circle.fill")
                        .foregroundStyle(.white)
                        .font(.title)
                }
                .padding(30)
            }
        }
    }
    
    
    @State var selectedAlbum: AlbumModel?
    
    var recentlyPlayedSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Recently Played")
                .font(.title)
                .fontWeight(.medium)
            ScrollView(.horizontal){
                HStack(spacing: 15){
                    if let content = homeViewModel.allArtistData?.artists{
                        ForEach(content) { artist in
                            Button {
                                selectedAlbum = artist.albums[0]
                            } label: {
                                VStack(alignment: .leading){
                                    ZStack {
                                        WebImage(url: URL(string: artist.artistThumbnail))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 120, height: 120)
                                            .clipShape(RoundedRectangle(cornerRadius: 20))
                                        Image(systemName: "play.circle.fill")
                                            .foregroundStyle(.white)
                                            .font(.title2)
                                    }
                                    Text(artist.albums[0].songs[0].prefix(12))
                                    Text(artist.artistName)
                                        .foregroundStyle(.secondary)
                                        .font(.caption)
                                }
                            }
                            .tint(.primary)
                        }
                        .fullScreenCover(item: $selectedAlbum) { album in
                            PlayerView(album: album)
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
}

#Preview {
    HomeView()
}
