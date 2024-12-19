//
//  OrderedProductCellView.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 18.12.2024.
//

import SwiftUI

struct OrderedProductCellView: View {
    @StateObject var viewModel = HomeViewModel.shared
    var user: User
    var orderedProduct: OrderedProduct
    
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                HStack {
                    Text(orderedProduct.name)
                        .frame(width: 150, height: 40, alignment: .leading)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, -50)
                        .background {
                            Image("background-ordered-product-cell-1")
                        }
                    
                    Text("\(orderedProduct.count)")
                        .frame(width: 30, height: 40)
                    
                    Text("\(String(format: "%.1f", orderedProduct.price))$")
                        .frame(width: 55 ,height: 43 )
                        .frame(minWidth: 43)
                        .background {
                            Image("background-ordered-product-cell-2")
                        }
                }
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundStyle(.white)
                
                Button {
                    withAnimation {
                        viewModel.deleteProduct(user: user, idProduct: orderedProduct.id)
                        viewModel.getCoreData()
                    }
                } label: {
                    Image("basket-button")
                }
                .padding(.leading, 8)
            }
            .padding(.leading, 100)
        }
        .frame(width: UIScreen.main.bounds.width, height: 60)
    }
}

#Preview {
    OrderedProductCellView(user: User(userName: "Ilya"), orderedProduct: OrderedProduct(name: "Pizza", price: 10.0, count: 2))
}
