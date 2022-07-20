//
//  CustomAlbum.swift
//  AppleMusicClone
//
//  Created by 최동권 on 2022/07/17.
//

import Foundation
import MusicKit

struct CustomAlbum: Codable {
    let id: String
    let content: String
    let sentDate: Date
    let track: MusicTrack
    let artwork: Artwork
    let artistName: String
    let genre: String
}
