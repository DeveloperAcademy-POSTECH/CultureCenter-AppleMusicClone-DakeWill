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
    @Published var tracks: [String] = []
    func fetchAlbumTrack(album: Album) {
        Task {
            let albumWithTrack = try await album.with([.tracks])
            self.selectedAlbumTracks = albumWithTrack.tracks
            if let trackArray = self.selectedAlbumTracks {
                for trackName in trackArray {
                    tracks.append(trackName.title)
                }
                FirebaseManager.shared.save(Message(id: album.title,
                                                    content: album.title,
                                                    track: MusicTrack(trackNumber: album.trackCount, trackNames: tracks), artwork: album.artwork!,
                                                    artistName: album.artistName,
                                                    genre: album.genreNames.first!))
                print("저장되었습니다.")
            }
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

