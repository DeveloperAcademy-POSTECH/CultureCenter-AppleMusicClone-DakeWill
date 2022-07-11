//
//  AlbumDetailUpperView.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/10.
//

import SwiftUI
import MusicKit

struct AlbumDetailUpperView: View {
    var album: Album
    let playButton: [Int: [String]] = [0: ["play.fill", "음악"], 1: ["arrow.left.arrow.right", "임의재생"]]
    let albumWidth = UIScreen.main.bounds.width / 2 - 30
    let albumHeight = (UIScreen.main.bounds.width / 2 - 30) / 3 - 10
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            ZStack {
                Rectangle()
                    .frame(width: 250, height: 250)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                ArtworkImage(album.artwork!, width: 250, height: 250)
                    .cornerRadius(10)
            }
            VStack(spacing: 5) {
                Text(album.title)
                    .font(.headline)
                    .bold()
                Text(album.artistName)
                    .foregroundColor(.accentColor)
            }
            .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25))
            Text("\(album.genreNames.first ?? "") · \(returnYear(date: album.releaseDate ?? Date()))년")
                .font(.footnote)
                .foregroundColor(.secondary)
            HStack {
                ForEach(playButton.sorted { $0.key < $1.key }, id: \.key){ button in
                    Button(action: {}, label: {
                        ZStack {
                            Rectangle()
                                .frame(width: albumWidth, height: albumHeight)
                                .cornerRadius(10)
                                .foregroundColor(Color(.darkGray))
                                .opacity(0.4)
                            HStack {
                                Image(systemName: "\(button.value.first ?? "")")
                                Text(button.value.last ?? "")
                            }
                        }
                    })
                }
            }
        }
        .toolbar(content: {
            HStack {
                Button(action: {}, label: {
                    Image(systemName: "arrow.down.circle")
                })
                Button(action: {}, label: {
                    Image(systemName: "ellipsis.circle")
                })
            }
        })
    }
    
    private func returnYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        return year
    }
}
