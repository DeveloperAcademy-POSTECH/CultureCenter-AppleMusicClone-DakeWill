//
//  SearchListViewModel.swift
//  AppleMusicClone
//
//  Created by 최동권 on 2022/07/08.
//

import Foundation
import MusicKit

class SearchListViewModel: ObservableObject {
    @Published var recentlySearched: [Album]?
    
    init() {
        self.recentlySearched = UserDefaults.standard.object(forKey: "recentlySearched") as? [Album]
    }
    
    func storeRecentlySearched(album: Album) {
        if self.recentlySearched == nil {
            UserDefaults.standard.set([album], forKey: "recentlySearched")
        } else {
            self.recentlySearched?.append(album)
            UserDefaults.standard.set(self.recentlySearched, forKey: "recentlySearched")
        }

    }
}
