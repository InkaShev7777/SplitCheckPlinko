//
//  EmptyHomeView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct EmptyHomeView: View {
    @StateObject var viewModel = HomeViewModel.shared
    
    @Binding var isShowAlert: Bool
    
    var body: some View {
        ZStack {
            Spacer()
            
            VStack(spacing: -5) {
                Text("You must add users to continue")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                
                Button {
                    isShowAlert = true
                } label: {
                    Image("button-add-user")
                }
            }
            Spacer()
        }
        .background(.clear)
    }
}

#Preview {
    EmptyHomeView(isShowAlert: .constant(true))
}
