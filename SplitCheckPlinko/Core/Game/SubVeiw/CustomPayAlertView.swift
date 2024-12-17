//
//  CustomPayAlertView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 17.12.2024.
//

import SwiftUI

struct CustomPayAlertView: View {
    var userName: String
    var totalPrice: Double
    var body: some View {
        ZStack {
            VStack {
                Text("\(userName) pay the bill")
                    .font(.system(size: 32))
                
                Text(String(format: "%.2f$", totalPrice))
            }
            .foregroundStyle(.white)
        }
        .background {
            Image("background-pay-alert")
        }
    }
}

#Preview {
    CustomPayAlertView(userName: "Mark", totalPrice: 150.0)
}
