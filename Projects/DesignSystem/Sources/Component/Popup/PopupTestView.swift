//
//  PopupTestView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct PopupTestView: View {
    @State private var isShowing: Bool = false
    @State private var isShowingD: Bool = false
    
    var body: some View {
        ScrollView {
            Text("FirstButton 팝업 테스트")
                .onTapGesture {
                    isShowing.toggle()
                }
                .padding(.vertical, 30)
            
            Text("DoubleButotn 팝업 테스트")
                .onTapGesture {
                    isShowingD.toggle()
                }
                .padding(.vertical, 30)
            
            ForEach(0..<30, id: \.self) { index in
                Text("\(index)")
                    .font(.headline)
            }
        }
        .scrollIndicators(.hidden)
        .ZAlert(isShowing: $isShowing,
                type: .singleButton(title: "안녕하세요", button: "취소"),
                leftAction: {
            isShowing.toggle()
        })
        
        .ZAlert(isShowing: $isShowingD, type: .doubleButton(title: "안녕하세요",
                                                            LButton: "왼쪽",
                                                            RButton: "오른쪽")) {
            debugPrint("왼쪽 버튼 tapped!")
            isShowingD.toggle()
        } rightAction: {
            debugPrint("오른쪽 버튼 tapped!")
            isShowingD.toggle()
        }

    }
}

#Preview {
    PopupTestView()
}
