//
//  PlusButtonSubView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct PlusButtonSubView: View {
    @Binding var isShowAlert: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                Button {
                    // action
                    withAnimation {
                        isShowAlert = true
                        print("DEBUG: isShowAler: \(isShowAlert)")
                    }
                } label: {
                    Image(systemName: "plus")
                        .frame(width: 60, height: 60)
                        .background(Color.black)
                        .foregroundStyle(Color.white)
                        .cornerRadius(50)
                        .font(.title2)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

//#Preview {
//    PlusButtonSubView(isShowAlert: <#Binding<Bool>#>)
//}
