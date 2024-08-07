//
//  OnlineStoreView.swift
//  App
//
//  Created by 박서연 on 2024/07/18.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct OnlineStoreView: View {
    let onlineStore: [OnlineStoreDTO]
    
    var body: some View {
        VStack {
            CommonTitle(title: "온라인 판매처", type: .solo)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            LazyVStack(spacing: 10) {
                ForEach(onlineStore, id: \.storeCode) { store in
                    HStack {
                        ZSText(store.storeName ?? "", fontType: .body2, color: Color.neutral600)
                            .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 0))
                            
                        Spacer()
                        
                        ZSText("바로가기", fontType: .body2, color: Color.neutral400)
                            .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 16))
                            .onTapGesture {
                                print("온라인 판매처 바로가기")
                            }
                    }
                    .background(Color.neutral50)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .padding(.horizontal, 22)
    }
}

struct OffLineStoreView: View {
    let offlineStore: [OfflineStoreDTO]
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        CommonTitle(title: "오프라인 판매처", type: .solo)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 22)
        
        LazyVGrid(columns: columns, spacing: 10) {
            
            ForEach(offlineStore, id: \.storeCode) { value in
                Text(value.storeName ?? "")
                    .applyFont(font: .body2)
                    .padding(.init(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .foregroundStyle(Color.neutral600)
                    .overlay {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.neutral100)
                    }
            }
        }
        .padding(.init(top: 0, leading: 22, bottom: 0, trailing: 47))
    }
}

#Preview {
    OnlineStoreView(onlineStore: [OnlineStoreDTO(storeCode: "123", storeName: "쿠팡", url: "dd")])
}
