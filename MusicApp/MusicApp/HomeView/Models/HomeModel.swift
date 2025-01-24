//
//  HeaderModel.swift
//  MusicApp
//
//  Created by Admin on 21/01/25.
//

import Foundation

struct AllArtistModel {
    let headerTitle: String
    let artists: [ArtistModel]
}

struct ArtistModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let artistName: String
    let artistThumbnail: String
    let artistDescription: String
    let artistRank: Int
    let albums: [AlbumModel]
}

struct AlbumModel: Identifiable, Hashable {
    let id: String = UUID().uuidString
    let artistName: String
    let albumName: String
    let albumThumbnail: String
    let dateReleased: String
    let songs: [String]
}

//struct HeaderModel {
//    let headerTitle: String
//    let content: [HeaderContentModel]
//}
//
//struct HeaderContentModel: Identifiable, Hashable {
//    let id: String = UUID().uuidString
//    let artistThumbnail: String
//    let artistName: String
//    let songs: [String]
//}
