//
//  AlbumDetailTrackListView.swift
//  AppleMusicClone
//
//  Created by 최동권 on 2022/07/11.
//

import SwiftUI
import MusicKit

struct AlbumDetailTrackListView: View {
    
    @ObservedObject var albumDetailViewModel = AlbumDetailViewModel()
    var album: Album
    
    var body: some View {
        List {
            if let selectedAlbumTrack = albumDetailViewModel.selectedAlbumTrack {
                ForEach(selectedAlbumTrack) { track in
                    HStack(spacing:10) {
                        if let trackNumber = track.trackNumber {
                            Text("\(trackNumber)")
                        }
                        Text(track.title)
                    }
                    .swipeActions(content: {
                        Button {
                            
                        } label: {
                            Image(systemName: "plus")
                        }
                    })
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            albumDetailViewModel.fetchAlbumTrack(album: album)
        }
    }
}
