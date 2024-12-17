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
                    }
                } label: {
                    Image("button-plus")
                        .frame(width: 60, height: 60)
                }
                .padding(.horizontal, 20)
            }
        }
    }
}

//#Preview {
//    PlusButtonSubView(isShowAlert: <#Binding<Bool>#>)
//}
