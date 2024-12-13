//
//  UserDetailsView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 13.12.2024.
//

import SwiftUI

struct UserDetailsView: View {
    @State var user: User
    @State var isPlusButtonPressed: Bool = false
    @State var productName: String = ""
    @State var countOfProduct: String = "1"
    @State var price: Double = 0
    
    var body: some View {
        VStack {
            //header
            VStack {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 100, height: 100)
                
                Text(user.userName)
                    .font(.system(size: 35))
                    .fontWeight(.bold)
            }
            
            // price for this user
            HStack {
                Text("Total Price: ")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text("12.85$")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            if user.orderedProducts.isEmpty {
                VStack {
                    
                    VStack {
                        Text("There's nothing yet")
                            .font(.title2)
                        
                        Text("Click on the plus button to add a product")
                            .font(.footnote)
                    }
                    .padding(.top, 70)
                    
                    Spacer()
                }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        // Заголовок таблицы
                        HStack {
                            Text("Product")
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("Price")
                                .fontWeight(.bold)
                                .frame(width: 60, alignment: .trailing)
                            Text("Qty")
                                .fontWeight(.bold)
                                .frame(width: 40, alignment: .trailing)
                        }
                        Divider()
                        
                        ForEach(user.orderedProducts){ item in
                            HStack {
                                Text(item.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                Text("\(String(format: "%.2f", item.price))$")
                                    .frame(width: 80, alignment: .trailing)
                                
                                Text("\(item.count)")
                                    .frame(width: 40, alignment: .trailing)
                            }
                            .font(.system(size: 20))
                            Divider()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
                .scrollIndicators(.hidden)
                .padding(.vertical)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "plus")
                    .frame(width: 30, height: 30)
                    .tint(Color.black)
                    .onTapGesture {
                        isPlusButtonPressed = true                    }
            }
        }
        .alert("Add Ordered Product", isPresented: $isPlusButtonPressed) {
            TextField("Product name...", text: $productName)
            
            TextField("Product count...", text: $countOfProduct)
            
            Button("Cancel", role: .cancel) {
                withAnimation {
                    countOfProduct = "1"
                    productName = ""
                    price = 0.0
                    isPlusButtonPressed = false
                }
            }
            
            Button("OK") {
                withAnimation {
                    user.orderedProducts.append(OrderedProduct(name: productName, price: 10.0, count: 1))
                    CoreDataManager.shared.updateUserName(user: user)
                    
                    countOfProduct = "1"
                    productName = ""
                    price = 0.0
                    isPlusButtonPressed = false
                }
            }
        }
    }
}

//#Preview {
//    UserDetailsView()
//}
