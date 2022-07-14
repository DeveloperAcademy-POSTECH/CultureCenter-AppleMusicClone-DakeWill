//
//  encodableextension.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/07/14.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

extension Encodable {
    /// Object to Dictionary
    /// cf) Dictionary to Object: JSONDecoder().decode(Object.self, from: dictionary)
    var asDictionary: [String: Any]? {
        guard let object = try? JSONEncoder().encode(self),
              let dictinoary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String: Any] else { return nil }
        return dictinoary
    }
}
