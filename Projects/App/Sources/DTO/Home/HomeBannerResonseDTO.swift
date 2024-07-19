//
//  HomeBannerResonseDTO.swift
//  App
//
//  Created by 박서연 on 2024/07/19.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct HomeBannerResonseDTO: Decodable {
    var id: Int?
    var image: String?
    var url: String?
    var externalYn: Bool?
}
