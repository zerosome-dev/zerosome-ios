//
//  ReviewListView.swift
//  App
//
//  Created by 박서연 on 2024/06/08.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct ReviewListView: View {
    @State var plus: Bool = false
    let text = "계절이 지나가는 하늘에는 가을로 가득 차 있습니다. 나는 아무 걱정도 없이 가을 속의 별"
    
    var body: some View {
        VStack {
            ReviewScoreComponent()
            
            List(0..<10, id: \.self) { index in
                VStack {
                    VStack {
                        HStack {
                            Text("닉네임닉네임닉네임닉네임")
                            Spacer()
                            Text("2024.10.11")
                                .foregroundStyle(Color.neutral400)
                        }
                        HStack(spacing: 4) {
                            Image(systemName: "star")
                            Text("4.0")
                                .applyFont(font: .body1)
                        }
                    }
                    
//                    Text(text)
//                        .lineLimit(plus ? 3 : 0)
//                    
//                    HStack {
//                        Image(systemName: "circle")
//                        Spacer()
//                        Text("시용자 닉네임")
//                    }
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    ReviewListView()
}
