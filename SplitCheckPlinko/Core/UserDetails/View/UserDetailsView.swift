//
//  UserDetailsView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 13.12.2024.
//

import SwiftUI

struct UserDetailsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var user: User
    
    @State var showAddProductAlert: Bool = false
    @State var showDeleteAlert: Bool = false
    
    @State var productName: String = ""
    @State var countOfProduct: String = "1"
    @State var price: Double = 0
    
    var body: some View {
        ZStack {
             Image("background")
                .resizable()
                .ignoresSafeArea()
            
            if showAddProductAlert {
                CustomAddProductAlertView(user: user, isShowAlert: $showAddProductAlert)
                    .zIndex(10)
            }
            
            if showDeleteAlert {
                CustomDeleteUserAlert(isShowDeleteAlert: $showDeleteAlert, user: user)
                    
            }
            
            VStack {
                //header
                VStack {
                    Image("user-icon")
                        .resizable()
                        .frame(width: 100, height: 100)
                    
                    Text(user.userName)
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                }
                
                //list of products
                VStack {
                    VStack {
                        Text("Orders list")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(7)
                        
                        Text("Total price: \(String(format: "%.2f", user.totalPrice))$")
                            .font(.system(size: 18))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    
                    VStack {
                        ScrollView {
                            ForEach(user.orderedProducts){ prod in
                                OrderedProductCellView(user: user, orderedProduct: prod)
                            }
                        }
                    }
                }
                .background(Color("background-color").scaledToFill().ignoresSafeArea())
                .frame(width: UIScreen.main.bounds.width)
                .padding(.top)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    } label: {
                        Image("back-button")
                    }
                    .frame(width: 40, height: 40)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showAddProductAlert = true
                    } label: {
                        Image("plus-button")
                    }
                    .frame(width: 40, height: 40)
                    .padding(.top, 20)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showDeleteAlert = true
                    } label: {
                        Image("basket-button")
                    }
                    .frame(width: 40, height: 40)
                }   
            }
        }
        .navigationBarBackButtonHidden()
    }
}

func calculateTotalSum(for items: [OrderedProduct]) -> Double {
    var totalSum: Double = 0.0
    for item in items {
        totalSum += Double(item.price) * Double(item.count)
    }
    return totalSum
}

#Preview {
    UserDetailsView(user: User(userName: "Vlad"))
}
