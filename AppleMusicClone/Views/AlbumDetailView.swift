//
//  AlbumDetailView.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/10.
//

import SwiftUI
import MusicKit

struct AlbumDetailView: View {
    var album: Album
    
    var body: some View {
        Text(album.title)
    }
}
