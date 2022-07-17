//
//  AlbumDetailUpperView.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/10.
//

import SwiftUI
import MusicKit

struct AlbumDetailUpperView: View {
    @ObservedObject var albumDetailViewModel: AlbumDetailViewModel
    var album: Album
    let cornerRadius: CGFloat = 10
    let playButton: [[String]] = [["play.fill", "재생"], ["arrow.left.arrow.right", "임의재생"]]
    let descriptionInset = EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 25)
    let rectanglePlayButtonWidth = UIScreen.main.bounds.width * 0.5 - 30
    let rectanglePlayButtonHeight = (UIScreen.main.bounds.width * 0.5 - 30) * 0.33 - 10
    let stackSpacing: CGFloat = 5
    
    var body: some View {
        VStack(alignment: .center, spacing: stackSpacing) {
                if let artwork = album.artwork {
                    ArtworkImage(artwork, width: 250, height: 250)
                        .cornerRadius(cornerRadius)
                        .shadow(radius: cornerRadius * 0.5)
                }
            VStack(spacing: stackSpacing) {
                Text(album.title)
                    .font(.headline)
                    .bold()
                Text(album.artistName)
                    .foregroundColor(.accentColor)
            }
            .padding(descriptionInset)
            Text("\(album.genreNames.first ?? "") · \(returnYear(date: album.releaseDate ?? Date()))년")
                .font(.footnote)
                .foregroundColor(.secondary)
            HStack {
                ForEach(playButton, id: \.self){ button in
                    Button(action: {}, label: {
                        ZStack {
                            Rectangle()
                                .frame(width: rectanglePlayButtonWidth, height: rectanglePlayButtonHeight)
                                .cornerRadius(cornerRadius)
                                .foregroundColor(Color(.darkGray))
                                .opacity(0.4)
                            HStack {
                                Image(systemName: "\(button.first ?? "")")
                                    .foregroundColor(.accentColor)
                                Text(button.last ?? "")
                                    .foregroundColor(.accentColor)
                            }
                        }
                    })
                }
            }
            Button(action: {
//                if let trackArray = albumDetailViewModel.selectedAlbumTracks {
//                    for trackName in trackArray {
//                        tracks.append(trackName.title)
//                    }
//                }
//                FirebaseManager.shared.save(Message(id: album.title,
//                                                    content: album.title,
//                                                    track: MusicTrack(trackNumber: album.trackCount, trackNames: tracks), artwork: album.artwork!,
//                                                    artistName: album.artistName,
//                                                    genre: album.genreNames.first!))
            }, label: {
                Text("Save")
            })
        }
        .onAppear {
            
            }
        .toolbar(content: {
            ToolbarItemGroup(placement: .navigationBarTrailing, content: {
                Button(action: {}, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.accentColor)
                })
                Button(action: {}, label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.accentColor)
                })
            })
        })
    }
    
    private func returnYear(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let year = dateFormatter.string(from: date)
        return year
    }
}
