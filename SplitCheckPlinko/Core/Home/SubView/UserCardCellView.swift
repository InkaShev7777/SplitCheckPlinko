//
//  UserCardCellView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct UserCardCellView: View {
    var userName: String
    
    var body: some View {
        VStack {
            VStack {
                Text(userName)
                    .font(.title)
                    .fontWeight(.semibold)
                
                Button {
                    // action
                    print("DEBUG: More Info Button")
                } label: {
                    Text("More Info")
                }
                .padding(.top, 1)
            }
            .frame(width: 250, height: 200)
            .background(Color.gray)
            .cornerRadius(7.0)
        }
        .frame(width: UIScreen.main.bounds.width)
        .padding()
        
    }
}

#Preview {
    UserCardCellView(userName: "Ilya")
}