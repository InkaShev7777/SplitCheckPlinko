//
//  UserListView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct UserListView: View {
    @Binding var usersList: [User]
    @Binding var isShowPlusButton: Bool
    
    var body: some View {
        VStack {
            ForEach(usersList){ user in
                UserCardCellView(user: user)
                    .padding(.horizontal)
            }
        }
        .zIndex(5)
    }
}

//#Preview {
//    UserListView(usersList: [""])
//}
