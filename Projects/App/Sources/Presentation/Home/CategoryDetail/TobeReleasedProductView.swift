//
//  HomeCategoryDetailView.swift
//  App
//
//  Created by 박서연 on 2024/07/11.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Kingfisher

struct TobeReleasedProductView: View {
    
    @EnvironmentObject var router: Router
    private let columns: [GridItem] = Array(repeating: .init(.flexible(), spacing: 11, alignment: .center), count: 2)
    let title: String
    let subTitle: String
    let data: [HomeRolloutResult]
    let photoWidth = (UIScreen.main.bounds.width - 66) / 2
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                VStack(spacing: 2) {
                    ZSText(title, fontType: .heading1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ZSText(subTitle, fontType: .body2, color: Color.neutral500)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.key) { data in
                        VStack(alignment: .leading, spacing: 8) {
                            KFImage(URL(string: data.image))
                                .resizable()
                                .frame(width: photoWidth, height: photoWidth)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            /*
                             회색 배경 추가
                             Rectangle()
                                 .fill(Color.neutral50)
                                 .frame(width: photoWidth, height: photoWidth)
                                 .overlay {
                                     KFImage(URL(string: data.image))
                                         .placeholder {
                                             ProgressView()
                                                 .tint(Color.primaryFF6972)
                                         }
                                         .resizable()
                                         .frame(width: photoWidth, height: photoWidth)
                                         .aspectRatio(contentMode: .fit)
                                 }
                                 .clipShape(RoundedRectangle(cornerRadius: 10))
                             */

                            VStack(alignment: .leading, spacing: 4) {
                                ZSText(data.brand, fontType: .body3, color: Color.neutral500)
                                    .lineLimit(1)
                                
                                ZSText(data.name, fontType: .subtitle2, color: Color.neutral900)
                                    .lineLimit(2)
                                    .padding(.bottom, 4)
                                
                                HStack {
                                    ForEach(data.salesStore, id: \.self) { platform in
                                        ZSText(platform, fontType: .label2, color: Color.neutral700)
                                            .padding(.init(top: 3,leading: 6,bottom: 3,trailing: 6))
                                            .background(Color.neutral50)
                                            .clipShape(RoundedRectangle(cornerRadius: 4))
                                    }
                                }
                                
                                Spacer()
                            }
                            .onTapGesture {
                                router.navigateTo(.detailMainView(data.id, title))
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 22)
        }
        .scrollIndicators(.hidden)
        .ZSnavigationBackButton {
            router.navigateBack()
        }
    }
}

#Preview {
    TobeReleasedProductView(title: "출시 예정 신상품", subTitle: "새롭게 발매된 어쩌구", data: [])
}
