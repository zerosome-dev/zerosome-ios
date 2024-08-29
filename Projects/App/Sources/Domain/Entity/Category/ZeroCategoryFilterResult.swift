//
//  ZeroCategoryFilterResult.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

struct ZeroCategoryFilterResult: ChipRepresentable, Identifiable {
    var zeroCtgCode: String
    var zeroCtgName: String
    
    var id: String {
        return zeroCtgCode
    }
    
    var name: String {
        return zeroCtgName
    }
    
    var code: String {
        return zeroCtgCode
    }
}
