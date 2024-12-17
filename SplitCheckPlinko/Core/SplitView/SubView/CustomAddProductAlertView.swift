//
//  CustomAddProductAlertView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 17.12.2024.
//

import SwiftUI

struct CustomAddProductAlertView: View {
    @State var nameProduct: String = ""
    @State var priceProduct: String = "10"
    @State var countOfProduct: Int = 1
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
                            TextField("", text: $priceProduct)
                                .frame(width: 55, height: 49)
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
                        
                    } label: {
                        Image("button-cancel")
                            .frame(width: 150, height: 90)
                    }
                    
                    Button {
                        
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

#Preview {
    CustomAddProductAlertView()
}
