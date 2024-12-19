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
            VStack {
                Image("icon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaledToFill()
                
                Text("Split Check Blinko")
                    .font(.system(size: 44))
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
            }
            .padding(.bottom, 100)
            
        }
    }
}

#Preview {
    WelcomeSubView()
}
