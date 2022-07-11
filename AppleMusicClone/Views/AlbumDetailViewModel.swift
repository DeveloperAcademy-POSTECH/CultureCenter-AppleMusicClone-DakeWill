//
//  AlbumDetailViewModel.swift
//  AppleMusicClone
//
//  Created by 최동권 on 2022/07/11.
//

import SwiftUI
import MusicKit

class AlbumDetailViewModel: ObservableObject {
    @Published var selectedAlbumTrack: MusicItemCollection<Track>?
    
    func fetchAlbumTrack(album: Album) {
        Task{
            let albumWithTrack = try await album.with([.tracks])
            self.selectedAlbumTrack = albumWithTrack.tracks
        }
    }
}

