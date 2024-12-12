//
//  UserListView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct UserListView: View {
    @Binding var usersList: [User]
    
    var body: some View {
        VStack {
            ForEach(usersList){ user in
                UserCardCellView(userName: user.userName)
            }
        }
    }
}

//#Preview {
//    UserListView(usersList: [""])
//}
