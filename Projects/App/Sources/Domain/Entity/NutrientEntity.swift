//
//  NutrientEntity.swift
//  App
//
//  Created by 박서연 on 2024/08/09.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct NutrientEntity: Decodable, Hashable, Identifiable {
    var id = UUID().uuidString
    
    var nutrientName: String
    var servings: Double
    var amount: Double
    var servingsStandard: String
    var amountStandard: String
}
