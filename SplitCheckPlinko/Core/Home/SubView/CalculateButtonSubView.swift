//
//  CalculateButtonSubView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import SwiftUI

struct CalculateButtonSubView: View {
    var body: some View {
        VStack {
            Spacer()
            NavigationLink {
                SplitView()
            } label: {
                Image("button-calculate")
            }
            .frame(width: 150, height: 60)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CalculateButtonSubView()
}
