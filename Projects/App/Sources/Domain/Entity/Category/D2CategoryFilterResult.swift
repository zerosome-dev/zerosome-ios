//
//  D2CategoryFilterResult.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct D2CategoryFilterResult: ChipRepresentable, Identifiable {
    var d2CategoryCode: String
    var d2CategoryName: String
    var noOptionYn: Bool
    
    var id: String {
        return d2CategoryCode
    }
    
    var name: String {
        return d2CategoryName
    }
    
    var code: String {
        return d2CategoryCode
    }
}
