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
    let firestore: Firestore
    
    static let shared = FirebaseManager()
    
    override init() {
        firestore = Firestore.firestore()
        super.init()
    }
}
