//
//  Rimer.swift
//  Domain
//
//  Created by root0 on 2022/10/19.
//

import Foundation

public struct Rimer: Identifiable, Hashable {
    
    public var id: UUID
    public var name: String
    public var totalTime: Double
    public var thumbnail_desc: String
    
    public init(name: String, totalTime: Double, thumbnail_desc: String) {
        self.id = UUID()
        self.name = name
        self.totalTime = totalTime
        self.thumbnail_desc = thumbnail_desc
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case totalTime
        case thumbnail_desc
    }
}

extension Rimer: Encodable, Decodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(totalTime, forKey: .totalTime)
        try container.encode(thumbnail_desc, forKey: .thumbnail_desc)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        totalTime = try container.decode(Double.self, forKey: .totalTime)
        thumbnail_desc = try container.decode(String.self, forKey: .thumbnail_desc)
    }
    
}
