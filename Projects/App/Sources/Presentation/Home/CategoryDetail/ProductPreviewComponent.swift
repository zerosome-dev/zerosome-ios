//
//  NowHotView.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem
import Kingfisher

struct ProductPreviewComponent<T: Decodable>: View {
    var action: (() -> Void)?
    let data: T
    
    init (
        action: (() -> Void)? = nil,
        data: T
    ) {
        self.action = action
        self.data = data
    }
    
    var body: some View {
        Group {
            if let data = data as? HomeRolloutResponseDTO {
                infoView(
                    image: data.image ?? "",
                    name: data.name ?? "",
                    brand: data.d2Category ?? "",
                    star: 0,
                    reviewCnt: 0
                )
            } else if let data = data as? HomeCafeResponseDTO {
                infoView(
                    image: data.image ?? "",
                    name: data.name ?? "",
                    brand: data.brand ?? "",
                    star: data.review ?? 0,
                    reviewCnt: data.reviewCnt ?? 0
                )
            } else if let data = data as? SimilarProductDTO {
                infoView(
                    image: data.image ?? "",
                    name: data.productName ?? "",
                    brand: "",
                    star: Int(round(data.rating ?? 0.0)),
                    reviewCnt: data.reviewCnt ?? 0
                )
            }
        }
        .onTapGesture {
            action?()
        }
        .onAppear {
            
        }
    }
    
    @ViewBuilder
    func infoView(image: String, name: String, brand: String, star: Int, reviewCnt: Int) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            KFImage(URL(string: image))
                .placeholder {
                    ProgressView()
                        .tint(Color.primaryFF6972)
                }
                .resizable()
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 4) {
                ZSText(name, fontType: .body3, color: Color.neutral500)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(1)
                
                ZSText(brand, fontType: .subtitle2, color: Color.neutral900)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                
                HStack(spacing: 2) {
                    ZerosomeAsset.ic_star_fill
                        .resizable()
                        .frame(width: 16, height: 16)
                    Text("\(star)")
                    Text("(\(reviewCnt))")
                }
                .applyFont(font: .body3)
                .foregroundStyle(Color.neutral400)
            }
        }
    }
}

extension ProductPreviewComponent {
    func tap(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}
