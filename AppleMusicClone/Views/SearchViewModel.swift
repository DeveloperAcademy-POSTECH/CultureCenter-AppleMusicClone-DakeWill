//
//  SearchListViewModel.swift
//  AppleMusicClone
//
//  Created by 최동권 on 2022/07/08.
//

import Foundation
import MusicKit

class SearchViewModel: ObservableObject {
    @Published var recentlySearched: [Album]?
    @Published var recentlySearchedAlbum: [Message] = []
  
    func fetchRecentlySearchedList() {
        let collectionPath = "albums"
        FirebaseManager.shared.firestore.collection(collectionPath).getDocuments { querySnapshot, err in
            guard let documents = querySnapshot?.documents else { return }
                  for document in documents {
                      guard let element = try? document.data(as: Message.self) else { return }
                      self.recentlySearchedAlbum.append(element)
                  }
            let set = Set(self.recentlySearchedAlbum).sorted(by: {$0.sentDate > $1.sentDate})
            self.recentlySearchedAlbum = Array(set)
                  print("최근fetch완료")
        }
    }
}
