//
//  CheckoutView.swift
//  CupcakeCornerUI
//
//  Created by Максим Нуждин on 21.06.2021.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    @State private var confirmationMessage: String = ""
    @State private var confirmationTitle: String = ""
    @State private var showingConfirmation: Bool = false
    
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
                        self.placeOrder()
                    }
                }
            }
            .navigationBarTitle("check out", displayMode: .inline)
            .alert(isPresented: $showingConfirmation, content: {
                Alert(title: Text(confirmationTitle), message: Text(confirmationMessage), dismissButton: .default(Text("dismiss")))
            })
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    func placeOrder() {
        let encoder = JSONEncoder()
        guard let encoded = try? encoder.encode(order) else {
            print("Failure to encode an order")
            confirmationTitle = "That`s was an error"
            confirmationMessage = "There is a problem, occured during load process: Can`t load your order. Please contact to support."
            showingConfirmation = true
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("connection problem: \(error?.localizedDescription ?? "nil")")
                confirmationTitle = "That`s was an error"
                confirmationMessage = "There is a problem with proceed input data. Error: \(String(describing: error!.localizedDescription)). Please contact to support."
                showingConfirmation = true
                return
            }
            
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                confirmationTitle = "Thank you <3"
                self.confirmationMessage = "Your order for \(decodedOrder.quantity) * \(Order.types[decodedOrder.type]) cost \(decodedOrder.cost) is on the way"
                self.showingConfirmation = true
                print("success")
            } else {
                print("Invalid response from the server")
                confirmationTitle = "That`s was an error"
                confirmationMessage = "Unexpected error, please contact to support"
                showingConfirmation = true
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
