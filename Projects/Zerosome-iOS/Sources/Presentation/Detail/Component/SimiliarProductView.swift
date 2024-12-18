//
//  SimiliarProductView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct SimiliarProductView: View {
    @ObservedObject var viewModel: DetailMainViewModel
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack(spacing: 16) {
            CommonTitle(title: "이 상품과 비슷한 상품이에요", type: .solo)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal) {
                if viewModel.similarList.count < 10 {
                    HStack {
                        ForEach(viewModel.similarList, id: \.productId) { data in
                            ProductPreviewComponent(data: data)
                                .tap {
                                    router.navigateTo(.detailMainView(data.productId, viewModel.navigationTitle))
                                }
                                .frame(maxWidth: 150)
                        }
                    }
                } else {
                    HStack {
                        ForEach(viewModel.similarList.prefix(10), id: \.productId) { data in
                            ProductPreviewComponent(data: data)
                                .tap {
                                    router.navigateTo(.detailMainView(data.productId, viewModel.navigationTitle))
                                }
                                .frame(maxWidth: 150)
                        }
                    }
                }
                
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal, 22)
    }
}

