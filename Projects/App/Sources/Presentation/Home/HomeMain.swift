//
//  HomeMain.swift
//  App
//
//  Created by 박서연 on 2024/06/05.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct HomeMain: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color.gray)
                .frame(maxWidth: .infinity)
                .frame(height: 200)
                
            
            Text("출시 예정 신상품")
            
            Text("새롭게 발매된 상품과 발매 예정 상품을 확인해보세요")
        }
    }
}

#Preview {
    HomeMain()
}
