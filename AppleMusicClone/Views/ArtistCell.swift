//
//  ArtistCell.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/02.
//

import SwiftUI
import MusicKit

struct ArtistCell: View {
    var album: MusicItemCollection<Album>.Element
    
    var body: some View {
        VStack {
            HStack {
                if let artwork = album.artwork {
                    ArtworkImage(artwork, width: 50)
                        .cornerRadius(5)
                } else {
                    Image(systemName: "square.stack")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text(album.title)
                        .lineLimit(1)
                        .font(.callout)
                        .foregroundColor(.primary)
                    Text("앨범 · \(album.artistName)")
                        .lineLimit(1)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
        }
        .padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
    }
}
