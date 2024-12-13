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
        VStack {
            Spacer()
            
            Text("You must add users to continue")
                .font(.title2)
                .fontWeight(.semibold)
            
            Button {
                isShowAlert = true
            } label: {
                Text("Add User")
                    .font(.title2)
                    .frame(width: 150, height: 40)
                    .background(Color.gray)
                    .cornerRadius(7.0)
                    .tint(Color.white)
            }
            Spacer()
        }
    }
}

//#Preview {
//    EmptyHomeView()
//}
