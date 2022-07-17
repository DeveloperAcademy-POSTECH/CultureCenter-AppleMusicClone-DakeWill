//
//  FirebaseManager.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/13.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirebaseManager: NSObject {
    static let shared = FirebaseManager()
    let firestore: Firestore
    
    override init() {
        firestore = Firestore.firestore()
        super.init()
    }
    
    private var documentListener: ListenerRegistration?
    
    func save(_ message: Message, completion: ((Error?) -> Void)? = nil) {
        let collectionPath = "albums"
        let collectionListener = Firestore.firestore().collection(collectionPath)
        
        guard let dictionary = message.asDictionary else {
            print("decode error")
            return
        }
        collectionListener.addDocument(data: dictionary) { error in
            completion?(error)
        }
    }
}
