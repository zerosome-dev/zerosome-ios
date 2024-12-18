//
//  OnlineStoreView.swift
//  App
//
//  Created by 박서연 on 2024/07/18.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct OfflineStoreView: View {
    let offlineStore: [OfflineStoreResult]
    private let columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                
                CommonTitle(title: "오프라인 판매처", type: .solo)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                offLineChipView(
                    totalHeight: 36,
                    verticalSpacing: 10,
                    horizontalSpacing: 10,
                    data: offlineStore
                )
            }
            .padding(.horizontal, 22)
        }
    }
}

struct OnlineStoreView: View {
    let onlineStore: [OnlineStoreResult]
    
    var body: some View {
        VStack {
            VStack(spacing: 16) {
                CommonTitle(title: "온라인 판매처", type: .solo)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVStack(spacing: 10) {
                    ForEach(onlineStore, id: \.storeCode) { store in
                        HStack {
                            ZSText(store.storeName, fontType: .body2, color: Color.neutral600)
                                .padding(.init(top: 10, leading: 16, bottom: 10, trailing: 0))
                                
                            Spacer()
                            
                            ZSText("바로가기", fontType: .body2, color: Color.neutral400)
                                .padding(.init(top: 10, leading: 0, bottom: 10, trailing: 16))
                                .onTapGesture {
                                    if let url = URL(string: store.url) {
                                        UIApplication.shared.open(url)
                                    }
                                }
                                .opacity(store.url.isEmpty ? 0 : 1)
                        }
                        .background(Color.neutral50)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
        }
        .padding(.horizontal, 22)
    }
}

#Preview {
    OnlineStoreView(onlineStore: [OnlineStoreResult(storeCode: "123", storeName: "쿠팡", url: "")])
//    OfflineStoreView(offlineStore: [OfflineStoreResult(storeCode: "1212", storeName: "판매처dkrdkrdk"),
//                                    OfflineStoreResult(storeCode: "232", storeName: "판매처"),
//                                    OfflineStoreResult(storeCode: "11", storeName: "쿠팡"),
//                                    OfflineStoreResult(storeCode: "44", storeName: "이마트254"),
//                                    OfflineStoreResult(storeCode: "2", storeName: "어쩌구어자어ㅣ")
//                                   ])
}
