//
//  ToastTestView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/07/13.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

class ToastTestVM: ObservableObject {
    @Published var isShowing: Bool = false
}

struct ToastTestView: View {
    @StateObject private var vm = ToastTestVM()
    
    var body: some View {
        ScrollView {
            Text("Toast View Test")
                .onTapGesture {
                    vm.isShowing = true
                }
            
            ForEach(0..<30, id: \.self) { index in
                Text("\(index)")
                    .padding(.vertical, 20)
            }
            
        }
        .ZToast($vm.isShowing,
                .success,
                "성공 토스트입니다.")
    }
}

#Preview {
    ToastTestView()
}
