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
                Image(systemName: "chevron.right")
            }
        }
        .padding(.init(top: 5, leading: 0, bottom: 5, trailing: 0))
//                .onTapGesture {
//                    /*
//                     Q) swiftui hide keyboard
//                     https://stackoverflow.com/questions/56491386/how-to-hide-keyboard-when-using-swiftui
//                     */
//                    let keyWindow = UIApplication.shared.connectedScenes
//                        .filter({$0.activationState == .foregroundActive})
//                        .map({$0 as? UIWindowScene})
//                        .compactMap({$0})
//                        .first?.windows
//                        .filter({$0.isKeyWindow}).first
//                    keyWindow?.endEditing(true)
//                }
    }
}
