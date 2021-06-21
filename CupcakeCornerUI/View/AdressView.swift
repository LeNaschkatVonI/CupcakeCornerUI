//
//  AdressView.swift
//  CupcakeCornerUI
//
//  Created by Максим Нуждин on 21.06.2021.
//

import SwiftUI

struct AdressView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("name", text: $order.name)
                TextField("city", text: $order.city)
                TextField("street Adress", text: $order.streetName)
                TextField("zip", text: $order.zip).keyboardType(.numberPad)
            }
            Section {
                NavigationLink(destination: CheckoutView(order: order)) {
                    Text("go to checkout page")
                }
            }.disabled(!order.hasValidAdress)
        }
    }
}

struct AdressView_Previews: PreviewProvider {
    static var previews: some View {
        AdressView(order: Order())
    }
}
