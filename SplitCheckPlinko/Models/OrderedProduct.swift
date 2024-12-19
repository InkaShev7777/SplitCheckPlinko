//
//  OrderedProduct.swift
//  SplitCheckPlinko
//
//  Created by Ilya Schevchenko on 13.12.2024.
//

import Foundation

class OrderedProduct: Identifiable, Decodable, Encodable {
    var id: String
    var name: String
    var price: Double
    var count: Int
    
    init(id: String = UUID().uuidString, name: String, price: Double, count: Int) {
        self.id = id
        self.name = name
        self.price = price
        self.count = count
    }
}
