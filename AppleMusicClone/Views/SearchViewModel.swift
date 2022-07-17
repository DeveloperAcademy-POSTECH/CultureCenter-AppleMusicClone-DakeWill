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
           // addSnapshotListener로 하면 detail뷰의 trackList가 사라지는 현상 발생..
            // getDocuments에서는 보임.. why?..
            guard let documents = querySnapshot?.documents else { return }
//            let albumList = documents.map { try? $0.data(as: CustomAlbum.self)}
                  for document in documents {
                      var element = try? document.data(as: Message.self)
                      self.recentlySearchedAlbum.append(element!)
                  }
            self.recentlySearchedAlbum.sort(by: {$0.sentDate > $1.sentDate })
            // set으로 중복을 제거 해주면 실시간으로 데이터를 가져오지 못하는 현상 발생..
            let set = Set(self.recentlySearchedAlbum)
            self.recentlySearchedAlbum = Array(set)
                  print("최근fetch완료")
        }
    }
}
