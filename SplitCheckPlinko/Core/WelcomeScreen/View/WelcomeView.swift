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
        ZStack {
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                if isShowHomeView {
                    HomeView()
                } else {
                    WelcomeSubView()
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation {
                        isShowHomeView = true
                    }
                }
            }
        }
    }
    
}

#Preview {
    WelcomeView()
}
