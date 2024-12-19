//
//  CustomPayAlertView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 17.12.2024.
//

import SwiftUI

struct CustomPayAlertView: View {
    @Environment(\.dismiss) private var dismiss
    
    @Binding var showWinderAlert: Bool
    var userName: String
    var totalPrice: Double
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(userName) pay the bill")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                
                Text(String(format: "%.2f$", totalPrice))
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                
                Button {
                    // action
                    withAnimation {
                        dismiss()
                        showWinderAlert = false
                    }
                } label: {
                    Image("button-ok")
                }
                .padding(.top,-25)
                .padding(.bottom, -25)
            }
            .foregroundStyle(.white)
        }
        .background {
            Image("background-pay-alert")
        }
    }
}

//#Preview {
//    CustomPayAlertView(showWinderAlert: Binding<true>, userName: "Mark", totalPrice: 150.0)
//}
