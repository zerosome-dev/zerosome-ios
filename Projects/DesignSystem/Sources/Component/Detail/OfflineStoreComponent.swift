//
//  OfflineStoreComponent.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/01.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

public struct OfflineStoreComponent: View {
//    public let columns: [GridItem] = Array(repeating: GridItem(.flexible(maximum: 69)), count: 4)
    public let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    public let offlineStore: [String] // = ["판매처1", "판매처2", "판매처3", "판매처4", "판매처5", "판매처6"]
    
    public init(offlineStore: [String]) {
        self.offlineStore = offlineStore
    }
    
    public var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            
            ForEach(offlineStore, id: \.self) { value in
                Text(value)
                    .applyFont(font: .body2)
                    .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .foregroundStyle(Color.neutral600)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.neutral100)
                    }
            }
        }
    }
}

#Preview {
    OfflineStoreComponent(offlineStore: ["판매처1", "판매처2", "판매처3", "판매처4", "판매처5", "판매처6"])
}
