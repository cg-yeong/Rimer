//
//  RimerListItemModel.swift
//  Presentation
//
//  Created by root0 on 2022/12/06.
//

import Foundation
import Domain

struct RimerItemViewModel {
    let name: String
    let time: Double
    let imagePath: String
    let rimer: Rimer
    
    init(with rimer: Rimer) {
        self.rimer = rimer
        self.name = rimer.name
        self.time = rimer.totalTime
        self.imagePath = rimer.thumbnail_desc
    }
}