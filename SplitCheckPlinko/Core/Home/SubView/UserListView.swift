//
//  UserListView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 12.12.2024.
//

import SwiftUI

struct UserListView: View {
    @Binding var usersList: [String]
    
    var body: some View {
        VStack {
            ForEach(0 ..< usersList.count, id: \.self){ user in
                UserCardCellView(userName: usersList[user])
            }
        }
    }
}

//#Preview {
//    UserListView(usersList: [""])
//}
