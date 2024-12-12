//
//  PlusButtonSubView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct PlusButtonSubView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                
                Button {
                    // action
                    withAnimation {
                        CoreDataManager.shared.addUser(user: User(userName: "Ilya1"))
                        HomeViewModel.shared.getCoreData()
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

#Preview {
    PlusButtonSubView()
}
