//
//  ReviewEntity.swift
//  App
//
//  Created by 박서연 on 2024/08/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ReviewEntity: Decodable, Hashable, Identifiable {
    var id = UUID().uuidString
    var name: String
    var brand: String
    var productId: Int
    var image: String
}
