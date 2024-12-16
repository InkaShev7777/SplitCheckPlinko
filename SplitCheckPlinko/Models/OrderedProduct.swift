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
    
    init( name: String, price: Double, count: Int) {
        self.id = UUID().uuidString
        self.name = name
        self.price = price
        self.count = count
    }
}
