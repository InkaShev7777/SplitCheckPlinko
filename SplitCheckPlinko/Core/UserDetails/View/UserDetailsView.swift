//
//  UserDetailsView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 13.12.2024.
//

import SwiftUI

struct UserDetailsView: View {
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
                    Text("Total Price:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("\(String(format: "%.2f", user.totalPrice))$")
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
                                Text("Action")
                                    .fontWeight(.bold)
                                    .frame(width: 70, alignment: .trailing)
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
                                    
                                    Button {
                                        //action delete product from list ordered products.
                                        HomeViewModel.shared.deleteProduct(user: user, idProduct: item.id)
                                    } label: {
                                        Text("Delete")
                                    }
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
            .foregroundStyle(.white)
            .onAppear {
                user.totalPrice = calculateTotalSum(for: user.orderedProducts)
                print("Total now: \(user.totalPrice)")
                CoreDataManager.shared.updateUserName(user: user)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "plus")
                        .frame(width: 30, height: 30)
                        .tint(Color.black)
                        .onTapGesture {
                            withAnimation {
                                showAddProductAlert = true
                            }
                        }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "trash")
                        .frame(width: 30, height: 30)
                        .tint(Color.black)
                        .onTapGesture {
                            withAnimation {
                                showDeleteAlert = true
                            }
                        }
                }
            }
            .alert("Delete \(user.userName)", isPresented: $showDeleteAlert) {
                
                Button("Cancel", role: .cancel) {
                    withAnimation {
                        showDeleteAlert = false
                    }
                }
                
                Button("OK") {
                    withAnimation {
                        HomeViewModel.shared.deleteUser(user: user)
                        showDeleteAlert = false
                    }
                }
            }
        }
    }
}

func calculateTotalSum(for items: [OrderedProduct]) -> Double {
    var totalSum: Double = 0.0
    for item in items {
        totalSum += Double(item.price) * Double(item.count)
    }
    return totalSum
}

//#Preview {
//    UserDetailsView()
//}
