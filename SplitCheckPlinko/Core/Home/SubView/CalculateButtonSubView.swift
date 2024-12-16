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
                Text("Calculate")
                    .font(.title3)
                    .foregroundStyle(Color.white)
            }
            .frame(width: 150, height: 60)
            .background(Color.black)
            .cornerRadius(7.0)
            .padding(.horizontal)
        }
    }
}

#Preview {
    CalculateButtonSubView()
}
