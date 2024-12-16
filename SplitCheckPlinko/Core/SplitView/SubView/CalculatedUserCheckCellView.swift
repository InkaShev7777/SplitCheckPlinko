//
//  CalculatedUserCheckCellView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 16.12.2024.
//

import SwiftUI

struct CalculatedUserCheckCellView: View {
    var userName: String
    var totalPrice: Double
    
    var body: some View {
        VStack {
            HStack {
                Text(userName)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 10)
                
                Spacer()
            }
            
            HStack {
                Spacer()
                
                Text("\(String(format: "%.2f", totalPrice))$")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal, 10)
            }
        }
        .frame(width: UIScreen.main.bounds.width - 60, height: 100)
        .background(Color.gray)
        .cornerRadius(7.0)
    }
}

//#Preview {
//    CalculatedUserCheckCellView()
//}
