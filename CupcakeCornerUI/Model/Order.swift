//
//  Order.swift
//  CupcakeCornerUI
//
//  Created by Максим Нуждин on 20.06.2021.
//

import Foundation

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, addSprinkle, extraFrosting, name, city, streetName, zip
    }
    
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
    
    var cost: Double {
        var cost = Double(quantity) * 3
        cost += Double(type) / 2
        if extraFrosting {
            cost += Double(quantity) / 2
        }
        if addSprinkle {
            cost += Double(quantity) / 3
        }
        return cost
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        addSprinkle = try container.decode(Bool.self, forKey: .addSprinkle)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        
        name = try container.decode(String.self, forKey: .name)
        city = try container.decode(String.self, forKey: .city)
        streetName = try container.decode(String.self, forKey: .streetName)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(addSprinkle, forKey: .addSprinkle)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        
        try container.encode(name, forKey: .name)
        try container.encode(city, forKey: .city)
        try container.encode(streetName, forKey: .streetName)
        try container.encode(zip, forKey: .zip)
    }
}
