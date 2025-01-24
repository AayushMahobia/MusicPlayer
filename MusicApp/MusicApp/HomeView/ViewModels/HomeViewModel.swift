//
//  HomeViewModel.swift
//  MusicApp
//
//  Created by Admin on 21/01/25.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    var albumsData: [AlbumModel] = []
    var artistsData: [ArtistModel] = []
    var allArtistData: AllArtistModel?
    
    func getAllArtistData(){
        isLoading = true
        
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
        
        let initialAlbumMohit = [
            AlbumModel(
                artistName: "Mohit Chouhan",
                albumName: "Mohit Album 1",
                albumThumbnail: "https://images.pexels.com/photos/1173648/pexels-photo-1173648.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2021",
                songs: ["Tum Se Hi"]
            ),
            AlbumModel(
                artistName: "Mohit Chouhan",
                albumName: "Mohit Album 2",
                albumThumbnail: "https://images.pexels.com/photos/1181789/pexels-photo-1181789.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2020",
                songs: ["Kun Faya Kun"]
            ),
            AlbumModel(
                artistName: "Mohit Chouhan",
                albumName: "Mohit Album 3",
                albumThumbnail: "https://images.pexels.com/photos/5699509/pexels-photo-5699509.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2019",
                songs: ["Tum Ho"]
            )
        ]
        
        let initialAlbumAtif = [
            AlbumModel(
                artistName: "Atif Aslam",
                albumName: "Atif Album 1",
                albumThumbnail: "https://images.pexels.com/photos/1173648/pexels-photo-1173648.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2021",
                songs: ["Aadat"]
            ),
            AlbumModel(
                artistName: "Atif Aslam",
                albumName: "Atif Album 2",
                albumThumbnail: "https://images.pexels.com/photos/1181789/pexels-photo-1181789.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2020",
                songs: ["Tera Hone Laga hun"]
            ),
            AlbumModel(
                artistName: "Atif Aslam",
                albumName: "Atif Album 3",
                albumThumbnail: "https://images.pexels.com/photos/5699509/pexels-photo-5699509.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2019",
                songs: ["Tu Jaane Na"]
            )
        ]
        
        let initialAlbumArmaan = [
            AlbumModel(
                artistName: "Armaan Malik",
                albumName: "Armaan Album 1",
                albumThumbnail: "https://images.pexels.com/photos/1173648/pexels-photo-1173648.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2021",
                songs: ["Ghar Se Nikalte Hi"]
            ),
            AlbumModel(
                artistName: "Armaan Malik",
                albumName: "Armaan Album 2",
                albumThumbnail: "https://images.pexels.com/photos/1181789/pexels-photo-1181789.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2020",
                songs: ["Bas Itna Hai Tumse Kehna"]
            ),
            AlbumModel(
                artistName: "Armaan Malik",
                albumName: "Armaan Album 3",
                albumThumbnail: "https://images.pexels.com/photos/5699509/pexels-photo-5699509.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2019",
                songs: ["Besabriyaan"]
            )
        ]
        
        let initialAlbumJagjit = [
            AlbumModel(
                artistName: "Jagjit Singh",
                albumName: "Jagjit Album 1",
                albumThumbnail: "https://images.pexels.com/photos/1173648/pexels-photo-1173648.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2021",
                songs: ["US MOD SE SHURU KAREN"]
            ),
            AlbumModel(
                artistName: "Jagjit Singh",
                albumName: "Jagjit Album 2",
                albumThumbnail: "https://images.pexels.com/photos/1181789/pexels-photo-1181789.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2020",
                songs: ["Mera Geet Amar Kar Do"]
            ),
            AlbumModel(
                artistName: "Jagjit Singh",
                albumName: "Jagjit Album 3",
                albumThumbnail: "https://images.pexels.com/photos/5699509/pexels-photo-5699509.jpeg?auto=compress&cs=tinysrgb&w=800",
                dateReleased: "2019",
                songs: ["Hoshwalon ko Khabar Kya"]
            )
        ]
        
        let initialArtistsData = [
            ArtistModel(
                artistName: "Arijit Singh",
                artistThumbnail: "https://images.pexels.com/photos/6670752/pexels-photo-6670752.jpeg?auto=compress&cs=tinysrgb&w=800",
                artistDescription: "A description about Arjit Singh. He is amazing.",
                artistRank: 1,
                albums: initialAlbumArijit
            ),
            ArtistModel(
                artistName: "Mohit Chouhan",
                artistThumbnail: "https://images.pexels.com/photos/5542716/pexels-photo-5542716.jpeg?auto=compress&cs=tinysrgb&w=800",
                artistDescription: "A description about Mohit Chouhan. He is amazing.",
                artistRank: 2,
                albums: initialAlbumMohit
            ),
            ArtistModel(
                artistName: "Atif Aslam",
                artistThumbnail: "https://images.pexels.com/photos/555345/pexels-photo-555345.jpeg?auto=compress&cs=tinysrgb&w=800",
                artistDescription: "A description about Atif Aslam. He is amazing.",
                artistRank: 3,
                albums: initialAlbumAtif
            ),
            ArtistModel(
                artistName: "Armaan Malik",
                artistThumbnail: "https://images.pexels.com/photos/325688/pexels-photo-325688.jpeg?auto=compress&cs=tinysrgb&w=800",
                artistDescription: "A description about Armaan Malik. He is amazing.",
                artistRank: 4,
                albums: initialAlbumArmaan
            ),
            ArtistModel(
                artistName: "Jagjit Singh",
                artistThumbnail: "https://images.pexels.com/photos/1545342/pexels-photo-1545342.jpeg?auto=compress&cs=tinysrgb&w=800",
                artistDescription: "A description about Jagjit Singh. He is amazing.",
                artistRank: 5,
                albums: initialAlbumJagjit
            )
        ]
        
        artistsData.append(contentsOf: initialArtistsData)
        
        self.allArtistData = AllArtistModel(headerTitle: "Top Artist", artists: initialArtistsData)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
        }
    }
}

//class HomeViewModel: ObservableObject {
//
//    @Published var isLoading: Bool = false
//    var headerContentData: [HeaderContentModel] = []
//    var headerData: HeaderModel?
//
//    func getHeaderContentData(){
//        isLoading = true
//        let initialContent = [
//            HeaderContentModel(
//                artistThumbnail: "https://images.pexels.com/photos/6670752/pexels-photo-6670752.jpeg?auto=compress&cs=tinysrgb&w=800",
//                artistName: "Arijit Singh",
//                songs: ["Apna Bana Le", "Tujhe Kitna Chahne Lage"]
//            ),
//            HeaderContentModel(
//                artistThumbnail: "https://images.pexels.com/photos/1835656/pexels-photo-1835656.jpeg?auto=compress&cs=tinysrgb&w=800",
//                artistName: "Mohit Chouhan",
//                songs: ["Tum Se Hi", "Kun Faya Kun"]
//            ),
//            HeaderContentModel(
//                artistThumbnail: "https://images.pexels.com/photos/6173807/pexels-photo-6173807.jpeg?auto=compress&cs=tinysrgb&w=800",
//                artistName: "Atif Aslam",
//                songs: ["Aadat", "Tera Hone Laga hun"]
//            ),
//            HeaderContentModel(
//                artistThumbnail: "https://images.pexels.com/photos/325688/pexels-photo-325688.jpeg?auto=compress&cs=tinysrgb&w=800",
//                artistName: "Armaan Malik",
//                songs: ["Ghar Se Nikalte Hi", "Bas Itna Hai Tumse Kehna"]
//            ),
//            HeaderContentModel(
//                artistThumbnail: "https://images.pexels.com/photos/2167384/pexels-photo-2167384.jpeg?auto=compress&cs=tinysrgb&w=800",
//                artistName: "Jagjit Singh",
//                songs: ["US MOD SE SHURU KAREN", "Mera Geet Amar Kar Do"]
//            )
//        ]
//
//        headerContentData.append(contentsOf: initialContent)
//
//        self.headerData = HeaderModel(headerTitle: "Top Artist", content: initialContent)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.isLoading = false
//        }
//    }
//}
