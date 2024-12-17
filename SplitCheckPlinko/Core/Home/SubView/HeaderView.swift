//
//  HeaderView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 17.12.2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Orders")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                    
                    Text("\(HomeViewModel.shared.currentDateFormatted())")
                        .font(.system(size: 20))
                        .foregroundStyle(Color.gray)
                }
                Spacer()
                Image("Vector")
            }
            .padding(.horizontal)
        }
//        .background(Color.gray)
    }
}

#Preview {
    HeaderView()
}
