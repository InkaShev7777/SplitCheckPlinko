//
//  CustomAddProductAlertView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 17.12.2024.
//

import SwiftUI

struct CustomAddProductAlertView: View {
    @State var user: User
    @State var nameProduct: String = ""
    @State var textPriceProduct: String = "0"
    @State var priceProduct: Double = 0.0
    @State var countOfProduct: Int = 1
    
    @Binding var isShowAlert: Bool
    
    var body: some View {
        ZStack {
            Image("background-add-product-alert")
            
            VStack {
                Text("Enter dishes name and price:")
                    .foregroundStyle(.white)
                    .font(.system(size: 23))
                    .fontWeight(.bold)
                
                VStack {
                    HStack {
                        TextField("", text: $nameProduct)
                            .frame(width: 140, height: 49)
                            .font(.title2)
                            .fontWeight(.bold)
                            .tint(.white)
                            .background {
                                Image("background-product-1")
                                    .resizable()
                                    .scaledToFill()
                            }
                        
                        HStack {
                            TextField("", text: Binding(
                                get: { textPriceProduct },
                                set: { newValue in
                                    textPriceProduct = newValue.filter { "0123456789.".contains($0) }
                                    
                                    let components = textPriceProduct.split(separator: ".")
                                    if components.count > 2 {
                                        textPriceProduct = components[0] + "." + components[1]
                                    }
                                    
                                    priceProduct = Double(textPriceProduct) ?? 0.0
                                }
                            ))
                                .frame(width: 55, height: 49)
                                .keyboardType(.numberPad)
                                .font(.title2)
                                .fontWeight(.bold)
                                .tint(.white)
                                .background {
                                    Image("background-product-2")
                                        .resizable()
                                        .scaledToFill()
                                }
                            
                            Text("$")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.leading, -25)
                        }
                        .padding(.leading, -20)
                        
                        HStack {
                            Text("-")
                                .font(.title2)
                                .fontWeight(.bold)
                                .onTapGesture {
                                    withAnimation {
                                        if countOfProduct >= 2 {
                                            countOfProduct -= 1
                                        }
                                    }
                                }
                            
                            Text("\(countOfProduct)")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            Text("+")
                                .font(.title2)
                                .fontWeight(.bold)
                                .onTapGesture {
                                    withAnimation {
                                        countOfProduct += 1
                                    }
                                }
                        }
                    }
                    .padding(.leading, 70)
                }
                
                HStack {
                    Button {
                        withAnimation {
                            isShowAlert = false
                            nameProduct = ""
                            countOfProduct = 1
                            textPriceProduct = "0"
                        }
                    } label: {
                        Image("button-cancel")
                            .frame(width: 150, height: 90)
                    }
                    
                    Button {
                        withAnimation {
                            isShowAlert = false
                            if !nameProduct.isEmpty && priceProduct > 0 {
                                user.orderedProducts.append(OrderedProduct(
                                    name: nameProduct,
                                    price: priceProduct,
                                    count: countOfProduct)
                                )
                                user.totalPrice = calculateTotalSum(for: user.orderedProducts)
                                CoreDataManager.shared.updateUserName(user: user)
                            }
                            
                            nameProduct = ""
                            countOfProduct = 1
                            textPriceProduct = "0"
                        }
                    } label: {
                        Image("button-save")
                            .frame(width: 150, height: 90)
                    }
                }
            }
            .padding(.vertical)
            .foregroundStyle(.white)
        }
    }
}

//#Preview {
//    CustomAddProductAlertView(isShowAlert: true)
//}
