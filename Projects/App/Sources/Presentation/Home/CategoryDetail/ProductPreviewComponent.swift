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

struct ProductPreviewComponent: View {
    var action: (() -> Void)?
    let data: HScrollProductType
    
    init (
        action: (() -> Void)? = nil,
        data: HScrollProductType
    ) {
        self.action = action
        self.data = data
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Rectangle()
                .fill(Color.neutral50)
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                switch data {
                case .tobeReleased(let tobeReleased):
                    let data = tobeReleased.map { data in
                        infoView(
                            name: data.name ?? "",
                            brand: data.d2Category ?? "",
                            image: data.image ?? ""
                        )
                    }
                case .homeCafe(let homeCafe):
                    let data = homeCafe.map { data in
                        infoView(name: data.name ?? "",
                                 brand: data.brand ?? "",
                                 image: data.image ?? ""
                        )
                    }
                }
            }
        }
        .onTapGesture {
            action?()
        }
    }
    
    @ViewBuilder
    func infoView(name: String, brand: String, image: String) -> some View {
        ZSText(name, fontType: .body3, color: Color.neutral500)
            .lineLimit(1)
        
        ZSText(brand, fontType: .subtitle2, color: Color.neutral900)
            .lineLimit(2)
        
        HStack(spacing: 2) {
            KFImage(URL(string: image))
                .resizable()
                .frame(width: 16, height: 16)
//            ZerosomeAsset.ic_star_fill
//                .resizable()
//                .frame(width: 16, height: 16)
            Text("0")
            Text("(0)")
        }
        .applyFont(font: .body3)
        .foregroundStyle(Color.neutral400)
    }
}

extension ProductPreviewComponent {
    func tap(_ action: @escaping (() -> Void)) -> Self {
        var copy = self
        copy.action = action
        return copy
    }
}
