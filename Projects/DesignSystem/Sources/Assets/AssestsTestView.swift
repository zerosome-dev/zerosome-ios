//
//  AssestsTestView.swift
//  DesignSystem
//
//  Created by 박서연 on 2024/06/18.
//  Copyright © 2024 iOS. All rights reserved.
//

import SwiftUI

struct AssestsTestView: View {
    var body: some View {
        VStack {
            ZerosomeTab.ic_home
            ZerosomeAsset.zero_progress
        }
        .background(.green)
    }
}

#Preview {
    AssestsTestView()
}
