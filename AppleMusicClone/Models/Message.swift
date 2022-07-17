//
//  Message.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/14.
//

import Foundation
import MusicKit

// Reference : https://ios-development.tistory.com/771
struct Message: Hashable, Codable {
    let id: String
    let content: String
    let sentDate: Date
    let track: MusicTrack
    let artwork: Artwork
    let artistName: String
    let genre: String
//    let releaseDate: Date
    
    init(id: String, content: String, track: MusicTrack, artwork: Artwork, artistName: String, genre: String) {
        self.id = id
        self.content = content
        self.sentDate = Date()
        self.track = track
        self.artwork = artwork
        self.artistName = artistName
        self.genre = genre
//        self.releaseDate = releaseDate
    }
    
    // MARK: - Date 형을 firestore에 입력하면 Unix Time Stamp형으로 변환하는 작업
    
    private enum CodingKeys: String, CodingKey {
        case id
        case content
        case sentDate
        case track
        case artwork
        case artistName
        case genre
//        case releaseDate
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        content = try values.decode(String.self, forKey: .content)
        artwork = try values.decode(Artwork.self, forKey: .artwork)
        artistName = try values.decode(String.self, forKey: .artistName)
        genre = try values.decode(String.self, forKey: .genre)
        
        let dataDouble = try values.decode(Double.self, forKey: .sentDate)
        sentDate = Date(timeIntervalSince1970: dataDouble)
        let trackArray = try values.decode(MusicTrack.self, forKey: .track)
        track = trackArray
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension Message: Comparable {
    // 같은값이 있는지 비교할때 사용
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.id == rhs.id
    }

    // sort 함수에서 사용
    static func < (lhs: Message, rhs: Message) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}

