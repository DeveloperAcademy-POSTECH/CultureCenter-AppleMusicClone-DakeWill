//
//  AlbumDetailView.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/10.
//

import SwiftUI
import MusicKit

struct AlbumDetailView: View {
    @ObservedObject var albumDetailViewModel = AlbumDetailViewModel()
    var album: Album
    var body: some View {
        AlbumDetailTrackListView(albumDetailViewModel: albumDetailViewModel, album: album)
            .task {
                albumDetailViewModel.fetchAlbumTrack(album: album)
            }
    }
}
