//
//  Common.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import Foundation
import SwiftUI

struct Size {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

extension View {
    func screenWidth() -> UIScreen? {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return self.screenWidth()
        }
        
        return window.screen
    }
}
