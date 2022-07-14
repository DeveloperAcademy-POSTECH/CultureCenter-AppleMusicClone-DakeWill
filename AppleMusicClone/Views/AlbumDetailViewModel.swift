//
//  AlbumDetailViewModel.swift
//  AppleMusicClone
//
//  Created by 최동권 on 2022/07/11.
//

import SwiftUI
import MusicKit

class AlbumDetailViewModel: ObservableObject {
    @Published var selectedAlbumTracks: MusicItemCollection<Track>?
    
    func fetchAlbumTrack(album: Album) {
        Task {
            let albumWithTrack = try await album.with([.tracks])
            self.selectedAlbumTracks = albumWithTrack.tracks
        }
    }
    
    func unwrapTrack(album: Album) -> MusicItemCollection<Track> {
        guard let albumTracks = self.selectedAlbumTracks else { return MusicItemCollection<Track>()}
        return albumTracks
    }
    
    func unwrapTrackNumber(track: Track) -> Int {
        guard let trackNumber = track.trackNumber else { return 0 }
        return trackNumber
    }
    
}

