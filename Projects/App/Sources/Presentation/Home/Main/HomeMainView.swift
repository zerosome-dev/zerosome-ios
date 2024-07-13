//
//  HomeMain.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI
import DesignSystem

struct HomeMainView: View {
    var body: some View {
        ScrollView {
            CustomInfiniteBanner(height: 240)
            .padding(.bottom, 30)

            VStack(spacing: 30) {
                HomeCategoryTitleView(title: "생수/음료",
                                      subTitle: "제로로 걱정 없이 즐기는 상쾌한 한 모금",
                                      type: .moreButton,
                                      paddingType: true,
                                      data: ZeroDrinkSampleData.drinkType) {
                    print("페이지 이동")
                }
                
                DivideRectangle(height: 12, color: Color.neutral50)
                
                HomeCategoryTitleView(title: "카페음료",
                                      subTitle: "카페에서 즐기는 제로",
                                      type: .moreButton,
                                      paddingType: true,
                                      data: ZeroDrinkSampleData.snackType)
                
            }
        }
    }
}

#Preview {
    HomeMainView()
}
