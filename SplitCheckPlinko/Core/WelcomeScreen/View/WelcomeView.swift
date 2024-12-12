//
//  ContentView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct WelcomeView: View {
    @State var isShowHomeView: Bool = false
    
    var body: some View {
        VStack {
            if isShowHomeView {
                HomeView()
            } else {
                WelcomeSubView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    isShowHomeView = true
                }
            }
        }
    }
    
}

#Preview {
    WelcomeView()
}
