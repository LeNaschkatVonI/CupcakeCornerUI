//
//  ContentView.swift
//  CupcakeCornerUI
//
//  Created by Максим Нуждин on 19.06.2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("select your cake type", selection: $order.type) {
                        ForEach(0..<Order.types.count) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper(value: $order.quantity, in: 3...10) {
                        Text("Number of cakes: \(order.quantity)")
                    }
                }
                Section {
                    Toggle(isOn: $order.isSpecialOrder.animation(), label: {
                        Text("any special order?")
                    })
                    
                    if order.isSpecialOrder {
                        Toggle(isOn: $order.extraFrosting, label: {
                            Text("Add extra frostling?")
                        })
                        Toggle(isOn: $order.addSprinkle, label: {
                            Text("Add sprinkle?")
                        })
                    }
                }
                Section {
                    NavigationLink(
                        destination: AdressView(order: order)) {
                            Text("go to details")
                        }
                }
            }
            .navigationBarTitle("CupcakeCorner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
