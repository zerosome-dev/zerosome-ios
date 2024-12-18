//
//  ReviewModifyRequest.swift
//  App
//
//  Created by 박서연 on 2024/09/10.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ReviewModifyRequest: Encodable {
    var contents: String?
    var modifyContents: Bool
    var rating: Double
}
