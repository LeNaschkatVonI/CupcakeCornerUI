//
//  Order.swift
//  CupcakeCornerUI
//
//  Created by Максим Нуждин on 20.06.2021.
//

import Foundation

class Order: ObservableObject {
    static let types = ["vanilla", "chocolate", "strawberry", "banana", "melon"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var isSpecialOrder = false {
        didSet {
            if !isSpecialOrder {
                addSprinkle = false
                extraFrosting = false
            }
        }
    }
    @Published var addSprinkle = false
    @Published var extraFrosting = false
    
    @Published var name = ""
    @Published var city = ""
    @Published var streetName = ""
    @Published var zip = ""
    
    var hasValidAdress: Bool {
        if name.count < 2 || city.isEmpty || streetName.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
}
