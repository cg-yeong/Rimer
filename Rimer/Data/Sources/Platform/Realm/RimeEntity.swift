//
//  RimeEntity.swift
//  Data
//
//  Created by root0 on 2022/11/15.
//

import Foundation
import Realm
import RealmSwift

import Domain

//class Rime: Object {
//    @Persisted(primaryKey: true) var _id: ObjectId
//    @Persisted var rimeId: UUID = UUID()
//    @Persisted var name: String = ""
//    @Persisted var totalTime: Double = 0.0
//    @Persisted var thumbnail: String = ""
//    
//    convenience init(name: String, time: Double, thumbnail: String) {
//        self.init()
//        self.name = name
//        self.totalTime = time
//        self.thumbnail = thumbnail
//    }
//}
/**
 v10.10.0 : @Persisted 선언 스타일은 이전 SDK버전의 @objc dynamic, RealmOptional 및 RealmProperty 선언 표기법을 대체
        @Persisted - @objc dynamic 혼용: @objc 무시된다.
 */
final class RMRimer: Object {
    /// First Version
    @Persisted(primaryKey: true) var rimeId: UUID
    @Persisted var name: String = ""
    @Persisted var totalTime: Double = 0.0
    @Persisted var thumbnail: String = ""
}

extension RMRimer: DomainConvertibleType {
    func asDomain() -> Rimer {
        return Rimer(id: rimeId,
                     name: name,
                     totalTime: totalTime,
                     thumbnail_desc: thumbnail)
    }
}

extension Rimer: RealmRepresentable {
    var uid: UUID {
        return id
    }
    
    func asRealm() -> RMRimer {
        let object = RMRimer()
        object.rimeId = id
        object.name = name
        object.totalTime = totalTime
        object.thumbnail = thumbnail_desc
        return object
    }
}
