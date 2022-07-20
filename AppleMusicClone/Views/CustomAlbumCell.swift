//
//  CustomAlbumCell.swift
//  AppleMusicClone
//
//  Created by 최동권 on 2022/07/17.
//

import SwiftUI
import MusicKit

struct CustomAlbumCell: View {
    var album: Message
    
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
                    Text(album.content)
                        .lineLimit(1)
                        .font(.callout)
                        .foregroundColor(.primary)
                    Text("앨범 · \(album.artistName)")
                        .lineLimit(1)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "chevron.right")
            }
        }
        .padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
    }
}

