//
//  WelcomeSubView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct WelcomeSubView: View {
    var body: some View {
        VStack {
            Text("Split Check Blinko")
                .font(.system(size: 44))
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
        }
    }
}

#Preview {
    WelcomeSubView()
}
