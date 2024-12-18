//
//  CategoryProtocol.swift
//  App
//
//  Created by 박서연 on 2024/08/28.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation

protocol ChipRepresentable: Equatable, Identifiable {
    var name: String { get }
    var code: String { get }
}

struct TappedChips: ChipRepresentable {
    var name: String
    var code: String
    
    var id: String {
        return code
    }
}
