//
//  HomeRolloutResult.swift
//  App
//
//  Created by 박서연 on 2024/08/24.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct HomeRolloutResult: Equatable, Hashable, Identifiable {
    let id: Int
    let image: String
    let d1Category: String
    let d2Category: String
    let name: String
    let salesStore: [String]
    
    init(
        id: Int,
        image: String,
        d1Category: String,
        d2Category: String,
        name: String,
        salesStore: [String]
    ) {
        self.id = id
        self.image = image
        self.d1Category = d1Category
        self.d2Category = d2Category
        self.name = name
        self.salesStore = salesStore
    }
}
