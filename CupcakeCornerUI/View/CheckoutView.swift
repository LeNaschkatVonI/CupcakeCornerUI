//
//  CheckoutView.swift
//  CupcakeCornerUI
//
//  Created by Максим Нуждин on 21.06.2021.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    
                    Text("Your order is cost \(order.cost, specifier: "%.2f")$")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                    Button("order") {
                        //
                    }
                }
            }
            .navigationBarTitle("check out", displayMode: .inline)
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
