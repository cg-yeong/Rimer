//
//  RimeEntity.swift
//  Data
//
//  Created by root0 on 2022/11/15.
//

import Foundation
import RealmSwift

class Rime: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var rimeId: UUID = UUID()
    @Persisted var name: String = ""
    @Persisted var totalTime: Double = 0.0
    @Persisted var thumbnail: String = ""
    
    convenience init(name: String, time: Double, thumbnail: String) {
        self.init()
        self.name = name
        self.totalTime = time
        self.thumbnail = thumbnail
    }
}
