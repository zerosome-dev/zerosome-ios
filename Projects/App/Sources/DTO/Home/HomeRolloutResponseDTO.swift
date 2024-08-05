//
//  HomeRolloutResponseDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct HomeRolloutResponseDTO: Decodable {
    var id: Int?
    var image: String?
    var d1Category: String?
    var d2Category: String?
    var name: String?
    var salesStore: [String?]?
}
